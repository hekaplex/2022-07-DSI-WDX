import random
import sys

ITEMS_FILENAME = "wizard_all_items.txt"
INVENTORY_FILENAME = "wizard_inventory.txt"

def read_items():
    items = []
    try:
        with open(ITEMS_FILENAME) as file:
            for line in file:
                line = line.replace("\n", "")
                items.append(line)
        return items
    except FileNotFoundError as e:
        print("Could not find items file.")
        print("Exiting program. Bye!")
        sys.exit()
    
def read_inventory():    
    inventory = []
    try:
        with open(INVENTORY_FILENAME) as file:
            for line in file:
                line = line.replace("\n", "")
                inventory.append(line)
    except FileNotFoundError as e:
        print("Could not find inventory file!")
        print("Wizard is starting with no inventory.")
        print()    

    return inventory    

def write_inventory(inventory):
    with open(INVENTORY_FILENAME, "w") as file:
        for item in inventory:
            file.write(item + "\n")

def display_title():
    print("The Wizard Inventory program")
    print()    

def display_menu():
    print("COMMAND MENU")
    print("walk - Walk down the path")
    print("show - Show all items")
    print("drop - Drop an item")
    print("exit - Exit program")
    print()

def walk(inventory):
    items = read_items()
    remaining_items = [i for i in items if i not in inventory]    
    item = random.choice(remaining_items)
    print(f"While walking down a path, you see {item}.")
    choice = input("Do you want to grab it? (y/n): ")
    if choice == "y":
        if len(inventory) >= 4:
            print("You can't carry any more items. Drop something first.\n")
        else:
            inventory.append(item)
            print(f"You picked up {item}.\n")
            write_inventory(inventory)

def show(inventory):
    for number, item in enumerate(inventory, start=1):
        print(f"{number}. {item}")
    print()

def drop_item(inventory):
    try:
        number = int(input("Number: "))
    except ValueError:
        print("Invalid item number.\n")
        return
    
    if number < 1 or number > len(inventory):
        print("Invalid item number.\n")
    else:
        item = inventory.pop(number-1)
        print(f"You dropped {item}.\n")
        write_inventory(inventory)

def main():
    display_title()
    display_menu()

    items = read_items()   # check this file right away
    inventory = read_inventory()
    while True:        
        command = input("Command: ")        
        if command == "walk":
            walk(inventory)
        elif command == "show":
            show(inventory)
        elif command == "drop":
            drop_item(inventory)
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()