#!/usr/bin/env python3

class Customer:
    #constructor - new Class
    #An instance of a class with data/code execution is an object
    #a function of an object is a method
    #data types you set/get are called properties (attributes/members)
    # the properties of Customer are set once
    def __init__(self, cust_id, 
                 first_name, last_name,
                 company_name, address,
                 city, state, zip):
        self.id = cust_id
        self.firstName = first_name
        self.lastName = last_name
        self.company = company_name
        self.address = address 
        self.city = city
        self.state = state
        self.zip = zip

    def getFullName(self):
        fullName = self.firstName + " " + self.lastName
        return fullName
    
    def getFullAddress(self):
        a = self.getFullName() + "\n"
        if self.company != "":
            a += self.company + "\n"
        a += self.address + "\n"
        a += self.city + ", " + self.state + " " + self.zip
        return a
    
import csv

FILENAME = "C:\\2022_01_DSI_WD\\drew.minkin@divergence.one\\py\\Day 3\\customers.csv"

def get_customers():
    with open(FILENAME, "r", newline='') as file:
        reader = csv.reader(file)

        # create a list to store all Customer objects
        customers = []

        # read each row of the data
        for row in reader:
            if row[0].lower() == "cust_id": # skip first line
                continue

            # create a list of Customer objects
            customer = Customer(row[0].strip(),
                                row[1].strip(),
                                row[2].strip(),
                                row[3].strip(),
                                row[4].strip(),
                                row[5].strip(),
                                row[6].strip(),
                                row[7].strip())
        #an iterable mutable list of objects is a collection
            customers.append(customer)
        return customers

def find_customer_by_id(customers, cust_id):
    for customer in customers:
        if customer.id == cust_id:
            return customer
    return None

def main():
    print("Customer Viewer")
    print()

    customers = get_customers()
    while True:
        cust_id = input("Enter customer ID: ").strip()
        print()

        customer = find_customer_by_id(customers, cust_id)
        if customer == None:
            print("No customer with that ID.")
            print()
        else:
            print(customer.getFullAddress())
            print()
        
        again = input("Continue? (y/n): ").lower()
        print()
        if again != "y":
            break

    print("Bye!")

if __name__ == "__main__":
    main()
