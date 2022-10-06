#make module for two conversions
#meter to feet conversion function
def m2f(meters):
    feet=round(meters/0.3048,2)
    return feet
#feet to meter conversion function
def f2m(feet):
    meters=round(feet*0.3048,2)
    return meters