#!/usr/bin/env python3

import random

ROSHAMBO_LIST = ["rock", "paper", "scissors"]

class Player:
    def __init__(self, name):
        self.name = name
        self.roshambo = ""

    def __str__(self):
        return self.name + ": " + self.roshambo

class Bart(Player):
    def __init__(self):
        Player.__init__(self, "Bart")

    def generateRoshambo(self):
        self.roshambo = ROSHAMBO_LIST[0] # always 'rock'

class Lisa(Player):
    def __init__(self):
        Player.__init__(self, "Lisa")

    def generateRoshambo(self):
        self.roshambo = random.choice(ROSHAMBO_LIST) # random choice
        
def main():
    print("Roshambo Game")
    print()

    name = input("Enter your name: ")
    print()
    
    player1 = Player(name)

    opponent = input("Would you like to play Bart or Lisa? (b/l): ")
    print()

    if opponent.lower() == "b":
        player2 = Bart()
    elif opponent.lower() == "l":
        player2 = Lisa()        

    while True:
        selection = input("Rock, paper, or scissors? (r/p/s): ").lower()
        print()

        # set Roshambo for player 1
        if selection == "r":
            player1.roshambo = "rock"
        elif selection == "p":
            player1.roshambo = "paper"
        elif selection == "s":
            player1.roshambo = "scissors"
        else:
            print("Invalid choice. Try again.")
            continue        

        # generate Roshambo for player 2
        player2.generateRoshambo()

        # display name and roshambo
        print(player1)
        print(player2)

        # display result
        play(player1, player2)
        print()

        again = input("Play again? (y/n): ").lower()
        print()
        if again != "y":
            break

    print("Thanks for playing!")


def play(player1, player2):
    if player1.roshambo == player2.roshambo:
        print("Draw!")
    else:
        if player1.roshambo == "rock" and player2.roshambo == "scissors" \
        or player1.roshambo == "paper" and player2.roshambo == "rock" \
        or player1.roshambo == "scissors" and player2.roshambo == "paper":
            print(player1.name + " wins!")
        else:
            print(player2.name + " wins!")    

if __name__ == "__main__":
    main()
