import MeterFeetConvModule as con
#title function
def title():
    print("Feet and Meters Converter")
    print()
#menu function
def menu():
    print("Conversions Menu:")
    print("a. Feet to Meters")
    print("b. Meters to Feet")
#main function
def main():
    title()
    menu()
    choice="y"
    while choice.lower() == "y":
        conversionChoice = input("Select a conversion (a/b): ")
        if conversionChoice=="a":
            print()
            feet=float(input("Enter feet: "))
            meters=con.f2m(feet)
            print(f"{meters} meters.")
        elif conversionChoice=="b":
            print()
            meters=float(input("Enter meters: "))
            feet=con.m2f(meters)
            print(f"{feet} feet.")
        else:
            print()
            print("Please choose one of the given conversion")
        print()
        choice=input("Would you like to perform another conversion? (y/n): ")
    print()
    print("Thanks, Bye!")
if __name__ == "__main__":
    main()