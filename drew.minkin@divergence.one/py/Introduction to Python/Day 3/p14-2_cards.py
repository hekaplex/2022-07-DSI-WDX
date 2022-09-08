#!/usr/bin/env python3

import random

class Card:
    def __init__(self, rank, suit, dignified):
        self.rank = rank
        self.suit = suit
        if dignified >= 10:
            self.dignified = ""
        else:
            self.dignified = "*"
    def getStr(self):
        return self.rank + " of " + self.suit + self.dignified

class Deck:
    def __init__(self):
        self.__deck = []
        ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10",
                 "Knight", "King", "Queen", "Ace"]
        suits = ["Wands", "Pentacles", "Cups", "Swords"]
        for rank in ranks:
            for suit in suits:
                self.__deck.append(Card(rank, suit,random.randint(1,100)))

    def shuffle(self):
        random.shuffle(self.__deck)

    def dealCard(self):
        return self.__deck.pop()

    def count(self):
        return len(self.__deck)
    
def main():
    print("Tarot Card Dealer")
    print()

    deck = Deck()
    deck.shuffle()
    print("I have shuffled a deck of", str(deck.count()), "cards.")
    print()

    count = int(input("How many cards would you like?: "))
    print()

    print("Here are your cards:")
    cards = []
    for i in range(count):        
        card = deck.dealCard()
        print(card.getStr())
        cards.append(card)
    print()

    print("There are", str(deck.count()), "cards left in the deck.")
    print()
    
    print("Good luck!")

if __name__ == "__main__":
    main()
