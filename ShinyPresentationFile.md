ShinyPresentationFile
========================================================
author: HADI GONI BOULAMA Amina
date: 20/02/2020
autosize: true

Analysis of sncf train dashboards
========================================================
we will divide the presentation in 3 parts:

- Part 1 : Presenation of the dataset and some results
- Part 2 : Explanation of this shiny application
- Part 3 : Presentaion of some plots and the links

 Part 1 : Presenation of the dataset
========================================================
Data come from sncf. It is a big dataset witch represents over 10000 lines of 27 variables.
The year go from 2015 to 2018.
The total number of trains that have been carried out :1492939
The percentage of  cancelled trains :2.8%


```r
sncf_train <- read.csv("full_trains.csv", stringsAsFactors = FALSE)
summary(sncf_train )
```

```
      year          month          service          departure_station 
 Min.   :2015   Min.   : 1.000   Length:5462        Length:5462       
 1st Qu.:2016   1st Qu.: 3.000   Class :character   Class :character  
 Median :2017   Median : 6.000   Mode  :character   Mode  :character  
 Mean   :2017   Mean   : 6.369                                        
 3rd Qu.:2018   3rd Qu.: 9.000                                        
 Max.   :2018   Max.   :12.000                                        
                                                                      
 arrival_station    journey_time_avg total_num_trips num_of_canceled_trains
 Length:5462        Min.   : 45.96   Min.   :  6.0   Min.   :  0.000       
 Class :character   1st Qu.:100.77   1st Qu.:181.0   1st Qu.:  0.000       
 Mode  :character   Median :160.84   Median :238.0   Median :  1.000       
                    Mean   :165.39   Mean   :281.1   Mean   :  7.737       
                    3rd Qu.:205.70   3rd Qu.:390.0   3rd Qu.:  4.000       
                    Max.   :481.00   Max.   :878.0   Max.   :279.000       
                                                                           
 comment_cancellations num_late_at_departure avg_delay_late_at_departure
 Mode:logical          Min.   :  0.00        Min.   :  0.00             
 NA's:5462             1st Qu.: 10.00        1st Qu.: 11.98             
                       Median : 23.00        Median : 15.84             
                       Mean   : 41.58        Mean   : 16.81             
                       3rd Qu.: 51.75        3rd Qu.: 20.28             
                       Max.   :451.00        Max.   :173.57             
                                                                        
 avg_delay_all_departing comment_delays_at_departure num_arriving_late
 Min.   : -4.468         Mode:logical                Min.   :  0.00   
 1st Qu.:  0.896         NA's:5462                   1st Qu.: 17.00   
 Median :  1.783                                     Median : 30.00   
 Mean   :  2.539                                     Mean   : 38.03   
 3rd Qu.:  3.243                                     3rd Qu.: 50.00   
 Max.   :173.571                                     Max.   :235.00   
                                                     NA's   :9        
 avg_delay_late_on_arrival avg_delay_all_arriving comment_delays_on_arrival
 Min.   :  0.00            Min.   :-143.969       Length:5462              
 1st Qu.: 23.81            1st Qu.:   2.706       Class :character         
 Median : 30.76            Median :   4.581       Mode  :character         
 Mean   : 32.45            Mean   :   5.287                                
 3rd Qu.: 38.77            3rd Qu.:   7.252                                
 Max.   :258.00            Max.   :  36.817                                
 NA's   :9                                                                 
 delay_cause_external_cause delay_cause_rail_infrastructure
 Min.   :0.0000             Min.   :0.0000                 
 1st Qu.:0.1667             1st Qu.:0.1515                 
 Median :0.2571             Median :0.2353                 
 Mean   :0.2780             Mean   :0.2518                 
 3rd Qu.:0.3684             3rd Qu.:0.3333                 
 Max.   :1.0000             Max.   :1.0000                 
 NA's   :170                NA's   :170                    
 delay_cause_traffic_management delay_cause_rolling_stock
 Min.   :0.0000                 Min.   :0.00000          
 1st Qu.:0.0800                 1st Qu.:0.09292          
 Median :0.1613                 Median :0.15843          
 Mean   :0.1831                 Mean   :0.17877          
 3rd Qu.:0.2571                 3rd Qu.:0.24000          
 Max.   :1.0000                 Max.   :1.00000          
 NA's   :170                    NA's   :170              
 delay_cause_station_management delay_cause_travelers num_greater_15_min_late
 Min.   :0.00000                Min.   :0.00000       Min.   :  0.00         
 1st Qu.:0.00000                1st Qu.:0.00000       1st Qu.: 11.00         
 Median :0.05263                Median :0.02128       Median : 20.00         
 Mean   :0.06999                Mean   :0.03730       Mean   : 26.09         
 3rd Qu.:0.10256                3rd Qu.:0.05769       3rd Qu.: 35.00         
 Max.   :1.00000                Max.   :0.66667       Max.   :192.00         
 NA's   :170                    NA's   :170           NA's   :5              
 avg_delay_late_greater_15_min num_greater_30_min_late num_greater_60_min_late
 Min.   :-118.022              Min.   : 0.00           Min.   : 0.000         
 1st Qu.:   8.994              1st Qu.: 4.00           1st Qu.: 1.000         
 Median :  31.533              Median : 9.00           Median : 3.000         
 Mean   :  28.984              Mean   :11.65           Mean   : 4.197         
 3rd Qu.:  41.000              3rd Qu.:16.00           3rd Qu.: 6.000         
 Max.   : 258.000              Max.   :91.00           Max.   :36.000         
 NA's   :5                     NA's   :5               NA's   :5              
```
 Part 2 : Explanation of this shiny application
========================================================

Composition of the application:
Two parts: UI for interface and SERVER for the manipulation of the application.

The UI part contents some filters which are used to refine the data presented in the application. 

The Server part contents some functions such as the aggregations functions and also some reactive variables ( render*) that have the property to refresh when necessary. 

Source Code
=====================








```
Error in file(con, "rb") : impossible d'ouvrir la connexion
```
