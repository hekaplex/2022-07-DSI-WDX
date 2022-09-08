def calculateFutureValue(monthlyInvestment, monthlyRate, months):
#'''takes numbers and gives estimates'''    
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
                + monthlyRate
            )
#output of function
    return futureValue

monthlyInvestment = float(input("Configure Monthly Investment:\t"))
monthlyRate = float(input("Configure Monthly Rate:\t"))
months = int(input("Configure Months of investment:\t"))

print("expected yield: $",round(calculateFutureValue(monthlyInvestment, monthlyRate, months),2))