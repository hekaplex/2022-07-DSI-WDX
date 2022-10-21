print ("Pay Check Calculator")
print ()
hoursWorked = (input ("Hours Worked: "))
hourlyRate =(input ("Hourly Pay Rate: "))
print()
grossPay = (float(hoursWorked) * float(hourlyRate))
taxRate = 18
taxAmount = grossPay * (taxRate / 100)
takeHomePay = grossPay - taxAmount
print(("Gross Pay: "), grossPay)
print(("Tax Rate: "), taxRate,'%')
print(("Tax Amount: "), taxAmount)
print(("Take Home Pay: "), takeHomePay)


