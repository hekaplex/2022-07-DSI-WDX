#title function
def title():
    print("Prime Number Checker")
    print()
#main function
def main():
    title()
    choice="y"
    while choice.lower() == "y":
        number=int(input("Please enter an integer between 1 and 5000: "))
        primelist=[]
        while number<1 or number>5000:
            print("Error, not a number between 1 and 5000")
            print()
            number=int(input("Please enter an integer between 1 and 5000: "))
        for num in range(1,number+1,1):
            if number%num==0:
                primelist.append(num)
        itemnumber=len(primelist)
        if itemnumber==2:
            print(f"{number} is a prime number.")
        else:
            print(f"{number} is NOT a prime number.")
            print(f"It has {itemnumber} factors: {primelist}")
        print()
        choice=input("Try again? (y/n): ")
        print()
    print()
    print("Bye!")
if __name__ == "__main__":
    main()