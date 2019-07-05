#BSUB -J cutadapt                                    
#BSUB -o cutadapt.o%J                        
#BSUB -e cutadapt.e%J
#BSUB -q normal     
#BSUB -n 2
#BSUB -R "rusage[mem=64000] span[hosts=1]" 
#BSUB -u agr75@mail.missouri.edu                                                
##Cutadapt trimming
cutadapt -a GAGATCGGAAGAGCACACGTCTGAACTCCAGTCA -q 30 -e 0.1 -O 5 -m 73 -o /home/agr75/data/2017_Shoepeg_1/output.fastq.gz /home/agr75/data/2017_Shoepeg_1/input.fastq.gz 

##fastqc                                                                      
fastqc ./output.fastq.gz
