


FILENAME = 'G:\DSI-Hekaplex-Clone\\2022-07-DSI-WDX\RGood\Python\\rules.txt'
# Takes movies List and writes the list to actual file


def read_rules():
    rules = []
    with open(FILENAME,"r") as file:
        contents = file.read()
#        for line in file:
#            line = line.replace("\n", "")
#            rules.append(line)
        print (contents)
#    return rules

#read_rules()

def read_rule_trial():
    rules = []
    with open(FILENAME,"r") as file:
        rulesList = file.readlines()
        print(rulesList[0])
#    return rules

read_rule_trial()