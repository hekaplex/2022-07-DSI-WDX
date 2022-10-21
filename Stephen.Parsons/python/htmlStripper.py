import re
html_string = '''
<body>
  <h1>Grocery List</h1> 
<ul> 
 <li>Eggs</li> 
 <li>Milk</li> 
 <li>Butter</li> 
</ul> 
</body>
'''
stripping_html_string = re.sub('<[^<]+?>', '', html_string)
print(stripping_html_string)
