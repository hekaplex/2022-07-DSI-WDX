Python 3.9.5 (tags/v3.9.5:0a7dcbd, May  3 2021, 17:27:52) [MSC v.1928 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> 
===== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\future_value.py ====
Welcome to the Future Value Calculator

Configure Monthly Investment:	100
Configure Monthly Rate:	5
Configure Years of investment:	3.6
Traceback (most recent call last):
  File "C:\2021_02_CCT_WE\drew.minkin@divergence.one\future_value.py", line 34, in <module>
    final_value = str(calculateFutureValue(monthlyInvestment, monthlyRate, ytm(ham)))
  File "C:\2021_02_CCT_WE\drew.minkin@divergence.one\future_value.py", line 7, in calculateFutureValue
    for i in range(months):
TypeError: 'float' object cannot be interpreted as an integer
>>> 
===== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\future_value.py ====
Welcome to the Future Value Calculator

Configure Monthly Investment:	100
Configure Monthly Rate:	5
Configure Years of investment:	3.6
final value: $15014.3
>>> foo = str()
>>> foo
''
>>> foo = 'bar'
>>> foo
'bar'
>>> print(foo)
bar
>>> 12var = str()
SyntaxError: invalid syntax
>>> v12ar = str()
>>> !ter = str()
SyntaxError: invalid syntax
>>> print?
SyntaxError: invalid syntax
>>> ?print
SyntaxError: invalid syntax
>>> 8 / 5
1.6
>>> 8 //5
1
>>> 10 % 7
3
>>> 5 % 2
1
>>> 5 ** 2
25
>>> 2 ** 5
32
>>> 'f' * 5
'fffff'
>>> 'f' ** 5
Traceback (most recent call last):
  File "<pyshell#17>", line 1, in <module>
    'f' ** 5
TypeError: unsupported operand type(s) for ** or pow(): 'str' and 'int'
>>> 'f' ** 'r'
Traceback (most recent call last):
  File "<pyshell#18>", line 1, in <module>
    'f' ** 'r'
TypeError: unsupported operand type(s) for ** or pow(): 'str' and 'str'
>>> 4.3 ** 2.7
51.32923953713035
>>> subtotal = 74.95
>>> tax = subtotal *= .1
SyntaxError: invalid syntax
>>> tax = subtotal * .1
>>> tax
7.495000000000001
>>> type(subtotal)
<class 'float'>
>>> type(tax)
<class 'float'>
>>> round(tax,2)
7.5
>>> round(tax,4)
7.495
>>> name = "Bob"
>>> age = 40
>>> msg = name + " is" +age + "years old"
Traceback (most recent call last):
  File "<pyshell#30>", line 1, in <module>
    msg = name + " is" +age + "years old"
TypeError: can only concatenate str (not "int") to str
>>> msg
Traceback (most recent call last):
  File "<pyshell#31>", line 1, in <module>
    msg
NameError: name 'msg' is not defined
>>> msg = name + " is" +str(age) + "years old"
>>> msg
'Bob is40years old'
>>> msg = name + " is " +str(age) + " years old"
>>> msg
'Bob is 40 years old'
>>> msg2 = name + "\n" +str(age)+"\t \"years old\'\\"
>>> msg2
'Bob\n40\t "years old\'\\'
>>> print(msg2)
Bob
40	 "years old'\
>>> print("type 'x' ")
type 'x' 
>>> print('type "x" ')
type "x" 
>>> print(msg1,msg2)
Traceback (most recent call last):
  File "<pyshell#41>", line 1, in <module>
    print(msg1,msg2)
NameError: name 'msg1' is not defined
>>> print(msg,msg2)
Bob is 40 years old Bob
40	 "years old'\
>>> print(subtotal,tax)
74.95 7.495000000000001
>>> print(str(subtotal) +" " + str(tax))
74.95 7.495000000000001
>>> 
==== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\average_score.py ====
Enter test score: 56
Enter test score: 21
Enter test score: 34
Enter test score: 999
use numbers between 0 and 100
Total Score: 111
Average Score: 37
Number of Scores: 3
>>> 
===== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\mileage_calc.py ====
The Miles Per Gallon program

Enter miles driven:		
Traceback (most recent call last):
  File "C:\2021_02_CCT_WE\drew.minkin@divergence.one\mileage_calc.py", line 8, in <module>
    miles_driven= float(input("Enter miles driven:\t\t"))
ValueError: could not convert string to float: ''
>>> 
===== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\mileage_calc.py ====
The Miles Per Gallon program

Enter miles driven:		1500
Enter gallons of gas used:	38

Miles Per Gallon:		39.47

Bye
>>> age
Traceback (most recent call last):
  File "<pyshell#45>", line 1, in <module>
    age
NameError: name 'age' is not defined
>>> age = 40
>>> age
40
>>> age == 40
True
>>> age == 34
False
>>> age >= 35
True
>>> age < 35
False
>>> min_age = 47
>>> age != min_age
True
>>> age >= min_age
False
>>> active = True
>>> type(active)
<class 'bool'>
>>> !active
SyntaxError: invalid syntax
>>> ~active
-2
>>> Not(active)
Traceback (most recent call last):
  File "<pyshell#59>", line 1, in <module>
    Not(active)
NameError: name 'Not' is not defined
>>> active = False
>>> active
False
>>> min_age == 47 AND age == 40
SyntaxError: invalid syntax
>>> (min_age == 47) AND (age == 40)
SyntaxError: invalid syntax
>>> (min_age == 47) && (age == 40)
SyntaxError: invalid syntax
>>> (min_age == 47)
True
>>> True AND True
SyntaxError: invalid syntax
>>> (min_age == 47) and (age == 40)
True
>>> (min_age == 47) not (age == 40)
SyntaxError: invalid syntax
>>> not(active)
True
>>> (min_age == 47) and not(age == 40)
False
>>> (min_age == 47) and not(age == 47)
True
>>> (min_age == 47) and not(age == 47) or (age != min_age)
True
>>> ((min_age == 47) and not(age == 47)) or (age != min_age)
True
>>> ((min_age == 47) and not(age == 47)) or (age != min_age)
True
>>> msg
Traceback (most recent call last):
  File "<pyshell#75>", line 1, in <module>
    msg
NameError: name 'msg' is not defined
>>> 
==== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\countdown_app.py ====
please add a counter: 47
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 Congrats!!!!!

The loop has ended.
>>> 
==== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\countdown_app.py ====
please add a counter: A
Traceback (most recent call last):
  File "C:\2021_02_CCT_WE\drew.minkin@divergence.one\countdown_app.py", line 3, in <module>
    limit_count = int(
ValueError: invalid literal for int() with base 10: 'A'
>>> 
==== RESTART: C:\2021_02_CCT_WE\drew.minkin@divergence.one\countdown_app.py ====
please add a counter: 3.6
Traceback (most recent call last):
  File "C:\2021_02_CCT_WE\drew.minkin@divergence.one\countdown_app.py", line 3, in <module>
    limit_count = int(
ValueError: invalid literal for int() with base 10: '3.6'
>>> vart = range(4,9)
>>> print(vart)
range(4, 9)
>>> for i in vart: print i
SyntaxError: Missing parentheses in call to 'print'. Did you mean print(i)?
>>> for i in vart: print (i)

4
5
6
7
8
>>> vart = rane(0,100,7)
Traceback (most recent call last):
  File "<pyshell#81>", line 1, in <module>
    vart = rane(0,100,7)
NameError: name 'rane' is not defined
>>> vart = range(0,100,7)
>>> for i in vart: print (i)

0
7
14
21
28
35
42
49
56
63
70
77
84
91
98
>>> vart = range(100,0,-7)
>>> for i in vart: print (i)

100
93
86
79
72
65
58
51
44
37
30
23
16
9
2
>>> for i in vart: print (i)

100
93
86
79
72
65
58
51
44
37
30
23
16
9
2
>>> for i in vart: print (i)

100
93
86
79
72
65
58
51
44
37
30
23
16
9
2
>>> vart = range(0,100,7)