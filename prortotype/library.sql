
CREATE DATABASE library;
USE library;


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

INSERT INTO rayon(nom) values
('Informatique'),
('Mathématiques'),
('Physique'),
('Littérature');

INSERT INTO auteur(nom,prenom) values
('Benal', 'Ahmed'),
('El Fassi', 'Khadija'),
('Dupont', 'Jean'),
('Martin', 'Paul');

INSERT INTO lecteur(nom,prenom,email,tel,cin)values
('Ait', 'Yassine', 'yassine@gmail.com', '0612345678', 'AB123456'),
('El Amrani', 'Sara', 'sara@gmail.com', '0623456789', 'CD234567'),
('Bennani', 'Omar', 'omar@gmail.com', '0634567890', 'EF345678');

INSERT INTO lecteur (nom, prenom, email, tel, cin) VALUES
('Hassan', 'Ali', 'hassan@gmail.com', '0645678901', 'GH456789');




INSERT into ouvrage(titre,annee_publication,rayon_id)values
('Introduction à linformatique', 2020, 1),
('Algèbre linéaire', 2018, 2),
('Physique quantique', 2019, 3),
('Roman moderne', 2021, 4);

INSERT INTO ouvrage_auteur (ouvrage_id, auteur_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);



INSERT INTO emprunt (date_retour_prevue, date_retour_effective, lecteur_id, ouvrage_id) VALUES
('2026-01-20', NULL, 1, 1),
('2026-01-22', '2026-01-21', 2, 2),
('2026-01-25', NULL, 3, 3);







INSERT INTO personnel (nom, email, tel, mot_de_passe, chef_id) VALUES
('Admin', 'admin@library.com', '0600000000', 'admin123', NULL),
('Employe1', 'emp1@library.com', '0611111111', 'emp123', 1),
('Employe2', 'emp2@library.com', '0622222222', 'emp123', 1);



-- select 


--Afficher tous les rayons de la bibliothèque.

SELECT * FROM rayon ;




--Afficher le nom et le prénom de tous les auteurs.

select nom , prenom from auteur;




--Afficher le titre et l’année de publication de tous les ouvrages.

select titre , annee_publication 
FROM ouvrage;




--Afficher le nom, le prénom et l’email de tous les lecteurs.

SELECT nom  , prenom , email 
from lecteur;




--Afficher les ouvrages publiés après l’année 1950.

SELECT titre 
from ouvrage 
WHERE annee_publication > 1950;





--Afficher les lecteurs dont le nom commence par la lettre M.

SELECT nom 
from lecteur
WHERE nom like 'A%';





--Afficher les ouvrages triés par année de publication (du plus récent au plus ancien).

SELECT titre
FROM ouvrage
ORDER BY annee_publication ASC;




--Afficher les emprunts dont la date de retour effective est nulle.

SELECT * from emprunt 
WHERE date_retour_effective is NULL;




--Afficher la liste des ouvrages avec le nom de leur rayon.

select ouvrage.titre , rayon.nom 
from ouvrage 
INNER JOIN rayon
ON ouvrage.rayon_id = rayon.rayon_id;




--Afficher les titres des ouvrages ainsi que le nom et le prénom de leurs auteurs.

 SELECT ouvrage.titre , auteur.nom , auteur.prenom 
 FROM ouvrage
 INNER JOIN ouvrage_auteur ON ouvrage.ouvrage_id = ouvrage_auteur.ouvrage_id
 INNER JOIN auteur ON auteur.auteur_id = ouvrage_auteur.auteur_id;





--Afficher les lecteurs ayant effectué au moins un emprunt.

 select lecteur.nom , count(emprunt_id) AS totale 
 from lecteur 
 LEFT JOIN emprunt
 on lecteur.lecteur_id = emprunt.lecteur_id 
 GROUP BY lecteur.nom 
 HAVING (totale>=1) ;



--Afficher le nombre d’ouvrages par rayon.

SELECT rayon.nom ,  count(ouvrage_id)
as totale 
FROM rayon
INNER JOIN ouvrage 
on rayon.rayon_id = ouvrage.rayon_id 
GROUP BY rayon.nom ;





--UPDATE


--Modifier l’adresse email d’un lecteur à partir de son identifiant

UPDATE lecteur 
set email ='solicode@gmali.com' 
where lecteur_id = 1;





--Mettre à jour le numéro de téléphone d’un lecteur à partir de son numéro CIN.

UPDATE lecteur 
SET tel = '0640412034' 
WHERE cin = 'CD234567' ;




--Modifier le rayon d’un ouvrage donné.

UPDATE ouvrage 
SET rayon_id = 3 WHERE 
rayon_id = 1 ;



--Mettre à jour la date de retour effective d’un emprunt lors du retour d’un ouvrage.

UPDATE emprunt 
SET date_retour_effective = '2030_2_1' 
WHERE date_retour_prevue ='2026-01-22';


--Modifier le chef d’un membre du personnel.

UPDATE personnel
SET chef_id = 3
WHERE personnel_id = 2;





--DELETE


--Supprimer un emprunt à partir de son identifiant.

DELETE from emprunt 
where emprunt_id = 2 ;



--Supprimer un lecteur n’ayant jamais effectué d’emprunt.

DELETE FROM lecteur
WHERE NOT EXISTS (
    SELECT 1
    FROM emprunt
    WHERE emprunt.lecteur_id = lecteur.lecteur_id
);



--Supprimer un ouvrage qui n’a jamais été emprunté.


DELETE FROM ouvrage
WHERE NOT EXISTS (
    SELECT 1
    FROM emprunt
    WHERE emprunt.ouvrage_id = ouvrage.ouvrage_id
);
