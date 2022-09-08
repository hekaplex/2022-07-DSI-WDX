#!/usr/bin/env python3

#function defintion and input parameters
def calculateFutureValue(monthlyInvestment, monthlyRate, months):
# iterator for length of calculation cycle
    futureValue = 0.0
    for i in range(months):
#business logic
        futureValue = (
                futureValue
                + monthlyInvestment
            ) \
            * \
            ( \
                1 
                + monthlyRate/100
            )
#output of function
    return str(round(futureValue,2))

# display a welcome message
print("Welcome to the Future Value Calculator")
print()

# get input from the user
a = True
while a:
    try:
        monthlyInvestment = float(input("Configure Monthly Investment:\t"))
        a = False
    except ValueError:
        print("input must be a number, try again")
        
        

monthlyRate = float(input("Configure Monthly Rate:\t"))
ham = float(input("Configure Years of investment:\t"))

def ytm(years):
    return int(round(years*12,0))

#calculate final value
final_value = str(calculateFutureValue(monthlyInvestment, monthlyRate, ytm(ham)))

# display the results
print("final value: $"+final_value)
