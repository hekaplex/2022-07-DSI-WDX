#!/usr/bin/env python3

# display a title
print("The Miles Per Gallon program")
print()

# get input from the user
miles_driven= float(input("Enter miles driven:\t\t"))
gallons_used = float(input("Enter gallons of gas used:\t"))

# calculate and round miles per gallon

mpg = round(miles_driven / gallons_used, 2)

# display the result
print()
print("Miles Per Gallon:\t\t" + str(mpg))
print()
print("Bye")
