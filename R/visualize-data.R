
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

CreateDefault9Mapping <- function(loc.labels) {
  base.x <- c(1, 0, 0, 1)
  x <- base.x
  for (i in 1:(3 - 1)) {
    new.x <- c(base.x + i)
    x <- c(x, new.x)
  }
  base.y <- c(0, 0, 1, 1)
  y <- rep(base.y, times = 3)
  for (j in 1:(3 - 1)) {
    new.y <- c(base.y + j)
    y <- c(y, rep(new.y, times = 3))
  }
  x <- rep(x, times = 3)

  positions <- data.frame(
    id = rep(loc.labels, each = 4),
    x = x, y = y)
  return(positions)
}

ShowRoomPreview <- function(loc.labels) {
  positions <- VirusSimulationR:::CreateDefault9Mapping(loc.labels)
  label.x <- positions$x[seq(1, length(positions$x), by = 4)]
  label.y <- positions$y[seq(1, length(positions$y), by = 4)]
  label.x <- label.x - 0.5
  label.y <- label.y + 0.5
  fake.data <- matrix(0, nrow = length(unique(positions$id)), ncol = 2)
  fake.data <- as.data.frame(fake.data)
  fake.data[, 1] <- unique(positions$id)
  colnames(fake.data) <- c("Loc", "Num")

  room.map <- ggplot(fake.data) +
    geom_map(aes(map_id = Loc), map = positions) +
    expand_limits(positions) + scale_color_manual(values = c("black")) +
    geom_text(aes(label = Loc, x = label.x, y = label.y))

  room.map <- room.map + theme_bw() +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.x = element_line(colour = "black"),
          panel.grid.major.y = element_line(colour = "black"))
  return(room.map)
}

GenerateSpatialMap <- function(form.data, loc.labels, roundoptions) {
  positions <- CreateDefault9Mapping(loc.labels)
  label.x <- positions$x[seq(1, length(positions$x), by = 4)]
  label.y <- positions$y[seq(1, length(positions$y), by = 4)]
  label.x <- label.x - 0.5
  label.y <- label.y + 0.5
  spatial.data <- GetSpatialData(form.data, roundoptions)
  spatial.data <- cbind(Loc = rownames(spatial.data), spatial.data)
  missing.loc <- loc.labels[!loc.labels %in% spatial.data$Loc]
  fill.missing <- cbind(missing.loc, rep(0, times = length(missing.loc)))
  for (i in 1:(length(roundoptions))) {
    fill.missing <- cbind(fill.missing, rep(0, times = length(missing.loc)))
  }
  colnames(fill.missing) <- c("Loc", "Round0", roundoptions)
  fill.missing <- as.data.frame(fill.missing)
  spatial.data$Loc <- as.character(spatial.data$Loc)
  fill.missing$Loc <- as.character(fill.missing$Loc)
  rownames(fill.missing) <- fill.missing$Loc
  spatial.data <- rbind(spatial.data, fill.missing)
  spatial.data <- spatial.data[match(loc.labels, spatial.data$Loc), ]
  spatial.data[, 2:ncol(spatial.data)] <- sapply(spatial.data[, 2:ncol(spatial.data)], FUN = as.numeric)

  room.map <- ggplot(spatial.data) +
    geom_map(aes(map_id = Loc), map = positions) +
    expand_limits(positions) + scale_color_manual(values = c("black")) +
    geom_text(aes(label = Loc, x = label.x, y = label.y))

  room.map <- room.map + theme_bw() +
    theme(axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank(),
          panel.grid.major.x = element_line(colour = "black"),
          panel.grid.major.y = element_line(colour = "black"))
  return(list(room.map, spatial.data, positions))
}

PlotSpatial <- function(spatial.data, positions, round.num, room.map) {
  label.x <- positions$x[seq(1, length(positions$x), by = 4)]
  label.y <- positions$y[seq(1, length(positions$y), by = 4)]
  label.x <- label.x - 0.5
  label.y <- label.y + 0.5
  mapping.loc <- data.frame(spatial.data$Loc, label.x, label.y)
  colnames(mapping.loc)[1] <- "Loc"

  this.round.data <- data.frame(spatial.data$Loc, spatial.data[, paste0("Round", round.num, collapse = "")])
  colnames(this.round.data) <- c("Loc", "NumZeros")
  point.data <- matrix(NA, nrow = sum(spatial.data[, paste0("Round", round.num, collapse = "")]), ncol = 2)
  point.data <- as.data.frame(point.data)
  colnames(point.data) <- c("point.x", "point.y")
  non.zero.loc <- this.round.data$Loc[which(this.round.data[, "NumZeros"] > 0)]
  x <- 1
  if (length(non.zero.loc) == 1) {
    point.data <- unname(mapping.loc[mapping.loc$Loc == non.zero.loc, ][, 2:3])
    num.points <- this.round.data$NumZeros[which(this.round.data$Loc == non.zero.loc)]
    colnames(point.data) <- c("point.x", "point.y")
    if (num.points > 1) {
      while (nrow(point.data) != num.points) {
        point.data <- rbind(point.data, point.data[1, ])
      }
    }
  } else {
    for (i in 1:length(non.zero.loc)) {
      num.points <- this.round.data$NumZeros[which(this.round.data[, "NumZeros"] > 0)][i]
      point.data[x:(x + num.points - 1), ] <- unname(mapping.loc[mapping.loc$Loc == non.zero.loc[i], ][, 2:3])
      x <- x + num.points
    }
  }
  temp.plot <- room.map + geom_map(aes(map_id = Loc, fill = spatial.data[, paste0("Round", round.num, collapse = "")]), map = positions) +
    geom_text(aes(label = Loc, x = label.x, y = label.y)) + labs(fill = paste0("Round", round.num, collapse = "")) +
    geom_jitter(data = point.data, aes(x = point.x, y = point.y), stat = "identity",
                width = 0.25, height = 0.25) + scale_fill_gradient(low = "#FFFFFF", high = "#D06666")
  print(temp.plot)
  return(temp.plot)
}
