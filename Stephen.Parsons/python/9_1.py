"""The formula for calculating the interest amount is: loan_amount * (interest_rate / 100) -- DONE
Use the Decimal class to make sure that all calculations are accurate. It should round the interest that’s 
calculated to two decimal places, rounding up if the third decimal place is five or greater. 
The interest rate that’s displayed can have up to 3 decimal places.
 Assume that the user will enter valid decimal values for the loan amount and interest rate.
  """
import locale as lc
lc.setlocale(lc.LC_ALL, "en_US")     
def displayTitle():
    print("\nInterest Calculator\n")
def calculateInterest(loanAmt, intestRate):
    return (loanAmt * (intestRate / 100))
def main():
    while True:
        displayTitle()
        # Get User Input        
        loanAmt = float(input("Enter Loan Amount: "))
        interestRate = float(input("Enter interest rate: "))
        # lc.currency(12345.15, grouping=True)        
        interestAmt = calculateInterest(loanAmt, interestRate)
        print(f"Loan Amount: {lc.currency(loanAmt, grouping=True)}")
        print(f"Interest Rate: {lc.currency(interestRate, grouping=True)}")
        print(f"Interest Amount: {lc.currency(interestAmt, grouping=True)}")
        choice = input("Continue (y/n): ")
        if choice.lower() == "n":
            break    
    print("Bye!")
if __name__ == "__main__":
    main()