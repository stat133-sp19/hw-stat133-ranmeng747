This document contains a description of the data variables: 

+ *team_name*: The name of the team which the player is playing for. Players could be traded during the middle of a NBA season so this variable is not necessarily the same throughout the season. 

+ *game_date*: Date of the game which the player played in M/D/YYYY format. 

+ *season*: Season in year(YYYY) which the player's shot statistics is collected on. This dataset is from 2016-17 season so all values under this feature is "2016". 

+ *period*: Period that this shot has occurred.NBA has 4 periods and each period is 12 minutes long. 

+ *minutes_remaining*: Amount of time remained in the period in minutes, rounded down to the nearest integer

+ *seconds_remaining*: Number of seconds left after *minutes_remaining* is rounded down. 

+ *shot_made_flag*: Binary variable indicating whether the shot is made. If the observed shot is made, flag returns "y", otherwise returns "n".

+ *action_type*: Basketball terminologies indicating the type of the observed move to take the shot. 

+ *shot_type*: Indicates whether the shot would count as 2 points or 3 points. 

+ *shot_distance*: Distance of the shot to basket measured in feet. 

+ *opponent*: Name of the opponent team

+ *x*: x- coordinate of where the shot occurred, measured in inches. 

+ *y*: y- coordinate of where the shot occurred, measured in inches.

+ *name*: Full name of the player

+ *minute*: Amount of time since the game started, in minutes. Ranges from 0 to 48.  

