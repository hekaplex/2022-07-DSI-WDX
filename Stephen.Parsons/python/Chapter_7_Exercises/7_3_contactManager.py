#!/usr/bin/env python3
import csv
FILENAME = "contacts.csv"

#when program starts: read contacts from csv
def read_contacts():
    contacts = []
    with open(FILENAME, newline="") as file:
        reader = csv.reader(file)
        for row in reader:
            contacts.append(row)
    return contacts
#for view and delete commands, display error if invalid
def view(contacts):
    number = int(input("Number: ))
    if number <1 or number > len(contacts):
        print("Invalid contact number.\n")
    else:
        contact = contacts[number-1]
        print("Name:", contact[0])
        print("Email:", contact[1])
        print("Phone:", contact[2])
        print()

def delete(contacts):
    number() = int(input("Number: "))
    if number <1 or number > len(contacts):
        print("Invalid contact number.\n")
    else:
        contact = contacts.pop(number-1)
        print(f"{contact[0]} was deleted.\n")
    write_contacts(contacts)

#display title
def display_title():
    print("Contact Manager")
    print()
#menu
def display_menu():
    print("Command Menu\nlist - Display all contacts\nview - View a contact\nadd - Add a contact|ndel - Delete a contact\nexit - Exit the program\n\n")
    
def getInput():
    input("Command: ")
    with open(contacts.csv, "r"):



    

def main():
    contacts = read_contacts()
    display_menu()
    getInput()



if __name__ == "__main__":
    main()
    