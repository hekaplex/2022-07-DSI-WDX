print("Letter Grade Converter")
print()
choice = "y"
while choice.lower() == "y":
    grade = int(input("Enter numerical grade: "))
    
    if grade >= 88 and grade <=100:
            letter = "A"
    elif grade >= 80:
            letter = "B"
    elif grade >= 67:
            letter = "C"
    elif grade >= 60:
            letter = "D"
    else:
        letter = "F"
    print("Letter grade: ", letter)
    print()
    choice = input("Continue (y/n)?: ") 
    print()
print("Bye!")




