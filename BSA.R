
####First sort out the allele frequency into REF and ALT allele frequency and put them in one file

df <- read.delim("Combined.txt", header = T)

##### Calculate Genome Wide G statistics

getG <- function(LowRef, HighRef, LowAlt, HighAlt)
{
  exp <- c(
    (LowRef + HighRef) * (LowRef + LowAlt) / (LowRef + HighRef + LowAlt + HighAlt),
    (LowRef + HighRef) * (HighRef + HighAlt) / (LowRef + HighRef + LowAlt + HighAlt),
    (LowRef + LowAlt) * (LowAlt + HighAlt) / (LowRef + HighRef + LowAlt + HighAlt),
    (LowAlt + HighAlt) * (HighRef + HighAlt) / (LowRef + HighRef + LowAlt + HighAlt)
  )
  obs <- c(LowRef, HighRef, LowAlt, HighAlt)
  
  G <-
    2 * (rowSums(obs * log(
      matrix(obs, ncol = 4) / matrix(exp, ncol = 4)
    )))
  return(G)
}



