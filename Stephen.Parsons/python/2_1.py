print ("Registration Form")
print ("\n")

firstName = input ("First Name: ")
lastName = input ("Last Name: ")
birthYear = input("Birth Year: ")

print ("\n\n")

print(f"Welcome {firstName} {lastName}!")
print("Your registration is complete.")
print(f"Your temporary password is: {firstName}*{birthYear}")
pwd = firstName + "*" + birthYear
print ("Your temporary password is: " + pwd)