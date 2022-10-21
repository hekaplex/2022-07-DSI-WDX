import random as r
#dice roll function
def dice():
    r1=r.randint(1,6)
    r2=r.randint(1,6)
    total=r1+r2
    if r1 ==1 and r2 == 1:
        print(f"Die 1: {r1}")
        print(f"Die 2: {r2}")
        print(f"Total: {total}")
        print("Snake eyes!")
    elif r1 == 6 and r2 == 6:
        print(f"Die 1: {r1}")
        print(f"Die 2: {r2}")
        print(f"Total: {total}")
        print("Boxcars!")
    else:
        print(f"Die 1: {r1}")
        print(f"Die 2: {r2}")
        print(f"Total: {total}")
#title function
def title():
    print("Dice Roller")
    print()
#main function
def main():
    title()
    choice=input("Roll the dice? (y/n): ")
    while choice.lower() == "y":
        dice()
        print()
        choice=input("Roll Again? (y/n): ")
        print()
    print()
    print("Thanks, Bye!")
if __name__ == "__main__":
    main()