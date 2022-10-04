print("Travel Time Calculator")
print("\n")
miles = int(input ("Enter miles: "))
mph = int(input ("Enter miles per hour: "))
hours=miles//mph
minutes=miles%mph
print("\n")
print("Estimate travel time")
print(f"Hours: {hours}")
print(f"Minutes: {minutes}")