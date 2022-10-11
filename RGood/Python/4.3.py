"""

The formula for converting feet to meters is: feet = meters / 0.3048 
The formula for converting meters to feet is: meters = feet * 0.3048 
Store the code that performs the feet to meters and meters to feet conversions in functions within a module. 
Store the code that displays the title in its own function, and store the code that displays the menu in its own function, but store the rest of the code that gets input and displays output in the main() function. 
Assume the user will enter valid data. 
The program should round results to a maximum of two decimal places. 

"""

import distanceConverter as d

def displayTitle():
    print("Let's do some conversions?")  
     

def main():
    displayTitle()

    choice = 'y'
    while choice.lower() == 'y':
        answer = str(input("Starting with meters or feet? (m/f) "))
        if answer.lower() =='m':        
            num = float(input("Please enter # of meters: "))
            d.meterFeet(num)
        elif answer.lower() =='f':
            num = float(input("Please enter # of feet: "))
            d.feetMeter(num)
        else:
            print ("input a correct value next time")


    choice = input("Would you like to do some more conversions? (y/n)")  
    print ("Have a great day!")


    num = float(input("Please enter # of feet: "))
    num = float(input("Please enter # of meters: "))



if __name__ == "__main__":
   main()


