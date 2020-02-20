/*[Thực hành] Truy vấn dữ liệu nâng cao
*/
select productCode, productName, buyprice, quantityInStock
from products
where buyprice > 56.76 and quantityInStock > 10;

select productCode,productName, buyprice, textDescription
from products
inner join productlines
on products.productline = productlines.productline
where buyprice > 56.76 and buyprice < 95.59;

select productCode, productName, buyprice
, quantityInStock, productVendor, productLine 
from products 
where productLine = 'Classic Cars' or productVendor = 'Min Lin Diecast';

/*[Thực hành] Truy vấn dữ liệu từ nhiều bảng
*/
select customers.customerNumber, customerName, phone
, paymentDate, amount from customers
inner join payments
on customers.customerNumber = payments.customerNumber
where city = 'Las Vegas';

select customers.customerNumber, customers.customerName
, orders.orderNumber, orders.status
from customers
left join orders
on customers.customerNumber = orders.customerNumber ;

select customers.customerNumber, customers.customerName
, orders.orderNumber, orders.status
from customers LEFT JOIN orders
on customers.customerNumber = orders.customerNumber
where orderNumber is null;


/*[Thực hành] Câu lệnh GROUP BY
*/

select status from orders 
group by status;


select status, COUNT(*) as 'So luong status'
from orders
group by status;

select status, sum(quantityOrdered * priceEach) as amount
from orders 
inner join orderdetails on orders.ordernumber = orderdetails.ordernumber
group by status;

select year(orderDate) as year, sum(quantityOrdered * priceEach) as total
from orders 
inner join orderdetails on orders.orderNumber = orderdetails.orderNumber
where status = 'shipped'
group by year
having year > 2003;