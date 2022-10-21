print("Change Calculator")
print()
choice="y"
while choice.lower() == "y":
    cents = int(input ("Enter number of cents (0-99): "))
    quarters=cents//25
    qremain=cents-(quarters*25)
    dimes=qremain//10
    dremain=qremain-(dimes*10)
    nickels=dremain//5
    nremain=dremain-(nickels*5)
    pennies=nremain
    print(f"Quarters: {quarters}")
    print(f"Dimes: {dimes}")
    print(f"Nickels: {nickels}")
    print(f"Pennies: {pennies}")
    print()
    choice=input("Continue? (y/n): ")
    print()
print("Bye!")