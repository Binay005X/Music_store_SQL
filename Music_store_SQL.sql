/*	Question Set 1 -*/

/* Q1: Who is the senior most employee based on job title? */

select * 
from employee
order by levels desc
limit 1;

/* Q2: Which countries have the most Invoices? */

select count(*) as c, billing_country
from invoice
group by billing_country
order by c desc;

/* Q3: What are top 3 values of total invoice? */

select round(total , 2) as total
from invoice
order by total desc
limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select round(sum(total), 2) as "invoice_total", billing_city
from invoice
group by billing_city
order by invoice_total desc;

/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */


select distinct email, 
concat(first_name, ' ', last_name) as "customres"
from customer
join invoice 
on customer.customer_id = invoice.customer_id
join invoice_line
on invoice.invoice_id = invoice_line.invoice_id
where track_id in (
	select track_id from track
    join genre on track.genre_id = genre.genre_id
    where genre.name like "Rock")
    
order by email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */


select artist.name, count(track.track_id) as number_of_songs
from track
join album2 on album2.album_id = track.album_id
join artist on artist.artist_id = album2.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like "Rock"
group by artist.name
order by number_of_songs desc;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */


with best_selling_artist as 
	(select artist.artist_id as artist_id, 
	artist.name as artist_name,
	round(sum(invoice_line.unit_price*invoice_line.quantity), 2) as total_sales
	from invoice_line
	join track on track.album_id = invoice_line.track_id
	join album2 on album2.album_id = track.album_id
	join artist on artist.artist_id = album2.artist_id
	group by artist.artist_id, artist.name
	order by total_sales desc
	limit 1)
    
select customer.customer_id,
concat(customer.first_name, ' ', customer.last_name) as "customers",
best_selling_artist.artist_name,
round(sum(invoice_line.unit_price*invoice_line.quantity), 2) as amount_spent
from invoice 
join customer on customer.customer_id = customer.customer_id
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
join track on track.track_id = invoice_line.track_id
join album2 on album2.album_id = track.album_id
join best_selling_artist on best_selling_artist.artist_id = album2.album_id
group by customer.customer_id, customers, best_selling_artist.artist_name
order by amount_spent desc;

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

/* Method 1: Using CTE */


with popular_genre as
(
select count(invoice_line.quantity) as "purchases", customer.country, genre.name, genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as "Row_No"
from invoice_line 
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id 
group by customer.country, genre.name, genre.genre_id
order by customer.country asc, purchases desc 
)

select * from popular_genre where Row_no <= 1;


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

/* Method 1: using CTE */

with customer_with_country as (
    select customer.customer_id, 
	concat(first_name, ' ', last_name) as "customers",
	billing_country,
	round(sum(total), 2) as total_spending,
    row_number() over(partition by billing_country order by sum(total) desc) as "Row_no"
	from invoice
	join customer on customer.customer_id = invoice.customer_id
	group by customer.customer_id, first_name, last_name, billing_country
	order by billing_country asc, total_spending desc)
     
select * from customer_with_country where Row_no <= 1;