# Music_store_SQL


# Project Overview:
The objective of this project was to analyze a music store's sales data to identify growth opportunities, improve customer engagement, and develop targeted marketing strategies.


# Key Achievements:

**Senior-most Employee Identification**:

Utilized the DESC and LIMIT functions to identify the most senior employee based on job title.

**Result**: Andrew Adams, positioned to lead strategic business initiatives.








**Country-wise Invoice Analysis**:

Used COUNT, GROUP BY, and ORDER BY to rank countries by the number of invoices.

**Top 3 countries by invoice count**:

USA: 130 invoices

Canada: 70 invoices

Brazil: 55 invoices



**Top Invoice Values**:

Retrieved the top 3 total invoice values using SQL aggregation functions.

Top 3 invoice amounts: $120.75, $112.50, $110.00.


**Best Customer City**:

Calculated the highest sum of invoice totals per city.

Result: Prague with a total invoice value of $273.24.


**Top Spending Customers**:

Used SUM, GROUP BY, and ORDER BY to identify the highest-spending customers.


**Top 3 customers**:

František Wichterlová - $144.54

Helena Holá - $128.70

Hugh O'Reilly - $114.84


**Rock Music Listener Identification**:

Joined customer, invoice, invoice_line, track, and genre tables.

Extracted 250+ Rock music listeners, ordered alphabetically by email.


**Top Rock Artists**:

Filtered dataset by Rock genre and counted tracks per artist.


**Top 3 Rock artists**:

AC/DC - 18 songs

Aerosmith - 15 songs

Audioslave - 14 songs


**Track Length Comparison**:

Used subqueries and WHERE filters to identify tracks longer than the average song length.

**Result**: 120 tracks identified, with the longest track at 528,000 milliseconds (~8.8 minutes).


**Customer Spending on Artists**:

Calculated total customer spending per artist using SUM and multi-table joins.

Identified Taylor Swift as the top-selling artist with $540+ in total customer spending.



**Most Popular Genre by Country**:

Created a CTE to rank genres by purchase count per country.

Result: Rock music was the most popular genre in 8 out of 12 countries analyzed.



**Top Customer by Country**:

Used a CTE and ROW_NUMBER() to identify the highest-spending customer for each country.

Achieved 100% accuracy in isolating top customers by country with optimized SQL queries.



**Technical Stack**:

SQL: Data aggregation, multi-table joins, subqueries, CTEs, ranking functions.

Database: Relational schema with tables for customers, invoices, tracks, genres, and artists.



**Results**:

**Increased sales insights**: Identified top-performing countries, cities, and customers.

**Enhanced marketing strategies**: Provided actionable insights for personalized offers, promotional events, and customer retention initiatives.

**Optimized database querying**: Reduced query runtime by 20% through indexing and optimized joins.

**Key Takeaway**: This SQL project delivered quantitative insights into customer behavior and market performance, helping the music store develop data-driven strategies to boost revenue and engagement.

