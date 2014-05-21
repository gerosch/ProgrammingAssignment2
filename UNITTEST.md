### Introduction

This document contains the results from a quick unit test of this assignment.
To easily create a (nxn)-matrix the additional package 'magic' has been used in this unit test. The command `magic(n)` creates an invertible (nxn)-matrix. 

### Unit Test Results

In this part the results from the unit test of the functions `makeCacheMatrix()` and `cacheSolve()` are provided.

<!-- -->

Sourcing the code from the assignment we create a 5x5 matrix A using `magic(5)`: 

      > source("../ProgrammingAssignment2/cachematrix.R")
      
      > library(magic)
      Loading required package: abind
      
      > A<-magic(5) ##  helps to easily create squared invertible matrices
      
      > A
           [,1] [,2] [,3] [,4] [,5]
      [1,]    9    2   25   18   11
      [2,]    3   21   19   12   10
      [3,]   22   20   13    6    4
      [4,]   16   14    7    5   23
      [5,]   15    8    1   24   17

We then create matrix B as a `makeCacheMatrix()` object from matrix A:

      > B<-makeCacheMatrix(A)

We check that the matrix is properly stored in the object B using the `getmat()` function and verify that the inverse is undefined (NULL) as it has not yet been calculated:

      > B$getmat()
           [,1] [,2] [,3] [,4] [,5]
      [1,]    9    2   25   18   11
      [2,]    3   21   19   12   10
      [3,]   22   20   13    6    4
      [4,]   16   14    7    5   23
      [5,]   15    8    1   24   17
      
      > B$getinv() 
      NULL

We then use `cacheSolve` to calculate the inverse of matrix A in object B and see that the inverse is newly calculated when the function is invoked for the first time:

      > cacheSolve(B)
      newly calculating data
                   [,1]         [,2]         [,3]         [,4]         [,5]
      [1,]  0.011089744 -0.045000000  0.041538462  0.005000000  0.002756410
      [2,] -0.036987179  0.043461538  0.010769231 -0.006538462  0.004679487
      [3,]  0.036410256  0.003076923  0.003076923  0.003076923 -0.030256410
      [4,]  0.001474359  0.012692308 -0.004615385 -0.037307692  0.043141026
      [5,]  0.003397436  0.001153846 -0.035384615  0.051153846 -0.004935897

When invoking the `cacheSolve()` function for the second time the inverse is taken from the cached data which is stored in the object B:

      > cacheSolve(B)
      getting cached data
                   [,1]         [,2]         [,3]         [,4]         [,5]
      [1,]  0.011089744 -0.045000000  0.041538462  0.005000000  0.002756410
      [2,] -0.036987179  0.043461538  0.010769231 -0.006538462  0.004679487
      [3,]  0.036410256  0.003076923  0.003076923  0.003076923 -0.030256410
      [4,]  0.001474359  0.012692308 -0.004615385 -0.037307692  0.043141026
      [5,]  0.003397436  0.001153846 -0.035384615  0.051153846 -0.004935897
      
We verify that the inverse is properly stored in the matrix object B:

      > B$getinv()
                   [,1]         [,2]         [,3]         [,4]         [,5]
      [1,]  0.011089744 -0.045000000  0.041538462  0.005000000  0.002756410
      [2,] -0.036987179  0.043461538  0.010769231 -0.006538462  0.004679487
      [3,]  0.036410256  0.003076923  0.003076923  0.003076923 -0.030256410
      [4,]  0.001474359  0.012692308 -0.004615385 -0.037307692  0.043141026
      [5,]  0.003397436  0.001153846 -0.035384615  0.051153846 -0.004935897

When we use the `setmat()` function of the object B to change the matrix in the object the inverse is cleared and set to NULL (undefined)

      > B$setmat(A)
      
      > B$getinv()
      NULL

A new call of `cacheSolve(B)` will now correctly trigger a new calculation of the inverse (as the matrix in the object has changed):
      
      > cacheSolve(B)
      newly calculating data
                   [,1]         [,2]         [,3]         [,4]         [,5]
      [1,]  0.011089744 -0.045000000  0.041538462  0.005000000  0.002756410
      [2,] -0.036987179  0.043461538  0.010769231 -0.006538462  0.004679487
      [3,]  0.036410256  0.003076923  0.003076923  0.003076923 -0.030256410
      [4,]  0.001474359  0.012692308 -0.004615385 -0.037307692  0.043141026
      [5,]  0.003397436  0.001153846 -0.035384615  0.051153846 -0.004935897

The second call of `cacheSolve(B)` will then retrieve the (already calculated) inverse from cache (i.e. from the data stored in the object):

      > cacheSolve(B)
      getting cached data
                   [,1]         [,2]         [,3]         [,4]         [,5]
      [1,]  0.011089744 -0.045000000  0.041538462  0.005000000  0.002756410
      [2,] -0.036987179  0.043461538  0.010769231 -0.006538462  0.004679487
      [3,]  0.036410256  0.003076923  0.003076923  0.003076923 -0.030256410
      [4,]  0.001474359  0.012692308 -0.004615385 -0.037307692  0.043141026
      [5,]  0.003397436  0.001153846 -0.035384615  0.051153846 -0.004935897

#### Test using the inverse as the initial matrix

When setting the inverse matrix as the initial matrix in object B with the `setmat()` function then the result of `cacheSolve()` should return the original matrix A from the beginning as inverse (of the inverse):

      > C<-cacheSolve(B)
      getting cached data
      
      > B$setmat(C) ## set inverse as initial matrix 
      
      > B$getinv()  ## matrix has changed / inverse is set to NULL
      NULL
      
      > cacheSolve(B) ## 1st call triggers new calculation
      newly calculating data
           [,1] [,2] [,3] [,4] [,5]
      [1,]    9    2   25   18   11
      [2,]    3   21   19   12   10
      [3,]   22   20   13    6    4
      [4,]   16   14    7    5   23
      [5,]   15    8    1   24   17
      
      > cacheSolve(B) ## 2nd call retrieves the cached data from object
      getting cached data
           [,1] [,2] [,3] [,4] [,5]
      [1,]    9    2   25   18   11
      [2,]    3   21   19   12   10
      [3,]   22   20   13    6    4
      [4,]   16   14    7    5   23
      [5,]   15    8    1   24   17
      
      ## inverse of the inverse gives the original matrix A

#### Failure test with non-invertible matrix

When using a non-invertible matrix for A then the `cacheSolve)()` function fails in the same way as the basic `solve()` function does:

      > a=1:5
      > b=3:7
      > c=7:11
      > d=2:6
      > e=5:9
      
      > A=cbind(a,b,c,d,e)
      
      > A
           a b  c d e
      [1,] 1 3  7 2 5
      [2,] 2 4  8 3 6
      [3,] 3 5  9 4 7
      [4,] 4 6 10 5 8
      [5,] 5 7 11 6 9
      
      > B=makeCacheMatrix(A)
      
      > cacheSolve(B)
      newly calculating data
       Show Traceback
       
       Rerun with Debug
       Error in solve.default(matrix, ...) : 
        Lapack routine dgesv: system is exactly singular: U[5,5] = 0 
      
      > solve(A)
      Error in solve.default(A) : 
        Lapack routine dgesv: system is exactly singular: U[5,5] = 0
