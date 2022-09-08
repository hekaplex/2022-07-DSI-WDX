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