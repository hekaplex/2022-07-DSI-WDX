
meal = input("Cost of meal: ")
tip_percent = input("Tip Percentage: ")
print("Tip Calculator\n")

tip_amount = float(meal) * (float(tip_percent) /float(100) )
total = float(meal) + float (tip_amount)

print("Cost of meal:\t\t", meal)
print("Tip percent:\t\t", tip_percent)
print("\nTip amount:\t\t", tip_amount)
print("Total amount:\t\t", total)

