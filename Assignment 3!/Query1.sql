--What are the last names and emails of all customer who made purchased in the store?

SELECT DISTINCT 
    c.LastName,
    c.Email
FROM customers c
JOIN invoices i 
ON c.CustomerId = i.CustomerId
ORDER BY c.LastName;