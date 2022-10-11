"""
The program should accept a float value for the number of miles. 
Store the code that displays the title in a separate function. 
Store the code that converts miles to feet in a separate function. This function should return an int value for the number of feet. 
There are 5280 feet in a mile. 
Store the code that gets user input and displays output in the main() function. 
Assume that the user will enter a valid number of miles. 

"""


def milesFeet(num: float) ->int:
    feet = int(num * int(5280))
    print (f"{feet} feet walked")
    print()
    return feet 

def displayTitle():
    print("Welcome to the jungle.... I mean distance calculator")   

def main():
    displayTitle()

    num = float(input("Please enter # of miles: "))

    milesFeet(num)


if __name__ == "__main__":
    main()