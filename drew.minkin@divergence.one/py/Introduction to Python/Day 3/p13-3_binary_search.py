import random

def main():
    print("Binary Search")
    print()
    intCounter = int(input("Number of random numbers: "))
    print("Enter 'x' to exit")
    print()

    numbers = []
    for i in range(intCounter):
        numbers.append(random.randint(1, 1000))
    numbers.sort()
    print("Random numbers: ", numbers)
    print()

    while True:
        number = input("Enter a number from 1 to 1000: ")
        if number == 'x':
            print("Bye!")
            break

        number = int(number)
        end_index = len(numbers)
        if search(numbers, number, 0, end_index):
            print(number, "is in random numbers.")
        else:
            print(number, "is NOT in random numbers.")
        print()
    

def search(numbers, number, start, end):
    print("evaluating: ",numbers, number, start, end)
    if start == end:
        return False

    middle = (start + end) // 2

    if number == numbers[middle]:
        return True
    elif number < numbers[middle]:
        return search(numbers, number, start, middle)
    else:
        return search(numbers, number, middle+1, end)    

if __name__ == "__main__":
    main()
