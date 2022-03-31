
# The Case Study
## Instroduction
The company wants to increase user subscriptions on their yearly subscription program. The company has two types of users: casual users, who use bikes for one day, and members, who are subscribed to the program.

`The company wants to attract more casual users to the yearly subscription program since it generates more revenue. `

To do a business plan to attract more members, Cyclistic provided a data-set with information about trips of all users. Inside the data-set, users are classified into two groups `casual` and `member`.  

*I imported data from 2019 to 2020 first quarter to identify patterns that help me form a business plan/strategy.*

#### key stakeholders

* 1. Cyclistic executive team

* 2. Lily Moreno, Director of marketing.

### 1. Relevant questions

Why would casual riders buy Cyclistic annual memberships?

How can Cyclistic use digital media to influence casual riders to become members?

## Development
### 2. Prepare

I Downloaded the files from divvy's dataset: https://divvy-tripdata.s3.amazonaws.com/index.html

Then stored the dataset in a local folder separating the CSV original files and the copy I am working on.

`~/CSV
 ~/CSV-Copy/Working-directory
 `

Once the dataset is organized with a back-up, I use RStudio for the analysis. The google data analysis course provided a scrip to use in R for cleaning and processsing. The Examples used the data from divvy's dataset. Data is organized from quarters and is taken from the last 3 quarters of 2019 and the first quarter of 2020 to represent a whole year of user activity.

Script guideline and requirements on the link below:

https://docs.google.com/document/d/1TTj5KNKf4BWvEORGm10oNbpwTRk1hamsWJGj6qRWpuI/edit

dataset used on R script:

`q2_2019 <- read_csv("Divvy_Trips_2019_Q2.csv"),`
`q3_2019 <- read_csv("Divvy_Trips_2019_Q3.csv"),`
`q4_2019 <- read_csv("Divvy_Trips_2019_Q4.csv"),`
`q1_2020 <- read_csv("Divvy_Trips_2019_Q1.csv")`

Merge

`all_trips <- bind_rows(q2_2019, q3_2019, q4_2019, q1_2020)`

### 3. Process

After merging all datasets under the variable `all_trips` we removed the columns that were dropped on tables from 2020 and after.

`all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng, birthyear, gender))`
`
### 4. Analysis
After preparing and cleaning the main data-set it to identify patterns. In order to avoid uploading the whole data set, we will separate the data into smaller data sets. Each data set represents some of the questions Cyclistics has about their users. Like weekly and monthly ride count as well as ride duration.

To understand how different types of users differentiate from each other, we need to classify their trips by trip duration and trip count.

Average ride time by each day for embers VS casual users, the data is separated, in days of the week and there is, also a monthly version.

## Conclusion

After analysing the data-sets, these are the patterns and conclusions I found.

1. Members take more rides on working days.
2. Casual users take more rides on weekends.
3. Casual users take longer rides on average compared to members.
4. Winter is the less demanded season for both users.
5. longer rides from casual users come between February and January.

### 6. Act

Propositions for stakeholders:
* Since casual users spend most of their rides on weekends, Cyclistic can create a different membership based on weekends.
* Cyclistic can promote a temporary program for casual users that reward them based on the distance they travel. This proposal is based on data that indicates casual riders take longer rides. Rewards can include:
  * An extra pass for the weekends to give to a partner for rides.
  * Discounts in participant stores.
* The company can also go further in the analysis and make surveys to understand their users better. These surveys can contain information about the region. This can help the company make dedicated rewards and promotion programs. the objective of the new survey could be to know about users going for different memberships. (monthly instead of yearly).

