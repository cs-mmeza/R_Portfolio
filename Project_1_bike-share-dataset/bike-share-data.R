library(tidyverse)  #helps wrangle data
library(ggplot2)  #helps visualize data

#Loading dataset
all_trips <- read_csv("/Project_1_bike-share-dataset/Data/all_trips.csv")
###############
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender, "01 - Rental Details Duration In Seconds Uncapped", "05 - Member Details Member Birthday Year", "Member Gender", "tripduration"))

# Reassign to the desired values (we will go with the current 2020 labels)
all_trips <-  all_trips %>% 
  mutate(member_casual = recode(member_casual
                                ,"Subscriber" = "member"
                                ,"Customer" = "casual"))

# Check to make sure the proper number of observations were reassigned
table(all_trips$member_casual)

# Add columns that list the date, month, day, and year of each ride
# This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
# https://www.statmethods.net/input/dates.html more on date formats in R found at that link
all_trips$date <- as.Date(all_trips$started_at) #The default format is yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%b")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Add a "ride_length" calculation to all_trips (in seconds)
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/difftime.html
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
is.factor(all_trips$ride_length)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when bikes were taken out of docks and checked for quality by Divvy or ride_length was negative
# We will create a new version of the dataframe (v2) since data is being removed
# https://www.datasciencemadesimple.com/delete-or-drop-rows-in-r-with-conditions-2/
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]

###############

table(all_trips$member_casual)
### week
mean_duration_week <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
count_day_week <- as.data.frame(table(all_trips_v2$member_casual, all_trips_v2$day_of_week))

mean_duration_week <- rename(mean_duration_week,
                        day_of_week = `all_trips_v2$day_of_week`,
                        ride_length = `all_trips_v2$ride_length`,
                        member_casual = `all_trips_v2$member_casual`)


mean_duration_week %>%
  ggplot(aes(x = day_of_week, y = ride_length
             , fill = member_casual)) +
  geom_col(position = "dodge")


count_day_week <- rename(count_day_week, 
                         member_casual = Var1, day_of_week = Var2,
                         count = Freq)

count_day_week %>%
  ggplot(aes(x = day_of_week, y = count, fill = member_casual)) +
  geom_col(position = "dodge")

### month

mean_duration_month <- aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$month, FUN = mean)
count_month <- as.data.frame(table(all_trips_v2$member_casual, all_trips_v2$month))


mean_duration_month <- rename(mean_duration_month,
                        month = `all_trips_v2$month`,
                        ride_length = `all_trips_v2$ride_length`,
                        member_casual = `all_trips_v2$member_casual`)

mean_duration_month$month <- ordered(mean_duration_month$month, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

mean_duration_month %>%
  ggplot(aes(x = month, y = ride_length
             , fill = member_casual)) +
  geom_col(position = "dodge")


## month to numeric
is.factor(mean_duration_month$month)
mean_duration_month$month <- as.numeric(as.character(mean_duration_month$month))
is.numeric(mean_duration_month$month)


count_month <- rename(count_month, 
                         member_casual = Var1, month = Var2,
                         count = Freq)


count_month$month <- ordered(count_month$month, levels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

count_month %>%
  ggplot(aes(x = month, y = count, fill = member_casual)) +
  geom_col(position = "dodge")


# Generate resulting tables from the analysis:
write.csv(mean_duration_week, file = '~/Courses/Coursera/Google_DataAnalyst/Case_study/Cyclistic_dataset/CSV/avg_ride_length_week.csv')
write.csv(count_day_week, file = '~/Courses/Coursera/Google_DataAnalyst/Case_study/Cyclistic_dataset/CSV/count_ride_length_week.csv')
write.csv(mean_duration_month, file = '~/Courses/Coursera/Google_DataAnalyst/Case_study/Cyclistic_dataset/CSV/avg_ride_length_month.csv')
write.csv(count_month, file = '~/Courses/Coursera/Google_DataAnalyst/Case_study/Cyclistic_dataset/CSV/count_ride_length_month.csv')