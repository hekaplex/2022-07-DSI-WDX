def display_menu():
    print("Prime number checker\n")
    print("check  - check a number for being prime")
    print("exit - Exit program")
    print()

def check(num):
    num = int(input("Number?: "))
    if num < 1 or num > 5000:
        print("Invalid number.\n")



def main():
    num = 0
    list = []
    display_menu()
    while True:        
        command = input("Command: ")
        if command.lower() == "check":
            check(num)
            for i in range(num):
                print (i)
                if num % i == 0:
                    print(i)
                    list.append(i)
                print(list)
        elif command.lower() == "exit":
            break
        else:
            print("Not a valid command. ",
                "Please try again.\n")
    print("Bye!")
if __name__ == "__main__":
    main()