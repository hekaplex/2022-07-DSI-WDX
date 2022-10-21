"""
Functions Storage Module [saved in conversions.py]
"""
import conversions as c 
"""
Title function
"""
def displayTitle():
    print("Feet and Meters Converter")
    print()
"""
Menu Function
"""
def conversion_menu():
    print("Conversions Menu: ")
    print("a. Feet to Meters")
    print("b. Meters to Feet")
"""
Input/Output Fields [in main function]
"""
def main():
    displayTitle()
    again = 'y'
    while again.lower() == 'y':
        conversion_menu()
        choice = input("Select a conversion (a/b): ")#takes input
        print()
        if choice == 'a':
            feet = float(input("Enter feet: "))
            meters = c.feet_to_meters(feet)
            print(round(meters, 2),'meters')
        elif choice == 'b':
            meters = float(input("Enter meters: "))
            feet = c.meters_to_feet(meters)
            print(round(feet, 2),'feet')
        else:
            print('You did not enter a valid selection.')
            print()
        again = input("Would you like to perform another conversion? (y/n): ")
    print() 
print("Thanks, bye!")
if __name__ == "__main__":
    main()    

   