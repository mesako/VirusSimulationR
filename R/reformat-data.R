
FixNumAssign <- function(reshaped.data, num.assign) {
  remove.blanks <- setdiff(unique(num.assign$Name), unique(reshaped.data$Name))
  num.assign <- num.assign[!(num.assign$Name %in% remove.blanks), ]
  return(num.assign)
}

ProcessData <- function(form.data, num.assign) {
  reshaped.data <- as.data.frame(form.data)
  reshaped.data$Timestamp <- NULL
  colnames(reshaped.data) <- c("Name", "RoundNum", "Num", "Loc", "Pair")
  reshaped.data$Name <- toupper(reshaped.data$Name)
  reshaped.data$RoundNum <- gsub(reshaped.data$RoundNum, pattern = " ", replacement = "")
  return(reshaped.data)
}

GetPossibleNum <- function() {
  possible.num <- 2 ^ (0:10)
  possible.num[which(possible.num > 1000)] <- 1000
  possible.num <- unique(possible.num)
  possible.num <- c(0, possible.num)
  return(possible.num)
}

RemoveOddData <- function(reshaped.data, num.assign) {
  which.match <- reshaped.data$Name %in% num.assign$Name
  clean.data <- reshaped.data[which.match, ]
  which.match <- clean.data$Pair %in% num.assign$Name
  clean.data <- clean.data[which.match, ]
  which.match <- clean.data$Num %in% GetPossibleNum()
  clean.data <- clean.data[which.match, ]
  return(clean.data)
}

SummarizeData <- function(reshaped.data, num.assign, round.options) {
  summary.data <- num.assign
  for (x in round.options) {
    temp <- reshaped.data[reshaped.data$RoundNum == x, ]
    temp <- temp[order(temp$Name), ]
    round.data <- temp
    data.duplicate <- duplicated(round.data$Name)
    round.data <- round.data[!data.duplicate, ]
    if (nrow(round.data) < nrow(num.assign)) {
      missing.id <- setdiff(num.assign$Name, round.data$Name)
      for (id in missing.id) {
        new.row <- data.frame("Name" = id, "RoundNum" = x,
                              "Num" = NA, "Loc" = NA, "Pair" = NA)
        round.data <- rbind(round.data, new.row)
        rm(new.row)
      }
      round.data <- round.data[order(round.data$Name), ]
    }
    round.data <- round.data[, 3:ncol(round.data)]
    colnames(round.data) <- paste(x, colnames(round.data), sep = "")
    if (nrow(summary.data) != nrow(round.data)) {
      stop("MISMATCH ROWS!")
    } else {
      summary.data <- cbind(summary.data, round.data)
    }
  }
  colnames(summary.data) <- gsub(colnames(summary.data), pattern = "Num", replacement = "")
  return(summary.data)
}
