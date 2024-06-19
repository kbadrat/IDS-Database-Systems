DROP TABLE Osoba CASCADE CONSTRAINTS;
DROP TABLE Zamestnanec CASCADE CONSTRAINTS;
DROP TABLE Zakaznik CASCADE CONSTRAINTS;
DROP TABLE Auto CASCADE CONSTRAINTS;
DROP TABLE Surovina CASCADE CONSTRAINTS;
DROP TABLE Pecivo CASCADE CONSTRAINTS;
DROP TABLE Objednavka CASCADE CONSTRAINTS;

CREATE TABLE Osoba(
    id_osoby INT GENERATED ALWAYS AS IDENTITY,
    jmeno    VARCHAR(30) NOT NULL,
    prijmeni VARCHAR(30) NOT NULL,
    email    VARCHAR(60) NOT NULL UNIQUE,
    telefon  VARCHAR(15) NOT NULL UNIQUE,
    adresa   VARCHAR(255),
    cislo_bankovniho_uctu VARCHAR(22) NOT NULL UNIQUE,

    CHECK (REGEXP_LIKE(email, '^[a-z][a-z0-9_.-]*@[a-z0-9_.-]+\.[a-z]{2,}$')),
    CHECK (REGEXP_LIKE(cislo_bankovniho_uctu, '^(([0-9]{0,6})-)?([0-9]{2,10})/([0-9]{4})$'))
);

CREATE TABLE Zamestnanec(
    id_zamestnance NUMBER GENERATED ALWAYS AS IDENTITY ,
    id_osoby NUMBER NOT NULL,
    pozice VARCHAR(70) NOT NULL,
    mzda INT NOT NULL
);

CREATE TABLE Zakaznik(
    id_zakaznika NUMBER GENERATED ALWAYS AS IDENTITY  ,
    id_osoby NUMBER NOT NULL
);

CREATE TABLE Auto(
    id_auta VARCHAR(8) -- Státní poznávací značka

    CHECK (REGEXP_LIKE(id_auta, '^[1-9][A-CEHJ-MPS-UZ][1-9A-Z]:[0-9]{4}$'))
);

CREATE TABLE Surovina(
    id_suroviny INT GENERATED ALWAYS AS IDENTITY,
    typ VARCHAR(255) NOT NULL,
    cena NUMBER NOT NULL,
    mnozstvi VARCHAR(20) NOT NULL
);

CREATE TABLE Pecivo(
    id_peciva INT GENERATED ALWAYS AS IDENTITY,
    id_objednavky INT NOT NULL,
    nazev VARCHAR(50) NOT NULL,
    cena NUMBER NOT NULL,
    datum_vyroby DATE NOT NULL,
    datum_minimalni_trvanlivosti DATE NOT NULL,
    slozeni VARCHAR(255) NOT NULL,
    mnozstvi INT NOT NULL
);

CREATE TABLE Objednavka(
    id_objednavky INT GENERATED ALWAYS AS IDENTITY,
    id_zakaznika INT NOT NULL,
    stav VARCHAR(15) NOT NULL,
    datum_objednavky DATE NOT NULL,
    cena NUMBER NOT NULL,
    zpusob_platby VARCHAR(40) NOT NULL,
    zpusob_doruceni VARCHAR(20) NOT NULL,
    dorucovaci_adresa VARCHAR(255),
    datum_doruceni DATE NOT NULL
);

ALTER TABLE Osoba ADD CONSTRAINT PK_osoby PRIMARY KEY (id_osoby);
ALTER TABLE Zamestnanec ADD CONSTRAINT PK_zamestnanec PRIMARY KEY (id_zamestnance);
ALTER TABLE Zakaznik ADD CONSTRAINT PK_zakaznik PRIMARY KEY (id_zakaznika);

ALTER TABLE Auto ADD CONSTRAINT PK_auto PRIMARY KEY (id_auta);
ALTER TABLE Objednavka ADD CONSTRAINT PK_objednavka PRIMARY KEY (id_objednavky);
ALTER TABLE Surovina ADD CONSTRAINT PK_surovina PRIMARY KEY (id_suroviny);
ALTER TABLE Pecivo ADD CONSTRAINT PK_pecivo PRIMARY KEY (id_peciva);

ALTER TABLE Zakaznik ADD CONSTRAINT FK_zakaznik_osoba FOREIGN KEY(id_osoby) REFERENCES Osoba(id_osoby);
ALTER TABLE Zamestnanec ADD CONSTRAINT FK_zamestnanec_osoba FOREIGN KEY(id_osoby) REFERENCES Osoba(id_osoby);

ALTER TABLE Objednavka ADD CONSTRAINT FK_zakaznik_objednavka FOREIGN KEY (id_zakaznika) REFERENCES Zakaznik(id_zakaznika);
ALTER TABLE Pecivo ADD CONSTRAINT FK_pecivo_objednavka FOREIGN KEY (id_objednavky) REFERENCES Objednavka(id_objednavky);



INSERT INTO Osoba (jmeno, prijmeni, email, telefon, adresa, cislo_bankovniho_uctu)
    VALUES ('Vlad', 'Kovalets', 'vlad.ren@icloud.com', '+420773511610', 'Kolejní 2, 612 00 Brno', '2133861216/2020');
INSERT INTO Zamestnanec (id_osoby, pozice, mzda) VALUES (1, 'Pekař', 32800);

INSERT INTO Osoba (jmeno, prijmeni, email, telefon, adresa, cislo_bankovniho_uctu)
    VALUES ('Evgeniya', 'Taipova', 'taipova@gmail.com', '+420753232263', 'Černopolní 45, 613 00 Brno', '2183146011/1030');
INSERT INTO Zamestnanec (id_osoby, pozice, mzda) VALUES (2, 'Prodavačka', 28400);

INSERT INTO Osoba (jmeno, prijmeni, email, telefon, adresa, cislo_bankovniho_uctu)
    VALUES ('Jakub', 'Svoboda', 'j_svoboda21r@mail.com', '+420751738867', 'Vondrákova 6, 635 00 Brno-Bystrc', '2183248516/3030');
INSERT INTO Zamestnanec (id_osoby, pozice, mzda) VALUES (3, 'Kurýr', 30240);


INSERT INTO Osoba (jmeno, prijmeni, email, telefon, cislo_bankovniho_uctu)
    VALUES ('Barbora', 'Horáková', 'barbora12horak@icloud.com', '+420753123987', '2183156713/1111');
INSERT INTO Zakaznik (id_osoby) VALUES (4);

INSERT INTO Osoba (jmeno, prijmeni, email, telefon, adresa, cislo_bankovniho_uctu)
    VALUES ('Tereza', 'Svoboda', 'tereza.svoboda@icloud.com', '+420753224682', 'Zelný trh 6, 659 37 Brno-střed', '2183884123/3000');
INSERT INTO Zakaznik (id_osoby) VALUES (5);

INSERT INTO Osoba (jmeno, prijmeni, email, telefon, cislo_bankovniho_uctu)
    VALUES ('Jan', 'Novák', 'nov.jan@gmail.com', '+420487654971', '2182261213/2222');
INSERT INTO Zakaznik (id_osoby) VALUES (6);

INSERT INTO Osoba (jmeno, prijmeni, email, telefon,cislo_bankovniho_uctu)
    VALUES ('Lucie', 'Procházka', 'lucie125@icloud.com', '+420766248077', '2183111051/1411');
INSERT INTO Zakaznik (id_osoby) VALUES (7);


INSERT INTO Auto (id_auta) VALUES ('2B3:4003');
INSERT INTO Auto (id_auta) VALUES ('9B6:2401');
INSERT INTO Auto (id_auta) VALUES ('1B3:9127');
INSERT INTO Auto (id_auta) VALUES ('5B9:2013');


INSERT INTO Objednavka (id_zakaznika, stav, datum_objednavky, cena, zpusob_platby, zpusob_doruceni, datum_doruceni)
VALUES (1, 'Zrušeno', '26-3-2022', 62.90, 'Hotově / kartou (při vyzvednutí)', 'Prodejna', '28-3-2022');
INSERT INTO Objednavka (id_zakaznika, stav, datum_objednavky, cena, zpusob_platby, zpusob_doruceni, dorucovaci_adresa, datum_doruceni)
VALUES (1, 'Doručeno', '29-3-2022', 340.00, 'Kartou online', 'Doručení na adresu', 'Kolejní 2, 612 00 Brno', '1-4-2022');
INSERT INTO Objednavka (id_zakaznika, stav, datum_objednavky, cena, zpusob_platby, zpusob_doruceni, datum_doruceni)
VALUES (4, 'Zpracovává se', '1-4-2022', 833.40, 'Kartou online', 'Prodejna', '3-4-2022');


INSERT INTO Surovina (typ, cena, mnozstvi) VALUES ('Droždí', 99.00, '500 g');
INSERT INTO Surovina (typ, cena, mnozstvi) VALUES ('Margarin', 835.00, '10 kg');
INSERT INTO Surovina (typ, cena, mnozstvi) VALUES ('Cukr', 985.50, '15 kg');
INSERT INTO Surovina (typ, cena, mnozstvi) VALUES ('Jedlý papír', 2064.00, '100 ks');
INSERT INTO Surovina (typ, cena, mnozstvi) VALUES ('Sušený fermentovaný kvas', 625.00, '4 kg');


INSERT INTO Pecivo (id_objednavky, nazev, cena, datum_vyroby, datum_minimalni_trvanlivosti, slozeni, mnozstvi)
    VALUES (1, 'Rohlik', 2.5, '28-3-2022', '30-3-2022', 'Mouka, voda, olej, droždí, sůl, cukr', 10);
INSERT INTO Pecivo (id_objednavky, nazev, cena, datum_vyroby, datum_minimalni_trvanlivosti, slozeni, mnozstvi)
    VALUES (1, 'Bageta malá světlá', 3.90, '28-3-2022', '30-3-2022', 'Mouka, voda, olej, droždí, sůl', 2);
INSERT INTO Pecivo (id_objednavky, nazev, cena, datum_vyroby, datum_minimalni_trvanlivosti, slozeni, mnozstvi)
    VALUES (2, 'Crobliha borůvka', 79.90, '1-4-2022', '2-4-2022', 'Mouka, máslo, olej, droždí, voda, sůl, borůvková marmeláda, smetana, bílá čokoláda', 4);
INSERT INTO Pecivo (id_objednavky, nazev, cena, datum_vyroby, datum_minimalni_trvanlivosti, slozeni, mnozstvi)
    VALUES (3, 'Brioška máslová', 14.90, '3-4-2022', '5-4-2022', 'Mouka, máslo, droždí, voda, sůl, cukr, ovocná pasta s citronovou příchutí', 1);
INSERT INTO Pecivo (id_objednavky, nazev, cena, datum_vyroby, datum_minimalni_trvanlivosti, slozeni, mnozstvi)
    VALUES (3, 'Rohlik', 2.5, '3-4-2022', '5-4-2022', 'Mouka, voda, olej, droždí, sůl, cukr', 4);