'''

Project 9-4: Aircraft Fuel Calculator 

(Create a program that calculates the amount of time and fuel for a 1980 Cessna 172N to 
fly a specified distance.)

Console 

....................................................................................
Aircraft Fuel Calculator 

Distance in nautical miles: 180
Flight time: 1 hour(s) and 30 minute(s) 
Required fuel: 16.8 gallons

Continue? (y/n): y

Distance in nautical miles: 121
Flight time: 1 hour(s) and 0 minute(s) 
Required fuel: 12.7 gallons 

Continue? (y/n): n

Bye! 
..................................................................................

Specifications 
 Assume that a 1980 Cessna 172N can fly 120 nautical miles (knots) per hour. 
 Assume that a 1980 Cessna 172N burns 8.4 gallons of gas per hour. 
 For safety, add a half hour to the flight time when calculating the amount of required 
fuel. 
 Round the amount of required fuel to 1 decimal place. For safety, always round up, 
never down. 
 Assume that the user will enter valid data.
'''
import math



def display_title():
    print("Aircraft Fuel Calculator")
    print()

def get_info():
    distance=input("How many nautical miles are you gonna fly?: ")
    
    
        
def give_info(): 
    speed=120
    gph= 8.4
    fuel=60/gph
    time= ((60/speed)*get_info.distance)+30 
    gallons=time*fuel
    print("Distance in nautical miles: ", miles)
    print("Flight time: ", time)
    print("Required fuel: ", gallons,'gallons')

def another_flight():
    choice ="y"
    while choice.lower()=='y':
        main()
    else:
        print("Bye!")   

def main():
    display_title()
    get_info()
    give_info()

if __name__=="__main__":
    main()




'''
#!/usr/bin/env python3

# This program computes the amount of fuel needed by a 1980 Cessna 172N
# to fly from one airport to another.

import math

def main():
    print("Aircraft Fuel Calculator\n")

    choice = "y"
    while choice.lower() == "y":
        # Get input from the user
        distance = int(input("Distance in nautical miles: "))

        # Calculate flight time
        knots_per_hour = 120
        flight_time = distance / knots_per_hour
        hours = distance // knots_per_hour
        distance = distance % knots_per_hour
        knots_per_minute = knots_per_hour / 60
        minutes = int(distance // knots_per_minute)

        # Calculate required fuel
        gallons_per_hour = 8.4
        reserve_time = .5
        fuel = gallons_per_hour * (flight_time + reserve_time)
        fuel = math.ceil(fuel * 10) / 10

        # Print the results
        print(f"Flight time: {hours} hour(s) and {minutes} minute(s)")    
        print(f"Required fuel: {fuel} gallons")
        print()

        # Continue?
        choice = input("Continue? (y/n): ")
        print()
        
    print("Bye!")       


if __name__ == "__main__":
    main()
'''