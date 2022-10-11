
big = input("Enter cost for 64 oz size: ")
regular = input("Enter cost for 32 oz size: ")
print("Price Comprison\n")

ppo_big = float(big) / int(64)
ppo_regular = float(regular) / int(32)

print("Price per oz (64 oz):\t\t", round(ppo_big,2))
print("Price per oz (32 oz):\t\t", round(ppo_regular,2))
