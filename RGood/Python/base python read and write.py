FILENAME = "/Users/shri/Downloads/PythonExamples/test.txt"
# Takes movies List and writes the list to actual file
def write_movies(movies):
    with open(FILENAME, "w") as file:
        for movie in movies:
            file.write(f"{movie}\n")    
# Reads actual file from the disk, converts that to a list (in memory)
# Returns the list to called
def read_movies():
    movies = []
    with open(FILENAME) as file:
        for line in file:
            line = line.replace("\n", "")
            movies.append(line)
    return movies
def list_movies(movies):
    for i, movie in enumerate(movies, start=1):
        print(f"{i}. {movie}")
    print()
def add_movie(movies):
    movie = input("Movie: ")
    movies.append(movie) # Appending to list (inmemory)
    write_movies(movies) # Flush the list to disk, and replace actual file
    print(f"{movie} was added.\n")
def delete_movie(movies):
    index = int(input("Number: "))   
    if index < 1 or index > len(movies):
        print("Invalid movie number.\n")
    else:
        movie = movies.pop(index - 1)
        write_movies(movies) # Flush the list to disk, and replace actual file
        print(f"{movie} was deleted.\n")
def display_menu():
    print("The Movie List program")
    print()
    print("COMMAND MENU")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()
def main():
    display_menu()
    movies = read_movies()
    while True:
        command = input("Command: ")
        if command.lower() == "list":
            list_movies(movies)
        elif command.lower() == "add":
            add_movie(movies)
        elif command.lower() == "del":
            delete_movie(movies)
        elif command.lower() == "exit":
            print("Bye!")
            break
        else:
            print("Not a valid command. ",
                  "Please try again.")
if __name__ == "__main__":
    main()