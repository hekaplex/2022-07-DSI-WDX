#!/usr/bin/env python3

import random

from objects import Card, Deck, Hand

def main():
    print("Blackjack")
    print()

    while True:
        deck = Deck()
        deck.shuffle()

        dealer_hand = Hand()
        player_hand = Hand()

        # deal two cards to player and one to the dealer
        player_hand.addCard(deck.dealCard())
        player_hand.addCard(deck.dealCard())
        dealer_hand.addCard(deck.dealCard())

        # display cards
        display_cards(dealer_hand, "DEALER'S SHOW CARD: ")
        display_cards(player_hand, "YOUR CARDS: ")
        
        # get player hand
        player_hand = play(deck, player_hand)
        
        # get dealer hand
        while dealer_hand.points() < 17:        
            dealer_hand.addCard(deck.dealCard())
        display_cards(dealer_hand, "DEALER'S CARDS: ")

        print("YOUR POINTS:     " + str(player_hand.points()))    
        print("DEALER'S POINTS: " + str(dealer_hand.points()))
        print()

        if player_hand.points() > 21:    
            print("Sorry. You busted. You lose.")
        elif dealer_hand.points() > 21:
            print("Yay! The dealer busted. You win!")
        else:        
            if player_hand.points() == 21 and player_hand.count() == 2:
                if dealer_hand.points() == 21 and dealer_hand.count() == 2:
                    print("Dang, dealer has blackjack too. You push.")
                else:
                    print("Blackjack! You win!")
            elif player_hand.points() > dealer_hand.points():    
                print("Hooray! You win!")
            elif player_hand.points() == dealer_hand.points():    
                print("You push.")
            elif player_hand.points() < dealer_hand.points():    
                print("Sorry. You lose.")
            else:
                print("I am not sure what happened.")
        print()

        again = input("Play again? (y/n): ").lower()
        print()
        if again != "y":
            print("Come back soon!")
            break

def play(deck, player_hand):
    while True:
        choice = input("Hit or stand? (hit/stand): ")
        print()

        if choice == "hit":
            player_hand.addCard(deck.dealCard())
            display_cards(player_hand, "YOUR CARDS: ")
            if player_hand.points() > 21:
                break
        elif choice == "stand":
            break
        else:
            print("Not a valid choice. Try again.")
    return player_hand

def display_cards(hand, title):
    print(title.upper())
    for card in hand:
        print(card)
    print()


if __name__ == "__main__":
    main()
