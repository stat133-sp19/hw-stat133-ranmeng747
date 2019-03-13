#Title: make-shots-data-script

#Description: The script reads in shot statistics of 5 professional NBA players, adds columns of information 
#about the players and the game, and translates some of ambiguous data values to values of more descriptive nature

#Inputs: andre-iguodala.csv; draymond-green.csv; kevin-durant.csv; klay-thompson.csv; stephen-curry.csv

#Outputs: andre-iguodala-summary.txt; draymond-green-summary.txt; kevin-durant-summary.txt; klay-thompson-summary.txt
# stephen-curry-summary.txt; shots-data-summary.txt; shots-data.csv
#-----------------------------------------


#Import data files
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)

# Add column to store names for each player:
iguodala$name <- "Andre Iguodala"
green$name <- "Draymond Green"
durant$name <- "Kevin Durant"
thompson$name <- "Klay Thompson"
curry$name <- "Stephen Curry"

# Change "n" to "shot_no", y to "shot_yes" to make shot_made_flag variable more descriptive:
iguodala[which(iguodala$shot_made_flag == "n"), ]$shot_made_flag <- "shot_no"
iguodala[which(iguodala$shot_made_flag == "y"), ]$shot_made_flag <- "shot_yes"

green[which(green$shot_made_flag == "n"), ]$shot_made_flag <- "shot_no"
green[which(green$shot_made_flag == "y"), ]$shot_made_flag <- "shot_yes"

durant[which(durant$shot_made_flag == "n"), ]$shot_made_flag <- "shot_no"
durant[which(durant$shot_made_flag == "y"), ]$shot_made_flag <- "shot_yes"

thompson[which(thompson$shot_made_flag == "n"), ]$shot_made_flag <- "shot_no"
thompson[which(thompson$shot_made_flag == "y"), ]$shot_made_flag <- "shot_yes"

curry[which(curry$shot_made_flag == "n"), ]$shot_made_flag <- "shot_no"
curry[which(curry$shot_made_flag == "y"), ]$shot_made_flag <- "shot_yes"


# Adding 'minute' which indicates total number of minutes played when the shot occurred
iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining
green$minute <- green$period * 12 - green$minutes_remaining
durant$minute <- durant$period * 12 - durant$minutes_remaining
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining
curry$minute <- curry$period * 12 - curry$minutes_remaining

# Output data to .txt
sink(file = "../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file = "../output/draymond-green-summary.txt")
summary(green)
sink()

sink(file = "../output/kevin-durant-summary.txt")
summary(durant)
sink()

sink(file = "../output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink(file = "../output/stephen-curry-summary.txt")
summary(curry)
sink()

# Construct global data frame for the 5 players and output data to .csv
shots_data <- rbind(iguodala, green, durant, thompson, curry)
write.csv(
  x = shots_data, # R object to be exported
  file = "../data/shots-data.csv",  # file path 
  row.names = FALSE
)

sink(file = "../output/shots-data-summary.txt")
summary(shots_data)
sink()



