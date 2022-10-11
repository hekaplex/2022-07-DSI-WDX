
print ("Letter Grade Converter")
    
choice = "y"
while choice.lower() == "y":
    num_grade = int(input("Enter numerical grade: "))
    if num_grade >= 88:
        lg = "A"
    elif num_grade >= 80:
        lg = "B"
    elif num_grade >= 67:
        lg = "C"
    elif num_grade >= 60:
        lg = "D"
    else:
        lg = "F"
    letter_grade = lg
    print (lg)

    choice = input ("more grades? (y/n): ")
print ("Have a great day!")