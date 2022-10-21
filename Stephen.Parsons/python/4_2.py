def displayTitle():
    print("Hike Calculator")
    print()

def milesToFeet(miles):
    feet = miles * 5280
    feet = int(feet)
    return feet

def main():
    displayTitle()
    miles = float(input("How many miles did you walk?: "))
    feet = milesToFeet(miles)
    print(f"You walked {feet} feet.")

if __name__ == "__main__":
    main()
"""
Why is the whole thing upside down and backwards?
"""