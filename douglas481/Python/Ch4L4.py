import SalesTaxAndTotalCost as ST
#title function
def title():
    print("Sales Tax Calculator")
    print()
#main function
def main():
    title()
    choice="y"
    while choice.lower() == "y":
        print("ENTER ITEMS (ENTER 0 TO END)")
        itemcost = 0.0000000001
        totalcost = 0
        while itemcost!=0:
            itemcost = float(input("Cost of item: "))
            totalcost = totalcost + itemcost
        (tax,total)=ST.salesTax(totalcost)
        print(f"Total: {totalcost}")
        print(f"Sales tax: {tax}")
        print(f"Total after tax: {total}")
        print()
        choice=input("Again? (y/n): ")
        print()
    print()
    print("Thanks, Bye!")
if __name__ == "__main__":
    main()