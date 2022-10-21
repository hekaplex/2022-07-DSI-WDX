
def feetMeter(num: float) ->int:
    meter = round(num * 0.3048,2)
    print (f"{meter} meters")
    print()
    return meter 
    
def meterFeet(num: float) ->int:
    feet = round(num / 0.3048,2)
    print (f"{feet} feet")
    print()
    return feet 