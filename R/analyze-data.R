
GetHistData <- function(reshaped.data, round.options) {
  round.options <- c("Round0", round.options)
  hist.data <- melt(reshaped.data, measure.vars = round.options, na.rm = FALSE)
  return(hist.data)
}

InitiateFreqData <- function(possible.num) {
  freq.over.round <- data.frame(Var1 = possible.num)
  return(freq.over.round)
}

GetFreqData <- function(hist.data, num.rounds) {
  possible.num <- GetPossibleNum()
  freq.over.round <- InitiateFreqData(possible.num)
  for (i in 0:num.rounds) {
    this.var <- paste0("Round", i, collapse = "")
    this.round <- subset(hist.data, variable == this.var)
    this.round <- data.frame(table(this.round$value), stringsAsFactors = FALSE)
    this.round$Var1 <- as.character(this.round$Var1)
    if (sum(possible.num %in% this.round$Var1) < length(possible.num)) {
      add.rows <- data.frame(Var1 = possible.num[!(possible.num %in% this.round$Var1)],
                             Freq = 0, stringsAsFactors = FALSE)
      this.round <- rbind(this.round, add.rows)
      this.round <- this.round[order(as.numeric(this.round$Var1), decreasing = FALSE), ]
      this.round$Var1 <- factor(this.round$Var1, levels = as.character(possible.num))
    }
    freq.over.round <- cbind(freq.over.round, this.round$Freq)
    colnames(freq.over.round)[ncol(freq.over.round)] <- paste0("Round", i, collapse = "")
  }
  return(freq.over.round)
}

GetSpatialData <- function(form.data, round.options) {
  all.loc <- form.data[, grep(colnames(form.data), pattern = "Loc")]
  all.num <- form.data[, sapply(form.data, FUN = is.numeric)]
  combined <- cbind(all.loc, all.num)
  temp <- c("Round0", round.options)
  temp <- temp[temp %in% colnames(all.num)]
  possible.loc <- unique(as.vector(t(all.loc)))
  possible.loc <- na.omit(possible.loc)
  spatial.data <- matrix(NA, nrow = length(possible.loc),
                         ncol = length(temp))
  spatial.data <- as.data.frame(spatial.data)
  rownames(spatial.data) <- possible.loc
  colnames(spatial.data) <- temp
  for (i in possible.loc) {
    for (j in temp) {
      this.round <- paste0(j, "Loc", collapse = "")
      values <- combined[combined[, this.round] == i, j]
      values <- na.omit(values)
      if (length(values) > 1) {
        spatial.data[which(rownames(spatial.data) == i), j] <- sum(values == 0)
      }
    }
  }
  spatial.data[is.na(spatial.data)] <- 0
  return(spatial.data)
}

GetNumRounds <- function(round.options) {
  num.rounds <- gsub(round.options, pattern = "Round", replacement = "")
  num.rounds <- max(as.numeric(num.rounds))
  return(num.rounds)
}

GetNumParticipants <- function(form.data) {
  num.participants <- length(unique(form.data$Name))
  return(num.participants)
}

GetRoundOptions <- function(form.data) {
  round.options <- unique(form.data$RoundNum)
  return(round.options)
}
