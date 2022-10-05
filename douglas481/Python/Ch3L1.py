from secrets import choice


print("Letter Grade Calculator")
print()
choice="y"
while choice.lower() == "y":
    grade = int(input ("Enter numerical grade: "))
    if grade>=88:
        letter="A"
    elif grade>=80:
        letter="B"
    elif grade>=67:
        letter="C"
    elif grade>=60:
        letter="D"
    else:
        letter="F"
    print(f"Letter Grade: {letter}")
    print()
    choice=input("Continue? (y/n): ")
    print()
print("Bye!")