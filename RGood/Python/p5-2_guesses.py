#!/usr/bin/env python3

import random

def display_title():
    print("Guess the number!")
    print()

def get_limit():
    limit = int(input("Enter the upper limit for the range of numbers: "))
    return limit

def play_game(limit):
    number = random.randint(1, limit)
    print(f"I'm thinking of a number from 1 to {limit}\n")

    count = 1
    while True:
        guess = int(input("Your guess: "))
        if guess < number:
            print("Too low.")
            count += 1
        elif guess > number:
            print("Too high.")
            count += 1
        elif guess == number:
            print(f"You guessed it in {count} tries.\n")
            return

def main():
    display_title()
    
    again = "y"
    while again.lower() == "y":
        limit = get_limit()
        play_game(limit)
        
        again = input("Play again? (y/n): ")
        print()
    print("Bye!")

# if started as the main module, call the main function
if __name__ == "__main__":
    main()

