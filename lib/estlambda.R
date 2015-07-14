### function copied from GenABEL and modified by Jingliang Yang
estlambda <- function (data, plot = FALSE, proportion = 1, method = "regression", 
          filter = TRUE, df = 1, ...) 
{
  data <- data[which(!is.na(data))]
  if (proportion > 1 || proportion <= 0) 
    stop("proportion argument should be greater then zero and less than or equal to one")
  ntp <- round(proportion * length(data))
  if (ntp < 1) 
    stop("no valid measurements")
  if (ntp == 1) {
    warning(paste("One measurement, lambda = 1 returned"))
    return(list(estimate = 1, se = 999.99))
  }
  if (ntp < 10) 
    warning(paste("number of points is too small:", ntp))
  if (min(data) < 0) 
    stop("data argument has values <0")
  if (max(data) <= 1) {
    data <- qchisq(data, 1, lower.tail = FALSE)
  }
  if (filter) {
    data[which(abs(data) < 1e-08)] <- NA
  }
  data <- sort(data)
  ppoi <- ppoints(data)
  ppoi <- sort(qchisq(ppoi, df = df, lower.tail = FALSE))
  data <- data[1:ntp]
  ppoi <- ppoi[1:ntp]
  out <- list()
  if (method == "regression") {
    s <- summary(lm(data ~ 0 + ppoi))$coeff
    out$estimate <- s[1, 1]
    out$se <- s[1, 2]
  }
  else if (method == "median") {
    out$estimate <- median(data, na.rm = TRUE)/qchisq(0.5, 
                                                      df)
    out$se <- NA
  }
  else if (method == "KS") {
    limits <- c(0.5, 100)
    out$estimate <- estLambdaKS(data, limits = limits, df = df)
    if (abs(out$estimate - limits[1]) < 1e-04 || abs(out$estimate - 
                                                       limits[2]) < 1e-04) 
      warning("using method='KS' lambda too close to limits, use other method")
    out$se <- NA
  }
  else {
    stop("'method' should be either 'regression' or 'median'!")
  }
  if (plot) {
    lim <- c(0, max(data, ppoi, na.rm = TRUE))
    oldmargins <- par()$mar
    par(mar = oldmargins + 0.2)
    plot(ppoi, data, xlab = expression("Expected " ~ chi^2), 
         ylab = expression("Observed " ~ chi^2), ...)
    abline(a = 0, b = 1)
    #abline(a = 0, b = out$estimate, col = "red")
    par(mar = oldmargins)
  }
  out
}