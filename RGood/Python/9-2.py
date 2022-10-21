"""
The interest rate should only have 1 decimal place for both the calculation and the 
formatted results. 
 The formula for calculating monthly payment is: 
monthly_payment = loan_amount * monthly_interest_rate / 
 (1 - 1 / (1 + monthly_interest_rate) ** months) 
 Assume that the user will enter valid data.
"""


import locale as lc
lc.setlocale(lc.LC_ALL, "en_US") 


def displayTitle():
    print("\Monthly Payment Calculator\n")


def monthlyPayment(loanAmt, interestRate, years):
    return (loanAmt*interestRate/(1-1/(1+interestRate)**(years*12)))


def main():
    while True:
        displayTitle()
        # Get User Input        loanAmt = float(input("Enter Loan Amount: "))
        loanAmt = float(input("Enter loan amount: "))
        interestRate = float(input("Enter interest rate: "))
        years = float(input("Enter years: "))
        # lc.currency(12345.15, grouping=True)        interestAmt = calculateInterest(loanAmt, interestRate)
        print(f"Loan Amount: {lc.currency(loanAmt, grouping=True)}")
        print(f"Yearly Interest Rate: %{lc.currency(interestRate, grouping=True)}")
        print(f"Monthly payment: {lc.currency(monthlyPayment, grouping=True)}")
        choice = input("Continue (y/n): ")
        if choice.lower() == "n":
            break
        print("Bye!")



if __name__ == "__main__":
    main()