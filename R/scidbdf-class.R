#/*
#**
#* BEGIN_COPYRIGHT
#*
#* Copyright (C) 2008-2012 SciDB, Inc.
#*
#* SciDB is free software: you can redistribute it and/or modify it under the
#* terms of the GNU General Public License as published by the Free Software
#* Foundation version 3 of the License.
#*
#* This software is distributed "AS-IS" AND WITHOUT ANY WARRANTY OF ANY KIND,
#* INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY, NON-INFRINGEMENT, OR
#* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for the
#* complete license terms.
#*
#* You should have received a copy of the GNU General Public License
#* along with SciDB.  If not, see <http://www.gnu.org/licenses/>.
#*
#* END_COPYRIGHT
#*/

setClass("scidbdf",
         representation(call="call",
                        name="character",
                        D="list",
                        dim="numericOrNULL",
                        length="numeric",
                        attributes="character",
                        nullable="logical",
                        type="character",
                        types="character",
                        gc="environment"),
         S3methods=TRUE)

setGeneric("head")
setMethod("head", signature(x="scidbdf"),
function(x, n=6L, ...)
{
  iquery(sprintf("between(%s,%.0f,%.0f)",x@name,x@D$start,n),ret=TRUE)
})

setGeneric("tail")
setMethod("tail", signature(x="scidbdf"),
function(x, n=6L, ...)
{
  iquery(sprintf("between(%s,%.0f,%.0f)",x@name,x@D$start + x@D$length - n - 1,x@D$start + x@D$length-1),ret=TRUE)
})

setGeneric('is.scidbdf', function(x) standardGeneric('is.scidbdf'))
setMethod('is.scidbdf', signature(x='scidbdf'),
  function(x) return(TRUE))
setMethod('is.scidbdf', definition=function(x) return(FALSE))

setGeneric('print', function(x) standardGeneric('print'))
setMethod('print', signature(x='scidbdf'),
  function(x) {
    cat(sprintf("A data frame-like reference to the 1D SciDB array %s (%.0f rows).\n",x@name, x@D$length))
  })

setMethod('show', 'scidbdf',
  function(object) {
    cat(sprintf("A data frame-like reference to the 1D SciDB array %s (%.0f rows).\n",x@name, x@D$length))
  })