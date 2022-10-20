## Sentiment Analysis
# 
### Project Overview
Pull data from https://github.com/KeithGalli/sklearn
Used sentiments from Amazon reviews in 2014 to train model

The dataset used is taken from actual ship movements captured several years ago. For this capstone I will have the following two sources:
1. Vessel information (ownership, etc.)
1. Information on port arrivals and departures

### Business Scenario
There are two big questions that informed my potential avenues of inspection and data analysis:
1. Port traffic forecasting is valuable business information to allow companies to make decisions on where to send goods to ensure speedy delivery.
1.  Cargo will frequently be sold and bought several times in transit.  In order to have a good understanding of the impact on ports, you will need to first understand where some ships are going and if they are changing courses

### Executive Summary
For this capstone I decided to look at a relatively simple question in the first category in the business scenarios we were given.

I hypothesized that ports with heavier traffic would have a larger share of delays (dwell time). I looked at the gross tonnage of shipping going to each port and then compared these numbers to the total dwell time at each port (for the data set given) and the average dwell time at each port.

What I found is that the total dwell time and gross tonnage of each port are loosely correlated, however the gross tonnage and average dwell time are not correlated at all. The conclusions that can be drawn from these correlations are that busier ports are, in fact, not slower. This means that when planning routes to be taken for auto carriers it logically makes sense to target busy ports since they have no real delays beyond the norm worth noting and they are invariably closer to larger markets which means that subsequent transportation costs would be lower.