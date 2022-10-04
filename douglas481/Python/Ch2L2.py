print("Pay Check Calculator")
print("\n")
taxRate= 18 #percent
hoursWorked = float(input ("Hours Worked: "))
hourlyPayRate = float(input ("Hourly Pay Rate: "))
grossPay=round(hoursWorked*hourlyPayRate,2)
taxAmount=round(grossPay*(taxRate/100),2)
takeHomePay=grossPay-taxAmount
print("\n")
print(f"Gross Pay: {grossPay}")
print(f"Tax Rate: {taxRate}%")
print(f"Tax Amount: {taxAmount}")
print(f"Take Home Pay: {takeHomePay}")