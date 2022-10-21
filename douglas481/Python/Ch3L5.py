print("Table of Powers")
print()
start = int(input ("Start number: "))
stop = int(input ("Stop number: "))
while stop<start:
    print("You must enter a stop number that is higher than the start number. Please try again.")
    start = int(input ("Start number: "))
    stop = int(input ("Stop number: "))
print("Number\tSquared\tCubed")
print("=====\t=====\t=====")
for number in range(start,(stop+1)):
    print(f"{number}\t{number**2}\t{number**3}")