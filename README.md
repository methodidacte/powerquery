## powerquery
M code for functions or scripts in Excel or Power BI query editor

Create a blank query and copy-paste the code of the function.
Rename the function (as you want, but you could keep the original name like fDistance or fDatediff).

From another request, call the function on each row of a table, giving the right column names as parameters. 

# distance
Distance between two points described by their latitude and longitude.


# API vision
You will need an Azure subscription and a cognitive services ressource. Change the description parameter to use the API differently.


# Datediff
Same fonctionnalities as the Excel function (better than DAX function). The output is a number of years, monthes (between 1 and 11) and days (between 1 and 31).


# Calendar
Simple calendar table between january, 1st and december, 31th, corresponding to the years given as parameters. If you omit last year parameter, current year becomes the last year.
