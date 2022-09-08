#!/usr/bin/env python3

import random

class RandomIntList(list):
    def __init__(self, count=10, min=1, max=100):
        for i in range(count):
            number = random.randint(min, max)
            self.append(number)

    def count(self):
        return len(self)

    def total(self):
        total = 0
        for i in self:
            total += i
        return total

    def average(self):
        average = self.total() / self.count()
        return average

    def __str__(self):
        s = ""
        for i in self:
            s += str(i) + ", "
        s = s[:-2]
        return s        

def main():
    print("Random Integer List")
    print()

    count = int(input("How many random integers should the list contain?: "))
    print()
    
    while True:
        int_list = RandomIntList(count)
        #int_list.sort()
        
        print("Random Integers")
        print("===============")
        print("Integers: ", int_list)
        print("Count:    ", int_list.count())
        print("Total:    ", int_list.total())
        print("Average:  ", round(int_list.average(), 3))
        print()

        again = input("Continue? (y/n): ").lower()
        print()
        if again != "y":
            break

    print("Bye!")


if __name__ == "__main__":
    main()
