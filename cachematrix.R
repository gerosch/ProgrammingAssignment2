###############################################################################
## Coursera Course: R Programming                                            ##
## Programming Assignment 02                                                 ##
###############################################################################
## R ##### Author: Gero Schmidt ###### Version: 1.02 ###### Date: 2014-05-21 ##
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
##         exit with an error if the matrix is singular, i.e. non-invertible ##
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

## ------------------
## makeCacheMatrix(x)
## ------------------
## Creates a special "matrix" object that stores the given matrix and can cache its inverse 
## INPUT : x - regular matrix
## OUTPUT: object with
##  object$getmat()       : returns stored matrix
##  object$setmat(matrix) : stores <matrix> in object
##  object$getinv()       : returns cached inverse of the matrix if set (NULL if undefined)
##  object$setinv(inverse): stores <inverse> of the matrix in object  
makeCacheMatrix <- function(x = matrix()) {
  # Set inverse <x_inv> in object to NULL as default when initially invoked
  x_inv <- NULL
  # Define setmat(y) function to store provided matrix <y> in object as matrix <x> and 
  # clear inverse <x_inv> by setting it to NULL when a new matrix is stored in object
  setmat <- function(y) {
    x <<- y
    x_inv <<- NULL
  }
  # Define getmat() function to retrieve stored matrix <x> from object
  getmat <- function() x
  # Define setinv(inverse) function to store <inverse> in object as <x_inv>
  setinv <- function(inverse) x_inv <<- inverse
  # Define getinv() function to retrieve stored inverse <x_inv> from object
  getinv <- function() x_inv
  # Return defined functions for object
  list(setmat = setmat, 
       getmat = getmat,
       setinv = setinv,
       getinv = getinv)
}

## ------------
## cacheSolve()
## ------------
## Computes the inverse of the matrix <A> stored in the special "matrix" object <x> created by 
## x<-makeCacheMatrix(A). If the inverse has already been calculated and stored in the special 
## "matrix" object and the matrix has not changed since, then cacheSolve(x) retrieves the 
## inverse from the object instead of recalculating it (i.e. using the cached value).
## INPUT : x - special "matrix" object created by x<-makeCacheMatrix(A) for invertible matrix A
##         ... further arguments passed on to solve() function for calculating the inverse
## OUTPUT: inverse of the matrix <A> that is stored in special "matrix" object <x>
## Note: Like the underlying basic function solve() this function will exit with an error 
##       if the matrix A is singular, i.e. non-invertible.
cacheSolve <- function(x, ...) {
  inverse <- x$getinv()
  # Check if inverse is already chached in makeCacheMatrix() object from previous calculation
  # YES (inverse<>NULL): Return cached inverse from object
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  # NO (inverse==NULL): Compute inverse and store calculated inverse in object
  message("newly calculating data")
  matrix <- x$getmat()
  inverse <- solve(matrix, ...)
  x$setinv(inverse)
  # Return calculated inverse
  inverse
}