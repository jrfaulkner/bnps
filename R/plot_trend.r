#' Plot estimated trend and credible intervals
#'
#' Plot posterior median of trend parameters and associated credible intervals.
#' @param theta A list generated by \code{extract_theta} function.  If \code{theta} is specified, do not specify a value for \code{mfit}.
#' @param mfit An object containing posterior draws from a \code{bnps} or \code{stan} model fit.  The object can be of class \code{stanfit}, \code{array}, \code{matrix}, or \code{data.frame}.  Do not specify \code{theta} if \code{mfit} is specified.
#' @param obstype Name of probability distribution of observations.  This controls the back-transformation of the process parameters.  Possible obstypes are 'normal', 'poisson', or 'binomial'. Assumed link functions are the log for 'poisson' and logit for 'binomial'.
#' @param alpha Controls level for 100*(1-\code{alpha})\% Bayesian credible intervals.
#' @param obsvec Vector of observations. Assumed to be ordered by time with one observation per time point. If \code{obsvec} is NULL, then data are not plotted.
#' @param timelab Label for time variable.  Can be a numeric or character vector.  Must be the same length as observation vector (\code{y}).  If not specified, then a sequence from 1 to the total number of observations with unit time step is used.
#' @param colset Color set for trend and credible intervals.  These are presets chosen with common color combinations.  Choices are 'blue', 'purple', 'red', 'green', and 'gray'. This parameter is overridden If \code{trend.col} and \code{bci.col} are specified.
#' @param trend.col Color of the trend line.  Any standard \code{R} plotting colors are allowed. Use this along with \code{bci.col} if color choices other than the presets provided by colset are desired.
#' @param bci.col Color of the credible interval band. Any standard \code{R} colors are allowed.
#' @param pt.col  Color of data points if plotted with \code{obsvec} specified.
#' @param pt.pch  Type of points to use if data plotted with \code{obsvec} specified (see \code{points} for details.
#' @param pt.cex  Size of points to use if data plotted with \code{obsvec} specified (see \code{points} for details.
#' @param xlab Character string describing label for x-axis.  Default is "time" if unspecified.
#' @param ylab Character string describing label for y-axis.  Default is "y" if unspecified.
#' @param main Character string describing label for main title.  Default is "" empty string.
#' @param xlim Numeric vector with two elements describing limits of x-variable. Default is \code{range} of sequence from 1 to max length of elements in \code{theta} or number of rows in \code{mfit}.
#' @param ylim Numeric vector with two elements describing limits of y-variable. Default is \code{range} of combined vector of \code{obsvec} and extreme values of BCI's if unspecified.
#' @param ... Additional parameters passed to the \code{plot} function.
#' @details  The input can be either in the form of a list generated by the \code{extract_theta} function (passed in as the \code{theta} variable) or as a raw model fit object from \code{bnps} or \code{rstan} (passed in as \code{mfit}).  Note that using \code{mfit} is more computationally costly than using \code{theta} because the \code{extract_theta} function is called when \code{mfit} is specified.
#' @return Returns a \code{plot} object.
#' @seealso \code{\link[graphics]{plot}}, \code{\link[graphics]{points}}, \code{\link{extract_theta}}, \code{\link{bnps}}, \code{\link[rstan]{stanfit}}, \code{\link[base]{array}}, \code{\link[base]{matrix}}, \code{\link[base]{data.frame}}
#' @export
#'
#'
plot_trend <- function(theta=NULL, mfit=NULL,  obstype="normal", alpha=0.05, obsvec=NULL, timelab=NULL, colset="blue", trend.col=NULL, bci.col=NULL, pt.col="gray60", pt.pch=1, pt.cex=1, ylab, xlab, main, ylim, xlim, ...){


	if (is.null(theta) & is.null(mfit)) stop("Must specify either a list with theta summary or a stan model fit object.")
	if (is.null(theta) & !is.null(mfit))	thp <- extract_theta(mfit, obstype, alpha)
  if (!is.null(theta) & !is.null(mfit)) stop("Must specify either a list with theta summary or a stan model fit object, but not both.")
	if (!is.null(theta) & is.null(mfit)) {
		  if (class(theta)!="list") stop("Argument theta must be a list.")
		  thp <- theta
	}


	if (is.null(trend.col) & is.null(bci.col)) {
		if (!(colset %in% c('blue','green','purple','red','gray')) ) stop("Preset colors for colset are 'blue', 'green', 'red', 'purple', and 'gray'.")
		if (colset=="blue"){
			tcol <- "blue"
			bcol <- "lightblue"
		}
		if (colset=="green"){
			tcol <- "green3"
			bcol <- "lightgreen"
		}
		if (colset=="red"){
			tcol <- "red"
			bcol <- "pink"
		}
		if (colset=="purple") {
			tcol <- "purple"
			bcol <- "lavender"
		}
		if (colset=="gray"){
			tcol <- "black"
			bcol <- "gray80"
		}
	}

	if (is.null(trend.col) & !is.null(bci.col)) stop("Must specify trend.col if specifying bci.col")
	if (!is.null(trend.col) & is.null(bci.col)) stop("Must specify bci.col if specifying trend.col")
	if (!is.null(trend.col) & !is.null(bci.col) ) {
		tcol <- trend.col
		bcol <- bci.col
	}

	nn <- length(thp$postmed)
	tv <- 1:nn
	if (is.null(timelab)) timelab <- tv
	if (!is.null(timelab)) tv <- timelab
	prng <- range(c(thp$bci.lower, thp$bci.upper, obsvec))
  dum <- seq(prng[1], prng[2], length=nn)

  if (missing(ylim)) ylim <- prng
  if (missing(xlim)) xlim <- range(tv)
  if (missing(ylab)) ylab <- "y"
  if (missing(xlab)) xlab <- "time"
  if (missing(main)) main <- ""

	plot(tv, dum, type="n", ylim=ylim, xlim=xlim,ylab=ylab,xlab=xlab,main=main, xaxt="n",  ...)
	  axis(side=1, at=pretty(tv), labels=pretty(timelab) )
	  polygon(c(tv, rev(tv)), c(thp$bci.lower , rev(thp$bci.upper)), border=NA, col=bcol)
	  if (!is.null(obsvec)) points(tv, obsvec, pch=pt.pch, col=pt.col,  cex=pt.cex)
	  lines(tv, thp$postmed, col=tcol, lwd=3)

}


