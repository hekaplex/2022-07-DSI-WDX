#c/p
import locale as lc

sales = [[1540.0, 2010.0, 2450.0, 1845.0], # Region 1 
 [1130.0, 1168.0, 1847.0, 1491.0], # Region 2 
 [1580.0, 2305.0, 2710.0, 1284.0], # Region 3 
 [1105.0, 4102.0, 2391.0, 1576.0]] # Region 4 

 def sales_by_region():
    print(f"{'Region':40, {'      Q1':>8} {'      Q2':>16}, {'      Q3':>24} {'      Q4':>32}")
    print(f"{sales[1,1]':40, {'      Q1':>8} {'      Q2':>16}, {'      Q3':>24} {'      Q4':>32}")
    #print(f"{'Region':8}{'Q1':>{w}}{'Q2':>{w}}{'Q3':>{w}}{'Q4':>{w}}")



def sales_by_quarter():

def display_title():
    print("Sales Report")
    print()


def main():
    display_title()
    sales_by_region()
    sales_by_quarter()


if __name__=="__main__":
    main()






'''
#!/usr/bin/env python3

import locale as lc

def format_as_currency(value):
    return lc.currency(value, grouping=True)

def main():
    print("Sales Report")
    print()

    sales = [[1540.0, 2010.0, 2450.0, 1845.0],  # Region 1
             [1130.0, 1168.0, 1847.0, 1491.0],  # Region 2
             [1580.0, 2305.0, 2710.0, 1284.0],  # Region 3
             [1105.0, 4102.0, 2391.0, 1576.0]]  # Region 4

    w = 12
    lc.setlocale(lc.LC_ALL, "en_US")
    
    # print all sales    
    print(f"{'Region':8}{'Q1':>{w}}{'Q2':>{w}}{'Q3':>{w}}{'Q4':>{w}}")
    for number, region in enumerate(sales, start=1):  
        q1 = format_as_currency(region[0])
        q2 = format_as_currency(region[1])
        q3 = format_as_currency(region[2])
        q4 = format_as_currency(region[3])
        print(f"{number:<8d}{q1:>{w}}{q2:>{w}}{q3:>{w}}{q4:>{w}}")
    print()
    
    # print sales by region
    print("Sales by region:")
    for number, region in enumerate(sales, start=1):
        total = 0
        for quarter in region:
            total += quarter
        total = format_as_currency(total)
        print(f"Region {number}:  {total}")
    print()

    # print sales by quarter
    print("Sales by quarter:")
    for number, quarter in enumerate(range(4), start=1):
        total = 0.0
        for region in range(len(sales)):
            total += sales[region][quarter]
        total = format_as_currency(total)
        print(f"Q{number}:        {total}")
    print()

    # print the total annual sales
    total = 0.0
    for region in sales:
        for quarter in region:
            total += quarter
    total = format_as_currency(total)
    print(f"Total annual sales, all regions:   {total}")

if __name__ == "__main__":
    main()
'''