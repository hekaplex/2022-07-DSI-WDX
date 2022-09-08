#!/usr/bin/env python3

class Person:
    def __init__(self, firstName, lastName,
                 email):
        self.firstName = firstName
        self.lastName = lastName
        self.email = email

    def getFullName(self):
        return self.firstName + " " + self.lastName

class Customer(Person):
    def __init__(self, firstName, lastName,
                 email, number):
        Person.__init__(self, firstName, lastName, email)
        self.number = number

class Employee(Person):
    def __init__(self, firstName, lastName,
                 email, ssn):
        Person.__init__(self, firstName, lastName, email)
        self.ssn = ssn
    
def main():
    print("Customer/Employee Data Entry")
    print()

    while True:
        choice = input("Customer or employee? (c/e): ")
        print()

        if choice == "c":
            customer = get_input(choice)
            print()
            display(customer)
        elif choice == "e":
            employee = get_input(choice)
            print()
            display(employee)
        else:
            print("Invalid choice. Try again.")
            continue
          
        again = input("Continue? (y/n): ").lower()
        print()
        if again != "y":
            break

    print("Bye!")

def get_input(choice):
    print("DATA ENTRY")
    first_name = input("First name: ")
    last_name = input("Last name: ")
    email = input("Email: ")
    if choice == "c":
        number = input("Number: ")
        customer = Customer(first_name, last_name, email, number)
        return customer
    elif choice == "e":
        ssn = input("SSN: ")
        employee = Employee(first_name, last_name, email, ssn)
        return employee        

def display(person):
    if isinstance(person, Customer):
        print("CUSTOMER")
    elif isinstance(person, Employee):
        print("EMPLOYEE")
    else:
        print("PERSON")
        
    print("First name: " + person.firstName)
    print("Last name:  " + person.lastName)
    print("Email:      " + person.email)
    if isinstance(person, Customer):
        print("Number:     " + person.number)
    elif isinstance(person, Employee):
        print("SSN:        " + person.ssn)
    print()


if __name__ == "__main__":
    main()
