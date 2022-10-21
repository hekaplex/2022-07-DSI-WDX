#mile converter function
def mileCon(number):
    feet = int(round(number*5280))
    return feet
#title function
def title():
    print("Hike Calculator")
    print()
#main function
def main():
    title()
    num = float(input("How many miles did you walk today?:  "))
    feet = mileCon(num)
    print(f"You walked {feet} feet.")
if __name__ == "__main__":
    main()