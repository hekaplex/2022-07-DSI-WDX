#list always in []
#sep by "," like: [x,d,z])

#arrays hold one typelist hold multiple
#list positions[0,1,2,3...]
temp = [10,20,'me',2.35]
print (temp[3])
#append(item) <at end>
#insert(index, item)
#remove(item)
#index(item)
#pop([index]) lifo: last place list, first out
#len(temp)



##############################################
#SHRI:
# inventory = ["staff", "hat", "bread", "potion"]
# item = "bread"
# if "bread" in inventory:
#     inventory.remove(item)    # ["staff", "hat", "potion"]
inventory = ["staff", "hat", "shoes"]
# # For loop
# for i in inventory:
#     print(i)
# # For loop with control variable and range function
# for i in range(len(inventory)):
#     item = inventory[i]
#     print(f"{i + 1}. {item}")
# # While loop
# scores = [70, 80, 90, 100]
# total = 0
# i = 0
# while i < len(scores):
#     total += scores[i]
#     i += 1
# print(total)      
for i, item in enumerate(inventory, start=1):
    print(f"{i}. {item}")
# Without Enumerate
# For loop with control variable and range function
print("\n\nWithout Enumerate")
for i in range(len(inventory)): 
    item = inventory[i]
    print(f"{i + 1}. {item}")