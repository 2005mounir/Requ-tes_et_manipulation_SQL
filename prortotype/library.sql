CREATE DATABASE library;

USE library;
-- =====================
-- TABLE RAYON
-- =====================
CREATE TABLE rayon (
    rayon_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- =====================
-- TABLE AUTEUR
-- =====================
CREATE TABLE auteur (
    auteur_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL
);

-- =====================
-- TABLE LECTEUR
-- =====================
CREATE TABLE lecteur (
    lecteur_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tel VARCHAR(15) NOT NULL UNIQUE,
    cin VARCHAR(8) NOT NULL UNIQUE
);

-- =====================
-- TABLE OUVRAGE
-- =====================
CREATE TABLE ouvrage (
    ouvrage_id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    annee_publication YEAR NOT NULL,
    rayon_id INT NOT NULL,
    FOREIGN KEY (rayon_id) REFERENCES rayon(rayon_id)
);

-- =====================
-- TABLE ASSOCIATION OUVRAGE / AUTEUR
-- =====================
CREATE TABLE ouvrage_auteur (
    ouvrage_id INT,
    auteur_id INT,
    PRIMARY KEY (ouvrage_id, auteur_id),
    FOREIGN KEY (ouvrage_id) REFERENCES ouvrage(ouvrage_id),
    FOREIGN KEY (auteur_id) REFERENCES auteur(auteur_id)
);

-- =====================
-- TABLE EMPRUNT
-- =====================
CREATE TABLE emprunt (
    emprunt_id INT AUTO_INCREMENT PRIMARY KEY,
    date_emprunt DATE NOT NULL DEFAULT CURRENT_DATE,
    date_retour_prevue DATE NOT NULL,
    date_retour_effective DATE NULL,
    lecteur_id INT NOT NULL,
    ouvrage_id INT NOT NULL,
    FOREIGN KEY (lecteur_id) REFERENCES lecteur(lecteur_id),
    FOREIGN KEY (ouvrage_id) REFERENCES ouvrage(ouvrage_id)
);

-- =====================
-- TABLE PERSONNEL
-- =====================
CREATE TABLE personnel (
    personnel_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    tel VARCHAR(15) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    chef_id INT NULL,
    FOREIGN KEY (chef_id) REFERENCES personnel(personnel_id)
    );


insert INTO rayon ( nom)values
('Mathématiques'),
('Informatique'),
('Philosophie'),
('Histoire'),
('Littérature');

UPDATE rayon set rayon_id = 1 where rayon_id=16;
UPDATE rayon set rayon_id = 2 where rayon_id=17;
UPDATE rayon set rayon_id = 3 where rayon_id=18;
UPDATE rayon set rayon_id = 4 where rayon_id=19;
UPDATE rayon set rayon_id = 5 where rayon_id=20;


INSERT INTO auteur (nom, prenom) VALUES
('Hugo', 'Victor'),
('Camus', 'Albert'),
('Tolkien', 'J.R.R.'),
('Rowling', 'J.K.'),
('Sartre', 'Jean-Paul'),
('Asimov', 'Isaac');


 INSERT INTO lecteur (nom, prenom, email, tel, cin) VALUES
('Benali', 'Ahmed', 'ahmed.benali@email.com', '0612345678', 'A1234567'),
('El Fassi', 'Salma', 'salma.elfassi@email.com', '0612345679', 'B2345678'),
('Moussa', 'Karim', 'karim.moussa@email.com', '0612345680', 'C3456789');


 
INSERT INTO ouvrage (titre, annee_publication, rayon_id) VALUES
('Le Petit Prince', 1943, 2),
('Les Misérables',1949, 2),
('Introduction à l algorithmique', 2010, 1),
('Fondements de la physique', 2005, 4),
('La République', 380, 5);


INSERT INTO ouvrage_auteur (ouvrage_id, auteur_id) VALUES
(1, 1), 
(2, 2),  
(3, 5),  
(4, 3),  
(5, 5); 


INSERT INTO emprunt (date_retour_prevue, date_retour_effective, lecteur_id, ouvrage_id)
VALUES 
('2026-02-20', NULL, 1, 1),  
('2026-02-22', NULL, 2, 3),  
('2026-02-25', NULL, 3, 5);  



INSERT INTO personnel (nom, email, tel, mot_de_passe, chef_id)
VALUES ('Ahmed Benali', 'ahmed.benali@library.com', '0612345678', 'pass123', NULL);

INSERT INTO personnel (nom, email, tel, mot_de_passe, chef_id)
VALUES 
('Salma El Fassi', 'salma.elfassi@library.com', '0612345679', 'pass456', 1),
('Karim Moussa', 'karim.moussa@library.com', '0612345680', 'pass789', 1);

-- select

SELECT * from rayon ; 

SELECT nom , prenom FROM auteur;

SELECT titre , annee_publication  from ouvrage;

SELECT nom , prenom , email from lecteur ;

SELECT titre from ouvrage WHERE annee_publication > 1950;

SELECT nom from lecteur WHERE nom like 'M%';

SELECT titre FROM ouvrage ORDER BY annee_publication ASC ; 

SELECT * FROM emprunt WHERE date_retour_effective = NULL;

SELECT  ouvrage.titre , rayon.nom
from ouvrage
INNER JOIN rayon on ouvrage.rayon_id = rayon.rayon_id; 

SELECT auteur.nom,auteur.prenom , ouvrage.titre
from ouvrage
INNER JOIN ouvrage_auteur on ouvrage.ouvrage_id = ouvrage_auteur.ouvrage_id 
INNER JOIN auteur ON ouvrage_auteur.auteur_id = auteur.auteur_id;



SELECT lecteur.nom, lecteur.prenom
FROM lecteur
INNER JOIN emprunt ON emprunt.lecteur_id = lecteur.lecteur_id
GROUP BY lecteur.lecteur_id, lecteur.nom, lecteur.prenom
HAVING COUNT(emprunt.emprunt_id) >= 1;


SELECT rayon.nom, COUNT(ouvrage.ouvrage_id) AS nombre_ouvrages
FROM rayon
LEFT JOIN ouvrage ON ouvrage.rayon_id = rayon.rayon_id
GROUP BY rayon.rayon_id, rayon.nom;

--update

UPDATE lecteur SET email ='solicode@gmail.come' where lecteur_id = 1;
 
UPDATE lecteur SET tel ='000000000000' WHERE cin = 'B2345678';

UPDATE ouvrage SET rayon_id = 3 WHERE ouvrage_id = 1;


UPDATE emprunt set date_retour_effective = '2027-1-1'  WHERE date_retour_prevue = '2026-02-20';
UPDATE emprunt set date_retour_effective = '2027-2-1'  WHERE date_retour_prevue = '2026-02-22';
UPDATE emprunt set date_retour_effective = '2027-3-1'  WHERE date_retour_prevue = '2026-02-25';


UPDATE personnel
SET chef_id = 1
WHERE personnel_id = 3;


-- delete

delete from emprunt where emprunt_id = 1;

delete from lecteur where lecteur_id NOT in (select lecteur_id from emprunt); 

delete from ouvrage where ouvrage_id NOT in(select ouvrage_id from emprunt);
