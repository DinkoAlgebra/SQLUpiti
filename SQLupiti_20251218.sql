/*Upisati u bazu činjenicu da je 18.05.2011. Robertu Mrkonjiću (robi.mrki@gmail.si) iz Ljubljane 
izdan račun RN18052011 za troje bijele trkaće čarape veličine M i za 2 naljepnice za bicikl. 
Na nijedan artikl nije bilo popusta. Kupac je platio gotovinom, 
a prodaju je napravio novi komercijalist Garfild Mačković. */

SELECT * FROM Komercijalist WHERE Ime='Garfild' AND Prezime ='Mačković'
SELECT * FROM Proizvod WHERE Naziv LIKE '%socks%' --874
SELECT * FROM Proizvod WHERE Naziv LIKE '%sticks%' 
INSERT INTO Proizvod (Naziv,BrojProizvoda, MinimalnaKolicinaNaSkladistu, CijenaBezPDV) VALUES ('naljepnice za bicikl', 20,150, 2.55) 
SELECT * FROM Racun
SELECT * FROM Grad
INSERT INTO Grad(Naziv) VALUES ('Ljubljana') 
SELECT * FROM Kupac  WHERE Ime='Robert' AND Prezime ='Mrkonjić'
INSERT INTO Kupac(Email, GradID, Ime, Prezime) VALUES('robi.mrki@gmail.si', 15, 'Robert', 'Mrkonjić')
INSERT INTO Racun(DatumIzdavanja,BrojRacuna, KupacID, KomercijalistID) VALUES ('20110518', 'RN17052011', 19979, 287)
SELECT * FROM Stavka 
INSERT INTO Stavka(RacunID, Kolicina, ProizvodID, CijenaPoKomadu, UkupnaCijena, PopustUPostocima) VALUES (75124, 2, 874, 1.22, 2*1.22, 0)
INSERT INTO Stavka(RacunID, Kolicina, ProizvodID, CijenaPoKomadu, UkupnaCijena, PopustUPostocima) VALUES (75124, 3, 1005, 2.22, 3*2.22, 0)

--Promijenite u bazi netočan podatak da je gospodin Mrkonjić iz Ljubljane; on je ustvari iz Beča.
UPDATE Kupac SET GradID=3 WHERE IDKupac=19979
--Promijenite u bazi netočan podatak da je gospodin Mrkonjić kupio naljepnice; on je ustvari kupio samo čarape.
SELECT * FROM Stavka
DELETE FROM Stavka WHERE IDStavka=121320

--INNER JOIN (Spajanje)
SELECT g.Naziv AS NazivGrada, d.Naziv AS NazivDržave
FROM Grad AS g
INNER JOIN Drzava AS d
ON g.DrzavaID = d.IDDrzava

--Filtriranje i sortiranje
SELECT g.Naziv AS NazivGrada, d.Naziv AS NazivDržave
FROM Grad AS g
INNER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava
WHERE g.Naziv LIKE 'S%' OR g.Naziv LIKE 'Z%'
ORDER BY NazivDržave DESC

--Zadaci
--Dohvatiti imena i prezimena svih kupaca i uz svakog ispisati naziv grada.
SELECT
	k.Ime AS ImeKupca,
	k.Prezime AS PrezimeKupca,
	g.Naziv
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad

--Dohvatiti imena i prezimena svih kupaca i uz svakog ispisati naziv grada i države.
SELECT
	k.Ime AS ImeKupca,
	k.Prezime AS PrezimeKupca,
	g.Naziv,
	d.Naziv
FROM Kupac AS k
INNER JOIN Grad AS g ON k.GradID = g.IDGrad
INNER JOIN Drzava AS d ON g.DrzavaID = d.IDDrzava


--FUnkcije i grupiranje
SELECT 
		MIN(CijenaBezPDV) AS NajnizaCijena,
		MAX(CijenaBezPDV) AS NajvisaCijena,
		AVG(CijenaBezPDV) AS ProsjecnaCijena
	FROM Proizvod
	WHERE CijenaBezPDV > 0

SELECT * FROM Kupac WHERE Telefon IS NULL
SELECT Ime, ISNULL(Telefon, 0) AS Telefon FROM Kupac WHERE Telefon IS NULL

--Zadaci: 
--Vratite broj svih proizvoda.
SELECT COUNT(*) FROM Proizvod 
--Vratite broj proizvoda koji imaju definiranu boju.
SELECT COUNT(Boja) AS ProizvodiSBojom FROM Proizvod
SELECT COUNT(*) FROM Proizvod WHERE Boja IS NOT NULL
--Vratite najvišu cijenu proizvoda.
SELECT MAX(CijenaBezPDV) AS NajvišaCijena FROM Proizvod
--Vratite prosječnu cijenu proizvoda iz potkategorije 16.
SELECT AVG(CijenaBezPDV) AS ProsječnaCijena FROM Proizvod WHERE PotkategorijaID=16
--Vratite datume najstarijeg i najnovijeg računa izdanog kupcu 131.
SELECT MIN(DatumIzdavanja) AS NajstarijiRačun, MAX(DatumIzdavanja) AS NajnovijiRačun FROM Racun WHERE KupacID=131



SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja

SELECT 
Boja, PotkategorijaID, COUNT(*) AS Kolicina
FROM Proizvod
GROUP BY Boja, PotkategorijaID
ORDER BY Boja, PotkategorijaID

--Zadaci:
--Ispišite sve boje proizvoda i pokraj svake napišite koliko proizvoda ima tu boju.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
GROUP BY Boja

--Promijenite prethodni upit tako da sortirate padajuće prema broju proizvoda.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
GROUP BY Boja
ORDER BY BrojProizvoda DESC

--Promijenite prethodni upit tako da isključite nedefiniranu boju.
SELECT 
Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja
ORDER BY BrojProizvoda DESC
--Ispišite koliko proizvoda svake boje ima u svakoj od potkategorija. Sortirajte prema potkategoriji i prema boji.
SELECT 
Boja, PotkategorijaID, COUNT(*) AS Kolicina
FROM Proizvod
GROUP BY Boja, PotkategorijaID
ORDER BY PotkategorijaID, Boja

--Promijenite prethodni upit tako da ispišete 10 kategorija i boja s najviše proizvoda.
SELECT TOP (10)
Boja, PotkategorijaID, COUNT(*) AS Kolicina
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja, PotkategorijaID
--HAVING COUNT(*) >14
ORDER BY Kolicina DESC



--Ispišite sve boje koje imaju više od 40 proizvoda.
SELECT 
	Boja, COUNT(*) AS BrojProizvoda
FROM Proizvod
WHERE Boja IS NOT NULL
GROUP BY Boja
HAVING COUNT(*) >40
--Ispišite nazive svih potkategorija koje sadržavaju više od 10 proizvoda.
SELECT pk.Naziv, COUNT (*) AS Kolicina
FROM Proizvod AS p
INNER JOIN Potkategorija AS pk ON pk.IDPotkategorija = p.PotkategorijaID
GROUP BY pk.Naziv
HAVING COUNT(*)>10
ORDER BY Kolicina DESC




--Praznici
--Za sve račune izdane 01.08.2002. i plaćene American Expressom ispisati njihove ID-eve i brojeve te ime i prezime i grad kupca, ime i prezime komercijaliste te broj i podatke o isteku kreditne kartice. Rezultate sortirati prema prezimenu kupca.
--Ispisati nazive proizvoda koji su na nekoj stavci računa prodani u više od 35 komada. Svaki proizvod navesti samo jednom.
--Promijenite prethodni upit tako da umjesto ID potkategorije ispišete njen naziv.

--Ispišite nazive svih kategorija i pokraj svake napišite koliko potkategorija je u njoj.

--Ispišite nazive svih kategorija i pokraj svake napišite koliko proizvoda je u njoj.

--Ispišite sve različite cijene proizvoda i napišite koliko proizvoda ima svaku cijenu.

--Ispišite koliko je računa izdano koje godine.

--Ispišite brojeve svih račune izdane kupcu 377 i pokraj svakog ispišite ukupnu cijenu po svim stavkama.

--Ispišite ukupno zarađene iznose i broj prodanih primjeraka za svaki od ikad prodanih proizvoda.

--Ispišite ukupno zarađene iznose za svaki od proizvoda koji je prodan u više od 2000 primjeraka.

--Ispišite ukupno zarađene iznose za svaki od proizvoda koji je prodan u više od 2.000 primjeraka ili je zaradio više od 2.000.000 dolara.

