print ("Shipping Calculator")
    
choice = "y"
while choice.lower() == "y":
    cost = float(input("Cost of items ordered: "))
    if cost <= 0:
        print("enter a number greater than 0")
    elif cost < 30:
        sc = 5.95
        print ("$",sc)
    elif cost <= 49.99:
        sc = 7.95
        print ("$",sc)
    elif cost <= 74.99:
        sc = 9.95
        print ("$",sc)
    else:
        sc = 0
        print ("Free")
    total = round(cost+sc,2)
    print (total)


    choice = input ("more shipping? (y/n): ")
print ("Have a great day!")