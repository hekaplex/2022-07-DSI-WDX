print("Tip Calculator")
print()

meal_cost = float(input("Cost of meal: "))
print()

for tip_percent in range(15, 27, 5):
    print(f"{tip_percent}%")

    tip_percent = tip_percent / 100
    tip_amount = round(meal_cost * tip_percent, 2)
    total = round(meal_cost + tip_amount, 2)

    print("Tip amount:  ", tip_amount)
    print("Total amount:", total)
    print()
