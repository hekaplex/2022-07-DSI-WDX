#inventory list
inventory=["wine","grapes","ring of power"]
#title function
def title():
    print("The Wizard Inventory Program")
    print()
#display menu function
def display_menu():
    print("COMMAND MENU")
    print("show - Show all items")
    print("grab - Grab an item")
    print("edit - Edit an item")
    print("drop - Drop an item")
    print("exit - Exit program")
    print()
#show function
def show(inventory):
    for i, item in enumerate(inventory, start=1):
        print(f"{i}. {item}")
#grab function
def grab(inventory):
    if len(inventory)>=4:
       print("You can't carry any more items. Drop something first.")
       print()
    else:
        item= input("Name: ")
        inventory.append(item)
        print(f"{item} was added")
        print()
#edit function
def edit(inventory):
    number = int(input("Number: "))
    if number < 1 or number>len(inventory):
        print("Invalid item number.")
        print()
    else:
        newItem= input("Updated name: ")
        inventory.pop(number-1)
        inventory.insert(number-1,newItem)
        print(f"Item number {number} was updated.")
        print()
#drop function
def drop(inventory):
    number = int(input("Number: "))
    if number < 1 or number>len(inventory):
        print("Invalid item number.")
        print()
    else:
        item = inventory.pop(number-1)
        print(f"{item} was dropped.")
        print()
#main function
def main():
    title()
    display_menu()
    choice=input("Command: ")
    while choice != "exit":
        if choice=="show":
            show(inventory)
            choice=input("Command: ")
        elif choice=="grab":
            grab(inventory)
            choice=input("Command: ")
        elif choice=="edit":
            edit(inventory)
            choice=input("Command: ")
        elif choice=="drop":
            drop(inventory)
            choice=input("Command: ")
        else:
            print("Invlaid command")
            choice=input("Command: ")
    print()
    print("Bye!")
if __name__ == "__main__":
    main()