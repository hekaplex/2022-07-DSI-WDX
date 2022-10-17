#!/usr/bin/env python3

import csv

# a file in the current directory
FILENAME = "monthly_sales.csv"

def write_sales(sales):
    with open(FILENAME, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(sales)

def read_sales():
    sales = []
    with open(FILENAME, newline="") as file:
        reader = csv.reader(file)
        for row in reader:
            sales.append(row)
    return sales

def view_monthly_sales(sales):
    for row in sales:
        print(f"{row[0]} - {row[1]}")
    print()

def view_yearly_summary(sales):
    total = 0
    for row in sales:
        amount = int(row[1])
        total += amount

    # get count
    count = len(sales)
    
    # calculate average
    average = total / count
    average = round(average, 2)

    # format and display the result
    print("Yearly total:    ", total)
    print("Monthly average: ", average)        
    print()

def edit(sales):
    names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    name = input("Three-letter Month: ")
    name = name.title()
    
    if name in names:
        index = names.index(name)
        amount = int(input("Sales Amount: "))
        
        month = []
        month.append(name)
        month.append(str(amount))
        
        sales[index] = month
        write_sales(sales)
        
        print(f"Sales amount for {month[0]} was modified.")
        print()
    else:
        print("Invalid three-letter month.")
        print()

def display_menu():
    print("COMMAND MENU")
    print("monthly - View monthly sales")
    print("yearly  - View yearly summary")
    print("edit    - Edit sales for a month")
    print("exit    - Exit program")
    print()    

def main():
    print("Monthly Sales program")
    print()
    
    sales = read_sales()
    display_menu()    
    while True:
        command = input("Command: ")
        if command == "monthly":
            view_monthly_sales(sales)
        elif command == "yearly":
            view_yearly_summary(sales)
        elif command == "edit":
            edit(sales)
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()
