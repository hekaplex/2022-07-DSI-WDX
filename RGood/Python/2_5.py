
print("Travel Time Calculator\n")
miles = input("Enter miles: ")
mph = input("Enter miles per hour: ")

hours = int(miles) // int(mph)
remainder = int(miles) % int(mph)
minutes = float(remainder)/int(mph) * int(60)
print("Estimated travel time\n")
print("\nHours:\t\t", hours)
print("Minutes:\t", int(minutes))
