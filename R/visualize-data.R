
GetPalette <- function(num.rounds) {
  my.colors <- brewer.pal(num.rounds + 1, "Set3")
  return(my.colors)
}

PlotNumberCounts <- function(freq.over.round, round.num, my.colors) {
  g <- ggplot(data = freq.over.round,
              aes(x = as.factor(Var1),
                  y = freq.over.round[, paste0("Round", round.num, collapse = "")])) +
    geom_bar(stat = "identity", fill = my.colors[(round.num + 1)]) +
    xlab("Number") + ggtitle(paste("Round", round.num, "Distribution", sep = " ")) +
    ylab("Count")
  return(g)
}

PlotAllRoundNumberCounts <- function(num.rounds, freq.over.round, my.colors) {
  all.g <- list()
  for (round.num in 0:num.rounds) {
    all.g[[round.num]] <- PlotNumberCounts(freq.over.round, round.num, my.colors)
  }
  return(all.g)
}

PlotAllRoundFrequencies <- function(freq.over.round, num.participants) {
  all.freq <- freq.over.round[2:ncol(freq.over.round)]
  all.freq <- all.freq / num.participants
  freq.over.round[2:ncol(freq.over.round)] <- all.freq
  freq.over.round.m <- melt(freq.over.round, id.vars = "Var1")
  g <- ggplot(data = freq.over.round.m, aes(x = variable, y = value,
                                            group = as.factor(Var1),
                                            color = as.factor(Var1))) +
    geom_line() + geom_point() + labs(color = "Number") +
    xlab("Round Number") + ylab("Frequency")
  return(g)
}
