#BSUB -J Link_Imputation
#BSUB -o bsub_log/Link_Imputation.o%J
#BSUB -e bsub_log/Link_Imputation.e%J
#BSUB -q normal
#BSUB -x
#BSUB -R "rusage[mem=64000] span[hosts=1]"
#BSUB -u agr75@mail.missouri.edu

#Convert vcf to ped and map
vcftools --vcf input_file.vcf --plink --out output_file_name #(in ped and map file)

#Imputation
java -Xmx64g -jar LinkImpute.jar -q /home/agr75/data/analysis/Barcode_Filtered/Genotypes/Imputation_IX/input.ped /home/agr75/data/analysis/Barcode_Filtered/Genotypes/Imputation_IX/Output.ped  ###(extract the output in ped file, later open it in tassel with map file)