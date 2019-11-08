
FixNumAssign <- function(reshaped.data, num.assign) {
  remove.blanks <- setdiff(unique(num.assign$Name), unique(reshaped.data$Name))
  num.assign <- num.assign[!(num.assign$Name %in% remove.blanks), ]
  return(num.assign)
}

ProcessData <- function(form.data, num.assign) {
  reshaped.data <- as.data.frame(form.data)
  reshaped.data$Timestamp <- NULL
  colnames(reshaped.data) <- c("Name", "RoundNum", "Num", "Loc", "Pair")
  reshaped.data$RoundNum <- gsub(reshaped.data$RoundNum, pattern = " ", replacement = "")
  return(reshaped.data)
}

SummarizeData <- function(reshaped.data, num.assign, round.options) {
  summary.data <- num.assign
  for (x in round.options) {
    temp <- reshaped.data[reshaped.data$RoundNum == x, ]
    temp <- temp[order(temp$Name), ]
    round.data <- temp[, 3:ncol(temp)]
    if (nrow(round.data) < nrow(num.assign)) {
      next
    } else {
      colnames(round.data) <- paste(x, colnames(round.data), sep = "")
      summary.data <- cbind(summary.data, round.data)
    }
  }
  colnames(summary.data) <- gsub(colnames(summary.data), pattern = "Num", replacement = "")
  return(summary.data)
}
