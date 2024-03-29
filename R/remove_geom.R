#' @title Remove a layer from a compiled ggplot2 object.
#' @export
#' @description Removes specified layers from a ggplot object.
#' @param p ggplot2 plot object
#' @param geom character string of the name of the layer to remove
#' @param idx numeric of which index of geom to remove, Default: 1
#' @examples
#' p <- ggplot2::ggplot(iris,ggplot2::aes(x =Sepal.Length,y=Sepal.Width))
#' p <- p+ggplot2::geom_point(ggplot2::aes(colour=Species))+ggplot2::geom_line()
#' p
#' pnew <- p |> remove_geom('point',1)
#' pnew

remove_geom <- function(p, geom, idx = NULL) {
  layers <- p$layers
  layer.type <- lapply(p$layers, function(x) class(x$geom))
  a.rm <- which(grepl(paste0("(?i)", geom), layer.type))

  if (length(a.rm) == 0) {
    
    stop(paste0("There are no ", geom, " layers available in the plot to remove"), call. = FALSE)
    
  }

  if (is.null(idx)){
    
    idx <- length(a.rm)
    
  }

  if (length(a.rm) >= idx) { 
    
    a.rm <- a.rm[idx]
    
  }
  
  layers <- layers[-a.rm]
  
  
  p$layers <- layers
  p
}
