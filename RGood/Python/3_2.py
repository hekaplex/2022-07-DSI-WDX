
meal = input("Cost of meal: ")
print("Tip Calculator\n")

tip_15 = float(meal) * 0.15
tip_20 = float(meal) * 0.20
tip_25 = float(meal) * 0.25
total15 = float(meal) + float (tip_15)
total20 = float(meal) + float (tip_20)
total25 = float(meal) + float (tip_25)

print("15%")
print("\nTip amount:\t\t", tip_15)
print("Total amount:\t\t", total15)
print("20%")
print("\nTip amount:\t\t", tip_20)
print("Total amount:\t\t", total20)
print("25%")
print("\nTip amount:\t\t", tip_25)
print("Total amount:\t\t", total25)