#BSUB -J discovery_and_production_pipeline                                    
#BSUB -o discovery_and_production_pipeline.o%J                        
#BSUB -e discovery_and_production_pipeline.e%J
#BSUB -q normal     
#BSUB -x
#BSUB -R "rusage[mem=64000] span[hosts=1]" 
#BSUB -u agr75@mail.missouri.edu                                                                   

### Load modules                                                                                    
###module load java_1.8                                                                          

### Set variables                                                                                         
tasselDir=/home/agr75/tassel-5-standalone/
reference=/home/agr75/data/2016_Shoepeg_0/MaizeV3/Zea_mays.AGPv3.28.dna.genome.fa
fastqDir=/home/agr75/data/2017_Shoepeg_1/
keyFile=/home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/Shoe1_keyfile.txt
dataBase=2017_Shoepeg_1.db
taxa=2017_Shoepeg
enzyme=ApeKI
minQual=20
minMaf=0.05
output=/home/agr75/data/analysis/17_Shoe_cycle_1/Genotypes/2017_Shoepeg_1.vcf



#GBSSeqToTagDBPlugin
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -GBSSeqToTagDBPlugin -e $enzyme -i $fastqDir -db $dataBase -k $keyFile -mnQS $minQual -runfork1

#TagExportToFastqPlugin
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -TagExportToFastqPlugin -db $dataBase -o /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.fa.gz -c 1 -runfork1

### Index reference (hopefully done already)
bwa index -a bwtsw $reference

### Align to reference
bwa aln -t 12 $reference /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.fa.gz > /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.sai

### Convert to SAM file
bwa samse $reference /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.sai /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.fa.gz > /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.sam

### SAMToGBSdbPlugin
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -SAMToGBSdbPlugin -i /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/tagsForAlign.sam -db $dataBase -aProp 0.0 -aLen 0 -endPlugin -runfork1

### DiscoverySNPCallerPluginV2
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -DiscoverySNPCallerPluginV2 -db $dataBase -sC 1 -eC 10 -mnLCov 0.1 -mnMAF $minMaf -deleteOldData true -endPlugin -runfork1

### SNPQualityProfilerPlugin
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -SNPQualityProfilerPlugin -db $dataBase -tname $taxa -statFile /home/agr75/data/analysis/17_Shoe_cycle_1/tasselFiles/outputStats.txt -deleteOldData true -endPlugin -runfork1

### Production SNP Caller
$tasselDir/run_pipeline.pl -Xmx64g -fork1 -ProductionSNPCallerPluginV2 -db $dataBase -e $enzyme -i $fastqDir -k $keyFile -kmerLength 64 -o $output -endPlugin -runfork1
