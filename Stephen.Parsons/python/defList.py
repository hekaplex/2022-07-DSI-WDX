def list(movie_list):
    if len(movie_list) == 0:
        print("There are no movies in the list.\n")
    else:
         for i, movie in enumerate(movie_list, start=1):
             print(f"{i}. {movie[0]} ({movie[1]})")
    print()
def add(movie_list):
    name = input("Name: ")
    year = input("Year: ")
    movie = [name, year] # Creating movie list
    movie_list.append(movie)
    print(f"{movie[0]} was added.\n")   
def delete(movie_list):
    number = int(input("Number: "))
    if number < 1 or number > len(movie_list):
        print("Invalid movie number.\n")
    else:
        movie = movie_list.pop(number-1)
        print(f"{movie[0]} was deleted.\n")
def display_menu():
    print("COMMAND MENU")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()    
def main():
    movie_list = [["Monty Python and the Holy Grail", 1975],
                  ["On the Waterfront", 1954],
                  ["Cat on a Hot Tin Roof", 1958]]
    display_menu()
    while True:        
        command = input("Command: ")
        if command.lower() == "list":
            list(movie_list)
        elif command.lower() == "add":
            add(movie_list)
        elif command.lower() == "del":
            delete(movie_list)
        elif command.lower() == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")
