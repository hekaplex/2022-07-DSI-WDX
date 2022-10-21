'''
This is a ridiculous amount of coding for something that is so much more easily done other ways. There has to be a better way,
 a way to code this so that it will get what you want without having to look at the file contents
 '''
def main():
    print("HTML Converter")
    print()

    # specify filename in the current directory
    filename = "groceries.html"

    html = ""
    with open(filename, "r") as file:
        for line in file:
            html += line.lstrip()

    text = html \
        .replace("<h1>", "") \
        .replace("</h1>", "") \
        .replace("<ul>", "") \
        .replace("</ul>", "") \
        .replace("<li>", "* ") \
        .replace("</li>", "") \
        .replace("\n\n", "\n") \
        .strip() 
    
    print(text)


if __name__ == "__main__":
    main()



