#even checker function
def evenChecker(number):
    if number%2==0:
        return True
    else:
        return False
#main function
def main():
    print("Even or Odd Checker")
    print()
    num = int(input("Enter an integer:  "))
    if evenChecker(num):
        print("This is an even number.")
    else:
        print("This is an odd number.")
if __name__ == "__main__":
    main()