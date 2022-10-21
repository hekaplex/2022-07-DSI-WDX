number = 1
list = []
number = int(input("what is the number?:  "))
for i in range (number):
    if number%(i+1) == 0:
        list.append(i+1)
if list == [1,number]:
    print("that is a prime number")
else:
    print("not prime")
print (i+1)
print (list)