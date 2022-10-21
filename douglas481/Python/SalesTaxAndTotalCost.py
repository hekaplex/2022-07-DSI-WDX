#module for calculating sales tax and total after tax
salesRate=6 #sales tax percentage
#sales tax and total cost function
def salesTax(cost):
    tax=round(cost*(salesRate/100),2)
    totalCost=round(cost+tax,2)
    return (tax,totalCost)