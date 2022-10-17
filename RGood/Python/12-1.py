"""
 The program should use a dictionary of dictionaries to store the stats (wins, losses, 
and ties) for each player. You can code this dictionary of dictionaries at the beginning 
of the program using any names and statistics that you want. Make sure to provide stats for at least three players. 
The program should begin by displaying an alphabetical list of the names of the players. 
The program should allow the user to view the stats for the specified player. 
"""



from unicodedata import name


def gameName ():
    print("Welcome to Stat-astic Tables")


players = {"Carl":{"wins": 10,"losses": 2, "Ties": 5},
"Ashley":{"wins": 5,"losses": 12, "Ties": 3},
"Richard":{"wins": 2,"losses": 10, "Ties": 9}
}



def main():
    gameName()
    again = 'y'
    while again.lower() == 'y':
        id = list(players.keys)
        players.keys.sort()
        for id in players:
            print(id)
        name = input("Enther the players name you would like stats about:  ")
        if name in players:
            print ()
        else:
            print("the name is not in the list\n")
    again = input('Continue? (y,n):  ')
                    

    



if __name__ == "__main__":
    main()