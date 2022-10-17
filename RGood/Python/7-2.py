FILENAME = "G:\DSI-Hekaplex-Clone\\2022-07-DSI-WDX\RGood\Python\\Wizard-bag.txt"
ITEMFILE = "G:\DSI-Hekaplex-Clone\\2022-07-DSI-WDX\RGood\Python\\wizard_all_items.txt"
# Takes movies List and writes the list to actual file

def write_item(bag):
    with open(FILENAME, "w") as file:
        for item in bag:
            file.write(f"{item}\n")    

# Reads actual file from the disk, converts that to a list (in memory)
# Returns the list to called


def rand_selector():
    bag = []
    with open(ITEMFILE) as file:
        for line in file:
            line = line.replace("\n", "")
            bag.append(line)
    return bag
    

def rand_selector():
    rules = []
    with open(FILENAME,"r") as file:
        rulesList = file.readlines()
        print(rulesList[0])


def read_item():
    bag = []
    with open(FILENAME) as file:
        for line in file:
            line = line.replace("\n", "")
            bag.append(line)
    return bag


def list_item(bag):
    for i, bag in enumerate(bag, start=1):
        print(f"{i}. {bag}")
    print()


def walk(bag):

    While walking down a path, you see

    item = input("Item: ")
    bag.append(item) # Appending to list (inmemory)
    write_item(bag) # Flush the list to disk, and replace actual file
    print(f"{item} was added.\n")


def delete_item(bag):
    index = int(input("Number: "))   
    if index < 1 or index > len(bag):
        print("Invalid movie number.\n")
    else:
        item = bag.pop(index - 1)
        write_item(bag) # Flush the list to disk, and replace actual file
        print(f"{item} was deleted.\n")


def display_menu():
    print("The Wizard Inventory Program")
    print()
    print("COMMAND MENU")
    print("list - List all items")
    print("walk - walk down a path")
    print("del -  Delete a item")
    print("exit - Exit bag")
    print()


def main():
    display_menu()
    bag = read_item()
    while True:
        command = input("Command: ")
        if command.lower() == "list":
            list_item(bag)
        elif command.lower() == "add":
            walk(bag)
        elif command.lower() == "del":
            delete_item(bag)
        elif command.lower() == "exit":
            print("Bye!")
            break
        else:
            print("Not a valid command. ",
                  "Please try again.")


if __name__ == "__main__":
    main()