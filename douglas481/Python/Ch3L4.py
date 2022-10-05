print("=================================")
print("Shipping Calculator")
print("=================================")
choice="y"
while choice.lower() == "y":
    cost = float(input ("Cost of items ordered: "))
    while cost<0:
        print("You must enter a positive number. Please try again.")
        cost = float(input ("Cost of items ordered: "))
    if cost<30:
        ship=5.95
    elif cost<50:
        ship=7.95
    elif cost<75:
        ship=9.95
    else:
        ship=0
    total=round(cost+ship,2)
    print(f"Shipping cost: {ship}")
    print(f"Total cost: {total}")
    print()
    choice=input("Continue? (y/n): ")
    print("=================================")
print("Bye!")