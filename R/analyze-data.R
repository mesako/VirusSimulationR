
GetHistData <- function(reshaped.data) {
  hist.data <- melt(reshaped.data, id.vars = "Name")
  return(hist.data)
}

GetPossibleNum <- function() {
  possible.num <- 2 ^ (0:10)
  possible.num[which(possible.num > 1000)] <- 1000
  possible.num <- unique(possible.num)
  possible.num <- c(0, possible.num)
  return(possible.num)
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