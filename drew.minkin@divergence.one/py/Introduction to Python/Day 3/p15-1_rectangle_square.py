#!/usr/bin/env python3

class Rectangle:
    def __init__(self, height, width):
        self.height = height
        self.width = width

    def getPerimeter(self):
        perimeter = self.height * 2 + self.width * 2
        return perimeter

    def getArea(self):
        area = self.height * self.width
        return area
        
    def __str__(self):
        s = ""
        w = "* " * self.width + "\n"
        s += w
        for i in range(self.height-2):
            s += "* "
            s += "  " * (self.width-2)
            s += "* \n"
        s += w
        return s
    
class Square(Rectangle):
    def __init__(self, length):
        Rectangle.__init__(self, length, length)
    
def main():
    print("Rectangle Calculator")
    print()

    while True:
        shape = input("Rectangle or square? (r/s): ")
        if shape == "r":
            height = int(input("Height:    "))
            width =  int(input("Width:     "))
            rectangle = Rectangle(height, width)
            display(rectangle)
        elif shape == "s":
            length = int(input("Length:    "))
            square = Square(length)
            display(square)
        else:
            print("Invalid entry. Try again.")
            continue

        again = input("Continue? (y/n): ").lower()
        print()
        if again != "y":
            break

    print("Bye!")

def display(rectangle):
    print("Perimeter:", rectangle.getPerimeter())
    print("Area:     ", rectangle.getArea())
    print(rectangle)

if __name__ == "__main__":
    main()
