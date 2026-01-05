USE exersicedata ;


SELECT * FROM auteur;
SELECT titre FROM livre;

SELECT titre, date_pub
FROM livre
WHERE date_pub >= '1862-01-01';

SELECT titre, date_pub
FROM livre
ORDER BY date_pub DESC;


SELECT titre
FROM livre
ORDER BY date_pub DESC
LIMIT 5;
