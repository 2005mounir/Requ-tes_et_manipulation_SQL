USE exersicedata ;
CREATE TABLE lang(
    id_lang INT PRIMARY KEY  UNIQUE,
    titre VARCHAR(100)  NOT NULL
    );

    CREATE TABLE users (
    id_ INT UNIQUE PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    id_lang INT ,
    FOREIGN KEY (id_lang) REFERENCES lang(id_lang)
   );

INSERT INTO lang(id_lang,titre)
values
(1,'arabic'),
(2,'frc'),
(3,'englaich'),
(4,'spanich');

INSERT INTO  users (id,nom,email,id_lang)
values
(1,'ahmed','ahmed@gmail.com',1),
(2,'ali','ali@gmail.com',2),
(3,'omar','omar@gmail.com',3) ; 








START TRANSACTION;

INSERT INTO users (id_, nom, email, id_lang)
VALUES (5, 'karim', 'karim@gmail.com'); 

UPDATE users
SET nom = 'Omar Updated'
WHERE id = 3;

DELETE FROM users
WHERE id = 2;

ROLLBACK;

