select *
from titles;
# Challenge 1
#Step 1
select t.title, ta.title_id, ta.au_id, round(t.advance * ta.royaltyper / 100) advance, round((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100), 4) sales_royalty
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on ta.title_id = s.title_id
order by title_id, au_id;

#Step 2
select title, title_id, au_id, sales_royalty, sum(sales_royalty), advance
from
(select t.title, ta.title_id, ta.au_id, round(t.advance * ta.royaltyper / 100) advance, round((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100), 2) sales_royalty, t.royalty royalty
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on t.title_id = s.title_id
order by title_id, au_id) new_table
group by title_id, au_id;

#Step 3
create temporary table if not exists new_table4
(select title, title_id, au_id, sales_royalty, sum(sales_royalty) sum, advance
from
(select t.title, ta.title_id, ta.au_id, round(t.advance * ta.royaltyper / 100) advance, round((t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100), 2) sales_royalty, t.royalty royalty
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on t.title_id = s.title_id
order by title_id, au_id) new_table
group by title_id, au_id);

select title_id, au_id, title, sum(new_table4.advance + sum) total_each_title
from new_table4
group by au_id
order by total_each_title desc
limit 5;

#Correction 
#Step 3
select au_id, sum(ssr+sales_advance) total_profit
from
(select title_id,au_id,sum(sales_royalty) as ssr, sales_advance
from
(select ta.title_id, ta.au_id, t.price*s.qty*t.royalty*ta.royaltyper/10000 as sales_royalty, t.advance*ta.royaltyper/100 as sales_advance
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on s.title_id=ta.title_id
order by ta.title_id, ta.au_id) new_temporary
group by title_id,au_id) second_temporary
group by au_id
order by total_profit desc;

use publications;

#Challenge 2
create temporary table new_temp(
select ta.title_id, ta.au_id, t.price*s.qty*t.royalty*ta.royaltyper/10000 as sales_royalty, t.advance*ta.royaltyper/100 as sales_advance
from titleauthor ta
inner join titles t on t.title_id=ta.title_id
inner join sales s on s.title_id=ta.title_id
order by ta.title_id, ta.au_id);

create temporary table second_temp
(select title_id,au_id,sum(sales_royalty) as ssr, sales_advance
from new_temp
group by title_id,au_id);
select au_id, sum(ssr+sales_advance) total_profit
from second_temp
group by au_id
order by total_profit desc;

create table most_profiting_authors(
select au_id, sum(ssr+sales_advance) total_profit
from second_temp
group by au_id
order by total_profit desc);

select *
from most_profiting_authors;

