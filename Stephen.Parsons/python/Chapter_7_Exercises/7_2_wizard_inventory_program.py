print("The Wizard Inventory Program")
print()
def display_menu():
    print("COMMAND MENU")
    print("walk - Walk down the path")
    print("show - Show all items")
    print("drop - Drop an item")
    print("exit - Exit program")
    print()
"""
#ask for input
input=("Command:")
if input=('walk'):
    with open(wizard_inventory.txt, "r"):
        for item1.random in wizard_all_items.txt:
            for item1 in wizard_inventory:
                if item1.wizard_all_items ==  item1.wizard_inventory:
                    for item1 in wizard_inventory:
                elif item1.wizard_al_items != item1.wizar_inventory:
                    input("While walking down a path, you see item1./nDo you want to grab it?  y/n : )
"""
import random

ITEMS_FILENAME = "wizard_all_items.txt"
INVENTORY_FILENAME = "wizard_inventory.txt"

def read_items():
    items = []
    with open(ITEMS_FILENAME) as file:
        for line in file:
            line = line.replace("\n", "")
            items.append(line)
    return items
    
def read_inventory():    
    inventory = []
    with open(INVENTORY_FILENAME) as file:
        for line in file:
            line = line.replace("\n", "")
            inventory.append(line)
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
    number = int(input("Number: "))
    if number < 1 or number > len(inventory):
        print("Invalid item number.\n")
    else:
        item = inventory.pop(number-1)
        print(f"You dropped {item}.\n")
        write_inventory(inventory)

def main():
    display_title()
    display_menu()

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
                  