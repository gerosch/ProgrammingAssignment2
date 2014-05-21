###############################################################################
## Coursera Course: R Programming                                            ##
## Programming Assignment 02                                                 ##
###############################################################################
## R ##### Author: Gero Schmidt ###### Version: 1.00 ###### Date: 2014-05-20 ##
###############################################################################
## This code provides a pair of functions that cache the inverse of a matrix ##
## ------------------------------------------------------------------------- ##
## makeCacheMatrix():                                                        ##
##   Creates a special "matrix" object that can cache its inverse            ##
## cacheSolve():                                                             ## 
##   Computes the inverse of the matrix stored in the special "matrix"       ## 
##   object created by makeCacheMatrix(). If the inverse has already been    ##
##   calculated and stored in the special "matrix" object and the matrix has ##
##   not changed since then cacheSolve() retrieves the inverse from the      ##
##   object instead of recalculating it (using the cached value).            ##
##   Note: Like the underlying basic function solve() this function will     ##
##         exit with an error if the matrix is singular, i.e. not invertible ##
## ------------------------------------------------------------------------- ##
## For this assignment, assume that the matrix supplied is always invertible ##
###############################################################################
## Disclaimer: The sample code described herein is provided on an "as is"    ##
## basis, without warranty of any kind. The author does not warrant,         ##
## guarantee or make any representations regarding the use, results of use,  ##
## accuracy, timeliness or completeness of any data or information relating  ##
## to this code. The author disclaims all warranties, express or implied,    ##
## and in particular, disclaims all warranties of merchantability, fitness   ##
## for a particular purpose, and warranties related to the code, or any      ##
## service or software related thereto. The author shall not be liable for   ##
## any direct, indirect or consequential damages or costs of any type        ##
## arising out of any action taken by you or others related to this code.    ##
###############################################################################

## -----------------
## makeCacheMatrix()
## -----------------
## Creates a special "matrix" object that can cache its inverse 
## object$getmat()         : returns stored matrix
## object$setmat(matrix)   : stores matrix in object
## object$getinv()         : returns cached inverse of the matrix (returns NULL if undefined/not set)
## object$setinv(inverse)  : stores inverse of the matrix in object  
makeCacheMatrix <- function(x = matrix()) {
  x_inv <- NULL
  setmat <- function(y) {
    x <<- y
    x_inv <<- NULL
  }
  getmat <- function() x
  setinv <- function(inverse) x_inv <<- inverse
  getinv <- function() x_inv
  list(setmat = setmat, getmat = getmat,
       setinv = setinv,
       getinv = getinv)
}

## ------------
## cacheSolve()
## ------------
## Computes the inverse of the matrix stored in the special "matrix" object returned by makeCacheMatrix()
## If the inverse has already been calculated and the matrix has not changed then 
## the cacheSolve() retrieves the inverse matrix from the cache   
cacheSolve <- function(x, ...) {
  inverse <- x$getinv()
  # Check if inverse matrix is already chached in object from previous calculation
  # YES (inverse<>NULL): return cached value of inverse matrix
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  # NO (inverse==NULL): compute inverse of matrix, store result in object and return inverse
  message("newly calculating data")
  matrix <- x$getmat()
  inverse <- solve(matrix, ...)
  x$setinv(inverse)
  inverse
}