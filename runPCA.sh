#BSUB -J runPCA
#BSUB -o bsub_log/runPCA.o%J
#BSUB -e bsub_log/runPCA.e%J
#BSUB -q normal
#BSUB -n 2
#BSUB -R "rusage[mem=7500] span[hosts=1]"
#BSUB -u agr75@missouri.edu

### Exit on error
set -o errexit

### Do analysis in Rmarkdown
Rscript -e "rmarkdown::render('pca_script.Rmd')"