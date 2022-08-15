## _Automotive Shipment Movement_
# 
### Project Overview
This dataset is taken from actual ship movements captured several years ago.

In the first capstone you will receive a simplified version to orient you to the complexity of the dataset

The final dataset given in the App Capstone includes four sources:
1. Near shore captures of actual ship positions
1. Satellite captures of actual ship positions
1. Vessel information (ownership, etc.)
1. Information on port arrivals and departures
### Business Scenario
There are two big questions that machine learning can help address ultimately:
1. Port traffic forecasting is valuable business information to allow companies to make decisions on where to send goods to ensure speedy delivery.
1.  Cargo will frequently be sold and bought several times in transit.  In order to have a good understanding of the impact on ports, you will need to first understand where some ships are going and if they are changing courses
### Specific Questions
1. What are the opportunities to clean up the data?
1. Are there any natural primary and foeign keys or will we need to create and maintain them?
1. Are there any inconsistencies in the relationshps between the natural or surrogate keys?  
1. What are the measures that you will need to create to support the aggregate calculations?
### Executive Summary
I hypothesized that ports with heavier traffic would have a larger share of delays (dwell time). I looked at the gross tonnage of shipping going to each port and then compared these numbers to the total dwell time at each port (for the data set given) and the average dwell time at each port.

The results are as follows