use publications;

select t.title, sum(qty), group_concat(distinct stor_id), price
from sales s
inner join titles t on t.title_id = s.title_id
group by t.title;

SELECT 
    t.title,
    SUM(qty) number_of_books,
    COUNT(DISTINCT stor_id) num_of_shops,
    price,
    GROUP_CONCAT(DISTINCT stor_id) stor_ids
FROM
    sales s
        INNER JOIN
    titles t ON t.title_id = s.title_id
GROUP BY t.title;


SELECT 
    title,
    ROUND(num_of_books * price / num_of_shops, 2) AS avg_revenue_per_shop,
    stor_ids
FROM
    (SELECT 
        t.title,
            SUM(qty) num_of_books,
            COUNT(DISTINCT stor_id) num_of_shops,
            price,
            GROUP_CONCAT(DISTINCT stor_id) stor_ids
    FROM
        sales s
    INNER JOIN titles t ON t.title_id = s.title_id
    GROUP BY t.title) new_table;
    
    select t.title, t.price, st.stor_namen t.type
    from titles t
    inner join sales s on s.title_id = t.title_id
    inner join stores st on st.stor_id = s.stor_id
    where t.type='business';
    
    select title, price, stor_name, a.city, a.zip, a.state, a.au_lname, new_table.city, new_table.zip
    from
    (select t.title_id, t.title, t.price, st.stor_name, st.city, st.zip, st.state
    from titles t
    inner join sales s on s.title_id = t.title_id
    inner join stores st on st.stor_id = s.stor_id
    where t.type='business') new_table
    inner join titleauthor ta on ta.title_id = new_table.title_id
    inner join authors a on a.au_id = ta.au_id
    where new_table.zip = a.zip or new_table.city=a.city or new_table.state = a.state;
    
    create temporary table if not exists store_title_adress(
    select t.title_id, t.title, t.price, st.stor_name, st.city, st.zip, st.state
    from titles t
    inner join sales s on s.title_id = t.title_id
    inner join stores st on st.stor_id = s.stor_id
    where t.type='business');
    
    select *  from store_title_adress;
    
    
    
    
    