--Dohvatite sve retke iz tablice Proizvod
SELECT * FROM Proizvod
--Dohvatite sve retke iz tablice Drzava
SELECT * FROM Drzava
--Dohvatite sve retke iz tablice Grad
SELECT * FROM Grad

--Probni primjeri
SELECT * FROM Proizvod WHERE Boja = 'Crna'
SELECT * FROM Proizvod WHERE CijenaBezPDV > 330
SELECT * FROM Proizvod WHERE Boja = 'Crna' AND CijenaBezPDV > 330

SELECT * FROM Proizvod WHERE Boja NOT IN('Srebrna', 'Crvena')

SELECT * FROM Proizvod WHERE BrojProizvoda LIKE 'CA%'
SELECT * FROM Proizvod WHERE Boja LIKE 'Cr_ena'

--Zadaci
--Dohvatiti sve kupce iz tablice Kupac:
--Koji se zovu Lili
SELECT * FROM Kupac WHERE Ime = 'Lili'
--Koji se prezivaju Lee
SELECT * FROM Kupac WHERE Prezime = 'Lee'
--Koji se zovu Ana i prezivaju Diaz
SELECT * FROM Kupac WHERE Ime = 'Ana' AND Prezime = 'Diaz'
--Koji su iz Osijeka
SELECT * FROM Grad 
SELECT * FROM Kupac WHERE GradID = 2
--Koji se zovu Ana ili Tamara
SELECT * FROM Kupac WHERE Ime = 'Ana' OR Ime = 'Tamara'
--Koji se zovu Ana ili Tamara i iz Osijeka su
SELECT * FROM Kupac WHERE (Ime = 'Ana' OR Ime = 'Tamara') AND GradID = 2
--Koji se zovu Ana ili Tamara i nisu iz Osijeka
SELECT * FROM Kupac WHERE (Ime = 'Ana' OR Ime = 'Tamara') AND NOT GradID = 2





--Dohvatiti sve stavke iz tablice Stavka:
--Èija je ukupna cijena manja od 2 eura
SELECT * FROM Stavka WHERE UkupnaCijena < 2
--Èija je ukupna cijena veæa ili jednaka 23000 eura
SELECT * FROM Stavka WHERE UkupnaCijena >= 23000
--Èija je kolièina veæa ili jednaka 20 i manja ili jednaka 22
SELECT * FROM Stavka WHERE Kolicina BETWEEN 20 AND 22




--Dohvatiti sve proizvode iz tablice Proizvod:
--Èija je boja plava ili crvena
SELECT * FROM Proizvod WHERE Boja IN ('Plava','crvena')
--Èija boja nije definirana
SELECT * FROM Proizvod WHERE Boja IS NULL
--Èija je boja srebrna ili nije definirana
SELECT * FROM Proizvod WHERE Boja IS NULL OR Boja ='Srebrna'
--Èija je boja definirana
SELECT * FROM Proizvod WHERE Boja IS NOT NULL
--Èija boja nije definirana i cijena je manja od 25 eura
SELECT * FROM Proizvod WHERE Boja IS NULL AND CijenaBezPDV <25


--Dohvatiti sve raèune iz tablice Racun:
--Koji su izdani 14.7.2004.
SELECT * FROM Racun WHERE DatumIzdavanja = '20040714'
--Koji su izdani 14.7.2004. ili 15.7.2004.
SELECT * FROM Racun WHERE DatumIzdavanja = '20040714' OR DatumIzdavanja = '20040715'
SELECT * FROM Racun WHERE DatumIzdavanja IN ('20040714' ,'20040715')

--Koji su izdani izmeðu 14.7.2004. i 21.7.2004.
SELECT * FROM Racun WHERE DatumIzdavanja BETWEEN '20040714' AND '20040721'

--Dohvatiti sve kupce iz tablice Kupac:
--Èija je vrijednost primarnog kljuèa 10, 25, 74 ili 154
SELECT * FROM Kupac WHERE IDKupac IN (10,25,74,154)
--Èije ime zapoèinje slovima "Ki"
SELECT * FROM Kupac WHERE Ime LIKE 'Ki%'
--Èije prezime završava slovima "ams"
SELECT * FROM Kupac WHERE Prezime LIKE '%ams'
--Èije prezime zapoèinje slovom "D" i prezime sadržava string "re"
SELECT * FROM Kupac WHERE Prezime LIKE 'D%' AND Prezime LIKE '%re%'


--Primjeri
SELECT Ime AS KupacIme,Prezime AS KupacPrezime FROM Kupac WHERE Ime LIKE 'Ki%'
SELECT Ime + ' ' +Prezime AS KupacPunoIme FROM Kupac WHERE Ime LIKE 'Ki%'

--Dohvatiti iz tablice Kupac:

--Imena i prezimena osoba èije ime poèinje s "Ki"
SELECT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Ki%'
--Imena i prezimena osoba koji imaju primarni kljuè izmeðu 15530 i 15535. Prvi stupac preimenovati u "KupacIme", drugi u "KupacPrezime"
SELECT Ime AS KupacIme,Prezime AS KupacPrezime FROM Kupac WHERE IDKupac BETWEEN 15530 AND 15535
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe.
SELECT Prezime + ' ' +Ime AS PunoIme FROM Kupac
--Ime, Prezime, PunoIme, te email adresu
SELECT Ime, Prezime, Prezime + ' ' +Ime, Email AS PunoIme FROM Kupac
--Jedinstvena imena
SELECT DISTINCT Ime FROM Kupac
--Jedinstvena prezimena
SELECT DISTINCT Prezime FROM Kupac
--Jedinstvena imena i prezimena
SELECT * FROM Kupac
SELECT DISTINCT Ime, Prezime FROM Kupac ORDER BY Prezime, Ime DESC



--Dohvatiti iz tablice Kupac:

--Imena i prezimena osoba èije ime poèinje s "Kat", sortirane prema imenu uzlazno pa prema prezimenu uzlazno
SELECT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Ki%' ORDER BY Ime,Prezime
--Imena i prezimena osoba èije ime poèinje s "Kat", sortirane prema imenu uzlazno pa prema prezimenu silazno
SELECT Ime, Prezime FROM Kupac WHERE Ime LIKE 'Ki%' ORDER BY Ime,Prezime DESC
--Imena i prezimena osoba koji imaju primarni kljuè izmeðu 18150 i 18155. Prvi stupac preimenovati u "KupacIme", drugi u "KupacPrezime". Sortirati prema stupcu KupacPrezime silazno.
SELECT Ime AS KupacIme,Prezime AS KupacPrezime FROM Kupac WHERE IDKupac BETWEEN 18150 AND 18155 ORDER BY KupacPrezime DESC
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe. Sortirati uzlazno.
SELECT Prezime + ' ' +Ime AS PunoIme FROM Kupac ORDER BY PunoIme
--Jedan stupac PunoIme koji se sastoji od spojenog prezimena i imena za sve osobe. Sortirati silazno.
SELECT DISTINCT Prezime + ' ' +Ime AS PunoIme FROM Kupac ORDER BY PunoIme DESC


--Dohvatiti iz tablice Kupac:

--Prvih 5 redaka iz tablice
SELECT TOP (5) * FROM Kupac
--Imena i prezimena zadnjih 5 redaka iz tablice
SELECT TOP (5) * FROM Kupac ORDER BY IDKupac DESC
--Polovicu prvih osoba koje se zovu "Jack"
SELECT TOP (50) PERCENT * FROM Kupac WHERE Ime = 'Jack'
--Samo prezimena polovice prvih osoba koje se zovu "Jack"
SELECT TOP (50) PERCENT Prezime FROM Kupac WHERE Ime = 'Jack'
