"""
The program should accept decimal entries like 52.31 and 15.5 for the cost of the meal. - DONE 
The program should accept integer entries like 15, 20, and 25 for the tip percent. - DONE
The program should validate both user entries. - IN PROGRESS
That way, the user can't crash the program by entering invalid data. - DONE
The program should only accept numbers that are greater than 0. - DONE
The program should round results to a maximum of two decimal places. - DONE
"""
# Display title
def displayTitle():
    print("\nWelcome to TIP Calculator\n\n")
# Input Cost of the meal
def inputMealCost():
    while True:
        try:
            mealCost = float(input("Please enter your cost of the meal: "))
            if mealCost > 0:
                # print("Meal cost is more than 0")
                return mealCost
            else:
                print("Please enter meal cost more than 0")
        except ValueError:
            print("Invalid input. Please enter valid  numbers.")
# Input tip percentage
def inputTipPercentage():
    while True:
        try:
            tipPercent = int(input(f"Please enter tip in integer without the % sign: "))
            if tipPercent > 0:
                # print("Meal cost is more than 0")
                return tipPercent
            else:
                print("Try Again. Enter valid tip amount. Must be greater than 0")
        except ValueError:
            print("Invalid input. Please enter valid integer numbers.")
# Total Calculation 
def calculateTotalAmount(mealCost, tipPercent):
    tipAmount = mealCost * (tipPercent/100)
    print(f"Tip Amount: {tipAmount}")
    totalAmount = mealCost + tipAmount
    return round(totalAmount,2)
def main():
    while True:
        displayTitle()
        mealCost = inputMealCost()
        print(f"\nMeal Cost: {mealCost}")
        tipPercent = inputTipPercentage()
        print(f"\nTip Percent: {tipPercent}")
        totalAmount = calculateTotalAmount(mealCost, tipPercent)
        print (f"Your total due is: {totalAmount}")
        choice = input("Continue (y/n): ")
        if choice.lower() == 'n':
            break
    print("\n Bye!! Thank you! \n")
if __name__ == "__main__":
    main()