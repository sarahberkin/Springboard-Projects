/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */
Answer:
SELECT name
FROM Facilities
WHERE membercost = 0


/* Q2: How many facilities do not charge a fee to members? */
Answer:
4- Bidminton Court, Table Tennis, Snooker Table, Pool Table


/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
Answer:
SELECT name, facid, membercost, monthlymaintenance
FROM Facilities
WHERE membercost > 0
    AND membercost < monthlymaintenance * .2

name              facid    membercost    monthlymaintenace
Tennis Court 1    0        5.0           200
Tennis Court 2    1        5.0           200
Massage Room 1    4        9.9           3000
Massage Room 2    5        9.9           3000
Squash Court      6        3.5           80


/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */
Answer:
SELECT *
FROM Facilities
WHERE facid IN (1,5)

facid  name            membercost  guestcost  initialoutlay  monthlymaintenance  expense_label
1      Tennis Court 2  5.0         25         8000           200                 expensive
5      Massage Room 2  9.9         80         4000           3000                expensive


/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */
Answer:
SELECT name, monthlymaintenance
FROM Facilities
WHERE expense_label = 'expensive'

name            monthly maintenance
Tennis Court 1  200
Tennis Court 2  200
Massage Room 1  3000
Massage Room 2  3000


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */
Answer:
SELECT firstname, surname, MAX(joindate) AS "most_recent_signup"
FROM Members
GROUP BY firstname, surname
ORDER BY most_recent_signup DESC

firstname  surname  most_recent_signup 
Darren     Smith    2012-09-26 18:08:45


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */
Answer:
SELECT DISTINCT name AS tennis_court, CONCAT(firstname, " ", surname) AS member_name
FROM Bookings
INNER JOIN Members
USING (memid)
INNER JOIN Facilities
ON Facilities.name = Bookings.facid
WHERE Facilities.name = 'Tennis Court 1'
    AND firstname != 'GUEST'
ORDER BY memid


/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */
Answer:
SELECT Facilities.name AS facility_name, CONCAT(firstname, " ", surname) AS member_name, Facilities.guestcost AS guest_cost, Facilities.membercost AS member_cost
FROM Facilities
LEFT JOIN Bookings
ON Bookings.facid = Facilities.facid
LEFT JOIN Members
ON Bookings.memid = Members.memid
WHERE Facilities.guestcost > 30
    AND starttime LIKE "%2012-09-14%
ORDER BY Facilities.guestcost DESC


/* Q9: This time, produce the same result as in Q8, but using a subquery. */
Answer:
SELECT Facilities.name AS facility_name, CONCAT(firstname, " ", surname) AS member_name, Facilities.guestcost AS guest_cost, Facilities.membercost AS member_cost
FROM Facilities
LEFT JOIN Bookings
ON Bookings.facid = Facilities.facid
LEFT JOIN Members
ON Bookings.memid = Members.memid
WHERE firstname IN
    (SELECT firstname
     FROM Members
     WHERE Facilities.guestcost > 30)
    AND (starttime LIKE "%2012-09-14%"
ORDER BY Facilities.guestcost DESC


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
Answer:


/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */
Answer:


/* Q12: Find the facilities with their usage by member, but not guests */
Answer:


/* Q13: Find the facilities usage by month, but not guests */
Answer:

