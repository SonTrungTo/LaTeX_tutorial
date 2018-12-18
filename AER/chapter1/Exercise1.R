?diag
#case i = 3,
A <- matrix(c(1,-1,0,0,2,0,0,-1,1), nrow = 3, ncol = 3)
#case i = 4, this is the general algorithm
A <- diag(rep(c(1,2,1),c(1,2,1)))
for (i in 2:3) {
  if(A[i,i-1] == A[i,i+1]) {A[i,i-1] = -1; A[i, i+1] = -1;}
}
