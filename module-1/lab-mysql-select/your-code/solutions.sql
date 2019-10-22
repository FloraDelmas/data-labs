use publications;

select *
from sales;

select au_id, au_lname, au_lname
from authors;

select *
from publishers;

select *
from titleauthor;

select a.au_id, a.au_lname, a.au_lname
from authors a;


select a.au_id, a.title_id
from titleauthor ta
left join authors a
on ta.au_id=a.au_id;
 
select t.title, t.pub_id
from titles t
left join publishers p
on t.pub_id=p.pub_id;

select authors.au_id, au_lname, au_fname, title, titles.title_id, publishers.pub_id, pub_name
from authors
inner join titleauthor on titleauthor.au_id=authors.au_id
inner join titles on titleauthor.title_id=titles.title_id
inner join publishers on titles.pub_id=publishers.pub_id
group by au_id;

select authors.au_id, authors.au_lname, authors.au_fname, titles.title, publishers.pub_name
from authors
inner join titleauthor on titleauthor.au_id=authors.au_id
inner join titles on titleauthor.title_id=titles.title_id
inner join publishers on titles.pub_id=publishers.pub_id 
order by au_id asc;

select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on ta.title_id=t.title_id
inner join publishers p on t.pub_id=p.pub_id 
order by au_id;



select a.au_id, a.au_lname, a.au_fname, t.title, p.pub_name, count(t.title)
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on ta.title_id=t.title_id
inner join publishers p on t.pub_id=p.pub_id
group by a.au_id, p.pub_id;

##Challenge 3
select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as count
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on ta.title_id=t.title_id
inner join sales s on t.title_id=s.title_id
group by a.au_id
order by count desc
limit 3;

## Challenge 4
select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as count
from authors a
left join titleauthor ta on ta.au_id=a.au_id
left join titles t on ta.title_id=t.title_id
left join sales s on t.title_id=s.title_id
group by a.au_id
order by count desc;

select a.au_id, a.au_lname, a.au_fname, sum(s.qty) as count
from authors a
inner join titleauthor ta on ta.au_id=a.au_id
inner join titles t on ta.title_id=t.title_id
inner join sales s on t.title_id=s.title_id
group by a.au_id
order by count desc;