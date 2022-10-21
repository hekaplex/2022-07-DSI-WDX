print ("Change Calculator")

choice = "y"
while choice.lower() == "y":
    cents = int(input("Enter amount of change: "))
    if cents > 0:
        print ("Quarters: ", cents//25)
        print ("Quarters: ", ((cents%25)//10))
        print ("Quarters: ", (((cents%25)%10)//5))
        print ("Quarters: ", ((((cents%25)%10)%5//1)))

    choice = input ("more coins? (y/n): ")
print ("Great counting money with you!")