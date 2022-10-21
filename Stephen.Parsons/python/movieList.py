choice = 'y'
def display_menu():
    print("Try again?  y/n")
    print()
def list(numbers_list):
    for i, nums in enumerate(numbers_list, start=0):
        print(f"{i}. {nums}")
    print()
def picknum(numbers_list):
    number = input(int("Enter an integer between 1 and 5000: "))
    numbers_list.append(list)
    print(f"{nums} was added.\n")
def delete(movie_list):
    number = int(input("Number: "))
    if number < 1 or number > len(movie_list):
        print("Invalid movie number.\n")
    else:
        movie = movie_list.pop(number-1)
        print(f"{movie} was deleted.\n")
def main():
    numbers_list = range[5001]
    display_menu()
    while choice.lower() = 'y':        
        
        if numbers_list.nums() == "list":
            list(movie_list)   
        elif command.lower() == "add":
            add(movie_list)
        elif command.lower() == "del":
            delete(movie_list)  
        elif command.lower() == "exit":
            break        else:
            print("Not a valid command. ",
                  "Please try again.\n")
    print("Bye!")
if __name__ == "__main__":
    main()