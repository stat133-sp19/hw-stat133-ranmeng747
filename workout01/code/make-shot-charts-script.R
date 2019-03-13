#Title: make-shot-charts-script

#Description: This script computes the locations of made& missed shots of 5 GSW players in 2016-17 season, 
#with a 2D image of basketball half court in the background as reference.  

#Inputs: nba-court.jpg; Need variables produced from make-shots-data-script.R for script execution

#Outputs: andre-iguodala-shot-chart.pdf; andre-iguodala-shot-chart.png; draymond-green-shot-chart.pdf;
#kevin-durant-shot-chart.pdf; klay-thompson-shot-chart.pdf;stephen-curry-shot-chart.pdf;
#gsw-shot-charts.pdf;gsw-shot-charts.png

#-------------------------
library(ggplot2)
library(jpeg)
library(grid)

#4.1 Create shot chart for each player with court as background, and save images to pdf
court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

#Andre Iguodala
iguodala_shot_chart <- ggplot(data = iguodala) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Andre Iguodala (2016 season)') +
  theme_minimal()

ggsave("../images/andre-iguodala-shot-chart.pdf", plot = iguodala_shot_chart, height = 5, width = 6.5)
ggsave("../images/andre-iguodala-shot-chart.png", plot = iguodala_shot_chart, height = 5, width = 6.5)

#Draymond Green
green_shot_chart <- ggplot(data = green) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Draymond Green (2016 season)') +
  theme_minimal()

ggsave("../images/draymond-green-shot-chart.pdf", plot = green_shot_chart, height = 5, width = 6.5)

#Kevin Durant
durant_shot_chart <- ggplot(data = durant) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Kevin Durant (2016 season)') +
  theme_minimal()

ggsave("../images/kevin-durant-shot-chart.pdf", plot = durant_shot_chart, height = 5, width = 6.5)

#Klay Thompson
thompson_shot_chart <- ggplot(data = thompson) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()

ggsave("../images/klay-thompson-shot-chart.pdf", plot = thompson_shot_chart, height = 5, width = 6.5)

#Stephen Curry
curry_shot_chart <- ggplot(data = curry) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Stephen Curry (2016 season)') +
  theme_minimal()

ggsave("../images/stephen-curry-shot-chart.pdf", plot = curry_shot_chart, height = 5, width = 6.5)

# 4.2 Facetted Shot Chart 
gsw_shot_charts <- ggplot(data = shots_data) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + facet_wrap(~name) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal() + theme(legend.position = c(0.8, 0.3))

gsw_shot_charts
ggsave("../images/gsw-shot-charts.pdf", plot = gsw_shot_charts, height = 7, width = 8)  
ggsave("../images/gsw-shot-charts.png", plot = gsw_shot_charts, height = 7, width = 8) 

