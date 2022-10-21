
hours = input("Enter hours worked this week: ")
wage = input("Enter pay rate: ")
print("Pay Check Calculator")

gross_pay = float(hours)*float(wage)
tax_rate = float(18)
tax_amount = gross_pay*(tax_rate/100)
take_home = gross_pay-tax_amount

print("Hours Worked:\t\t", hours)
print("Hourly Pay Rate:\t", wage)
print("\nGross Pay:\t\t", gross_pay)
print("Tax Rate:\t\t", str(tax_rate) + "%")
print("Tax Amount:\t\t", tax_amount)
print("Take Home Pay:\t\t", take_home)
