from decimal import Decimal
import locale as lc

def display_menu():
    print("\nMonthly Payment Calculator\n\n")

def getInput(): 
    loan_amount=float(input("Loan amount: ")) 
    interest=float(input("yearly interest rate: ")) 
    years=input("Years: ")
    months=float(years*12)
    monthly_interest_rate= ((loan_amount*interest)/months)
    monthly_payment = loan_amount * monthly_interest_rate / (1 - 1 / (1 + monthly_interest_rate * months))
    print("DATA ENTRY")
    print() 
    print("FORMATTED RESULTS")
    print("Loan amount: $",loan_amount)
    print("Yearly interest rate: ",interest,"%")
    print("Number of years: ",years)
    print("Monthly payment: $",monthly_payment)
 



def main():
    display_menu()
    getInput()
        
    again = "y"
    while again.lower() == "y":
        again = input("Again? (y/n): ")
        main()
    else:    
        print("Thanks, bye!")
    


if __name__=="__main__":
    main()

'''  
 #!/usr/bin/env python3

from decimal import Decimal
import locale as lc

def calculate_monthly_payment(loan_amount, yearly_interest_rate, years):
    # convert yearly values to monthly values
    monthly_interest_rate = yearly_interest_rate / 12 / 100
    months = years * 12

    # calculate monthly payment
    monthly_payment = loan_amount * monthly_interest_rate / \
                      (1 - 1 / (1 + monthly_interest_rate) ** months)
    
    return monthly_payment

def main():
    print("Monthly Payment Calculator")
    print()
    
    choice = "y"
    while choice.lower() == "y":
        print("DATA ENTRY")
        loan_amount = Decimal(input("Loan amount:          "))
        interest_rate = Decimal(input("Yearly interest rate: "))
        years = int(input("Years:                "))
        print()

        # quantize the entries
        loan_amount = loan_amount.quantize(Decimal("1.12"))
        interest_rate = interest_rate.quantize(Decimal("1.1"))

        # calculate and quantize the results
        monthly_payment = calculate_monthly_payment(loan_amount, interest_rate, years)
        monthly_payment = monthly_payment.quantize(Decimal("1.12"))

        print("FORMATTED RESULTS")
        lc.setlocale(lc.LC_ALL, "en_US")
        loan_amount = lc.currency(loan_amount, grouping=True)
        monthly_payment = lc.currency(monthly_payment, grouping=True)
        
        w1 = 22
        w2 = 16
        print(f"{'Loan amount:':{w1}} {loan_amount:>{w2}}")
        print(f"{'Yearly interest rate:':{w1}}",
              f"{interest_rate:>{w2-1}}%") # subtract 1 to accommodate '%' char
        print(f"{'Number of years:':{w1}} {years:>{w2}}")
        print(f"{'Monthly payment:':{w1}} {monthly_payment:>{w2}}")
        print()

        choice = input("Continue? (y/n): ")
        print()

    print("Bye!")

if __name__ == "__main__":
    main()
''' 