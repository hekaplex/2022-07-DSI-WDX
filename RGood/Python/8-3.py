#!/usr/bin/env python3

import csv
import sys  

# a file in the current directory
FILENAME = "contact.csv"

def write_contacts(contacts):
    with open(FILENAME, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(contacts)   

def read_contacts():
    contacts = []
    try:
        with open(FILENAME, newline="") as file:
            reader = csv.reader(file)
            for row in reader:
                contacts.append(row)
        return contacts
    except FileNotFoundError as e:
        print("no contact file currently exists")
        open(FILENAME, "a+")
        print("creating file now")


def display(contacts):
    try:
        if len(contacts) == 0:
            print("There are no contacts in the list.\n")
            return
        else:
            for i, row in enumerate(contacts, start=1):
                print(f"{i}. {row[0]}")
            print()        
    except FileNotFoundError as e:
        print("no contact file currently exists")
        open(FILENAME, "a+")
        print("creating file now")

def add(contacts):
    name = input("Name: ")
    email = input("Email: ")
    phone = input("Phone: ")
    
    contact = []
    contact.append(name)
    contact.append(email)
    contact.append(phone)
    contacts.append(contact)
    write_contacts(contacts)
    
    print(f"{contact[0]} was added.")   
    print()

def view(contacts):
    try:
        number = int(input("Number: "))
        if number < 1 or number > len(contacts):
            print("Invalid contact number.\n")
        else:
            contact = contacts[number-1]
            print("Name:", contact[0])
            print("Email:", contact[1])
            print("Phone:", contact[2])
            print()
    except ValueError as e:
        print("That is not a valid integer, please try again")
        view(contacts)


        
def delete(contacts):
    try:
        number = int(input("Number: "))
        if number < 1 or number > len(contacts):
            print("Invalid contact number.\n")
        else:
            contact = contacts.pop(number-1)
            print(f"{contact[0]} was deleted.\n")
        write_contacts(contacts)
    except ValueError as e:
        print("That is not a valid integer, please try again")
        delete(contacts)



def display_title():
    print("Contact Manager")
    print()

def display_menu():
    print("COMMAND MENU")
    print("list - Display all contacts")
    print("view - View a contact")
    print("add  - Add a contact")
    print("del  - Delete a contact")
    print("exit - Exit program")
    print()    

def main():
    contacts = read_contacts()
    display_title()    
    display_menu()    
    while True:
        command = input("Command: ")
        if command == "list":
            display(contacts)
        elif command == "view":
            view(contacts)
        elif command == "add":
            add(contacts)
        elif command == "del":
            delete(contacts)
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()
