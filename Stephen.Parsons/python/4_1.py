"""
Store the code that gets user input and displays output in the main() function. 
Store the code that checks whether the number is even or odd in a separate function. 
Assume that the user will enter a valid integer. 
"""
def checkEvenOdd(num: int) -> int:
    if (num % 2 == 0):
        print(f"{num} is even")
        print()
    else:
        print(f"{num} is odd")
        print()
def displayTitle():
    print("Welcome to even odd checker")
def main():
    displayTitle()
    num = int(input("Please enter an integer: "))
    checkEvenOdd(num)
# if started as the main module, call the main() function
if __name__ == "__main__":
    main()
