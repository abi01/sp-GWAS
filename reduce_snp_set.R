# prep data for PCA

library(stringr)

# format sample names
sample_names <- read.table("sample_names.txt")
sample_names <- sample_names$V1
sample_names <- as.data.frame(str_split_fixed(sample_names, "_", 2))
sample_names$V2 <- str_pad(sample_names$V2, 3, side="left", pad="0")
names_out <- paste(sample_names$V1, sample_names$V2, sep="_")

print(names_out)

# read in snp matrix
snp_matrix <- read.table("snp_matrix.txt")

# select a subset of 10000 snps
dim(snp_matrix)
index <- sample(1:nrow(snp_matrix), 10000)
new_snp_matrix <- snp_matrix[index,]

# keep position of the loci
loci <- new_snp_matrix[,1:2]
colnames(loci) <- c("scaffold", "position")
write.table(loci, "loci_positions.txt", row.names=FALSE)

# transpose matrix (rows = individuals, columns = loci)
new_snp_matrix <- new_snp_matrix[,3:ncol(new_snp_matrix)]
new_snp_matrix <- t(new_snp_matrix)

# add sample names
row.names(new_snp_matrix) <- names_out

# sort matrix by sample number
new_snp_matrix <- new_snp_matrix[order(rownames(new_snp_matrix)),]

dim(new_snp_matrix)
head(new_snp_matrix)

# export reduced snp matrix
write.table(new_snp_matrix, "reduced_snp_matrix.txt")