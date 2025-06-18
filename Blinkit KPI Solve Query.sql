

SELECT Outlet_Establishment_Year, ROUND(SUM(Total_Sales), 2) AS Total_Sales, Outlet_Size AS Outlet_size
FROM   blinkit_data
GROUP BY Outlet_Establishment_Year, Outlet_Size
ORDER BY Total_Sales

update blinkit_data
SET Item_Fat_Content =
case 
when Item_Fat_Content in ('LF','low fat') then 'Low Fat'
when Item_Fat_Content in ('reg') then 'Regular'
else Item_Fat_Content
end 


select * from blinkit_data;

select distinct(Item_Fat_Content) as Item_Fat_Content from blinkit_data;

-- The overall revenue generated from all items sold

select cast(SUM(Total_Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions from blinkit_data;


-- The average revenue per sale

select cast(avg(Total_Sales) as int) as Avg_Sales from blinkit_data;

-- The total count of different items sold

select COUNT(*) AS No_of_items from blinkit_data where Item_Fat_Content = 'Low Fat';

select cast(SUM(Total_Sales)/1000000 as decimal(10,2)) as Total_Sales_Low_Fat_mn from blinkit_data
where Item_Fat_Content = 'Low Fat';

--The average customer rating for items sold. 

select cast(avg(Rating) as decimal(10,2)) as Avg_RATING from blinkit_data;

-- Total Sales by Fat Content

SELECT Item_Fat_Content,
round(SUM(Total_Sales),2) as Total_Sales, 
round(avg(Total_Sales),2) as Avg_Sales,
count(*) as No_of_counts,
round(avg(Rating),2) as Avg_Rating
from blinkit_data
group by Item_Fat_Content
order by Total_Sales desc;

-- Total Sales by Item Type

SELECT Item_Type,
round(SUM(Total_Sales),2) as Total_Sales, 
round(avg(Total_Sales),2) as Avg_Sales,
count(*) as No_of_counts,
round(avg(Rating),2) as Avg_Rating
from blinkit_data
group by Item_Type
order by Total_Sales desc;


-- Fat Content by Outlet for Total Sales

SELECT Outlet_Location_Type,Item_Fat_Content,
round(SUM(Total_Sales),2) as Total_Sales, 
round(avg(Total_Sales),2) as Avg_Sales,
count(*) as No_of_counts,
round(avg(Rating),2) as Avg_Rating
from blinkit_data
group by Outlet_Location_Type,Item_Fat_Content
order by Total_Sales asc;

--  Total Sales by Outlet Establishment:


SELECT Outlet_Establishment_Year,
round(SUM(Total_Sales),2) as Total_Sales, 
round(avg(Total_Sales),2) as Avg_Sales,
count(*) as No_of_counts,
round(avg(Rating),2) as Avg_Rating
from blinkit_data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year asc;


-- Select Outlet_Location_Type-wise sales summary with fat content breakdown

SELECT 
    Outlet_Location_Type,  -- Location type of the outlet
    SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular,
    SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS Low_Fat,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales  
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales ASC;


-- Percentage of Sales by Outlet Size

SELECT 
	Outlet_Size,
	ROUND(sum(Total_Sales),2) as Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
from
	blinkit_data
	group by Outlet_Size
	order by Total_Sales desc;




SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;
