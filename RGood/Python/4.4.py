"""
The sales tax rate should be 6% of the total. 
Store the sales tax rate in a module. This module should also contain functions that calculate the sales tax and the total after tax. These functions should round the results to a maximum of two decimal places. 
Store the code that gets input and displays output in the main() function. Divide this code into functions whenever you think it would make that code easier to read and maintain. 
Assume the user will enter valid data.
"""

def taxRate(items:float):
    taxRate = 0.6
    tax = taxRate * items
    total = round(items + tax, 2)
    return total


def displayTitle():
    print("Tax season already?")  

def main():
    displayTitle()
    items = float(0)
    choice = 'y'
    while choice.lower() == 'y':
        
        while itemCost := float(input("Ener cost of item: ")) != 0:
            if itemCost == 0:
                exit()
            else :
                items = float(items + itemCost)


        choice = input("More receipts? (y/n)")  
    print ("Have a great day!")



if __name__ == "__main__":
    main()



