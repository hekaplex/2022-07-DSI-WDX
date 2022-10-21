print ("Tip Calculator")
print()
mealCost = (float(input("Cost of a meal: ")))
tipPercent = (float(input("Tip percent: ")))
tipAmount = round(float(mealCost) * (float(tipPercent) / 100),2)
totalAmount = mealCost + tipAmount
print(("Cost of a meal: "), mealCost)
print(("Tip Percent: "), tipPercent)
print()
print(("Tip Amount: "), tipAmount)
print(("Total Amount: "), totalAmount)

