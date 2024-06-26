# KapitalismusKasse
Bank of the Future!

How to:

Es gibt insgesamt 3x Datenbank-Tabellen und 4x SQL-Befehlssätze:

Benutzer (2x)
Konto (1x)
Transaktion (1x)

- Benutzer-Tabelle anlegen in DB:

CREATE TABLE Benutzer 
	(
    b_id INT PRIMARY KEY auto_increment,
    vorname VARCHAR(50),
    nachname VARCHAR(50),
    email VARCHAR(100),
    pin INT,
    admin TINYINT,
    profilBild BLOB
	);
	
- Für das Anlegen eines Initial-Bildes bei Neu-Registrierung folgender Befehl:
 	DELIMITER // CREATE TRIGGER set_default_profilbild 
	BEFORE INSERT ON benutzer FOR EACH ROW BEGIN     
	IF NEW.profilBild IS NULL THEN SET NEW.profilBild = 
	(SELECT profilBild FROM benutzer WHERE b_id = 1);     
	END IF; END//  DELIMITER ;
	
	(Trigger-Befehl nach dem Anlegen aller drei Tabellen ausführen!!!)
	(Hinweis: Dieser Befehl muss für b_id = 1 angepasst werden, sofern der erste Datensatz in Tabelle Benutzer nicht das Initial-Bild haben sollte)
	(Über die Benutzerverwaltung muss dann ein Dummy-Profil angelegt werden und dann unter Benutzerverwaltung das Bild aus dem Projektordner (src/main/webapp/img/profilbild.jpeg) ausgewählt werden)

NACH DEM ERSTELLEN ALLER TABELLEN

- Konto-Tabelle anlegen in DB:
CREATE TABLE Konto 
	(
	IBAN VARCHAR(34) PRIMARY KEY,
	besitzer INT(11),
	kontoStand DECIMAL(15, 2),
	Dispo int(8) DEFAULT 0,
	FOREIGN KEY (besitzer) REFERENCES Benutzer(b_id) ON DELETE CASCADE
	);
	
- Transaktion-Tabelle anlegen in DB:
CREATE TABLE Transaktion (
    t_id INT PRIMARY KEY AUTO_INCREMENT,
    von VARCHAR(34) NOT NULL,
    nach VARCHAR(34) NOT NULL,
    summe DOUBLE NOT NULL,
    verzweck VARCHAR(150) NOT NULL,
    zeitstempel TIMESTAMP NOT NULL,
    CONSTRAINT fk_von FOREIGN KEY (von) REFERENCES Konto(IBAN) ON DELETE CASCADE,
    CONSTRAINT fk_nach FOREIGN KEY (nach) REFERENCES Konto(IBAN) ON DELETE CASCADE
);
