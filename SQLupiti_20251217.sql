/*DBCC CHECKIDENT ('PolaznikProba', NORESEED)
INSERT INTO PolaznikProba VALUES ('Ivica', 'Kvazic', '20001205')
DBCC CHECKIDENT ('PolaznikProba', RESEED, 7)
INSERT INTO PolaznikProba VALUES ('Barica', 'Iviæ', '20001106')
*/

--Umetnite državu Madagaskar.
INSERT INTO Drzava (Naziv) VALUES ('Bahrein')
select SCOPE_IDENTITY() 
--Umetnite grad Buenos Aires u Argentinu. Pazite na redoslijed!
INSERT INTO Drzava (Naziv) VALUES ('Argentina')
select SCOPE_IDENTITY() 
SELECT * FROM Drzava
INSERT INTO Grad(Naziv, DrzavaID) VALUES ('Buenos Aires', 5)
insert into Grad (Naziv, DrzavaID) select 'Buenos Aires', IDDrzava from Drzava where Naziv = 'Argentina' 
--Umetnite proizvod "Sony Player" cijene 985,50 eura. Potkategorija je "Playeri", kategorija "Razno". Podatke koji nisu zadani izmislite.
INSERT INTO Kategorija(Naziv) VALUES ('Razno')
select SCOPE_IDENTITY() 
INSERT INTO Potkategorija(Naziv, KategorijaID) VALUES ('Playeri', 5)
select SCOPE_IDENTITY() 
INSERT INTO Proizvod([Naziv]
      ,[BrojProizvoda]
      ,[Boja]
      ,[MinimalnaKolicinaNaSkladistu]
      ,[CijenaBezPDV]
      ,[PotkategorijaID]) VALUES ('Sony Player',6 ,'Plava' ,5 ,'985,50' ,38 )
select SCOPE_IDENTITY() 
--Umetnite kupca Josipu Josiæ iz Gospiæa s emailom josipa@gmail.com i bez telefona.
INSERT INTO Grad(Naziv, DrzavaID) VALUES ('Gospiæ', 1)
select @@IDENTITY 
INSERT INTO Kupac (Email, Ime,Prezime, GradID) VALUES ('Josipa', 'Josiæ', 'josipa@gmail.com', 14)

--Umetnite kreditnu karticu po izboru.
INSERT INTO KreditnaKartica (Broj, IstekGodina, IstekMjesec, Tip) VALUES (431431434, 2027, 11, 'Visa')
--Napravite tablicu KupacVIP sa stupcima ime i prezime. Umetnite u nju sve kupce koji se zove Karen, Mary ili Jimmy.
CREATE TABLE KupacVIP (
IDKupacVIP int PRIMARY KEY IDENTITY,
Ime nvarchar(40),
Prezime nvarchar(50)
)

INSERT INTO KupacVIP
SELECT Ime, Prezime FROM Kupac WHERE Ime IN ('Karen', 'Mary', 'Jimmy')


--Kupcu Kim Abercrombie promijenite prebivalište u Osijek. Kojem toèno kupcu treba promijeniti prebivalište?
UPDATE Kupac SET GradID = 2 WHERE Ime = 'Kim' AND Prezime = 'Abercrombie'
--Kupcima èije prezime zapoèinje sa slovom A promijenite prebivalište u Rijeka
UPDATE Kupac SET GradID = 4 WHERE Prezime LIKE 'A%'
--Kupcima s ID-evima 40, 41 i 42 promijenite e-mail u nepoznato@nepoznato.com
UPDATE Kupac SET Email = 'nepoznato@nepoznato.com' WHERE IDKupac BETWEEN 40 AND 42
--Kupcu Eduardo Diaz promijenite ime u Edo
UPDATE Kupac SET Ime='Edo' WHERE Ime = 'Eduardo' AND Prezime = 'Diaz'
--Svim raèunima izdanim 01.04.2004. za koje se ne zna komercijalist i koji nisu plaæeni kreditnom karticom upišite komentar "Dodatno provjeriti!"
SELECT * FROM Racun WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL AND KreditnaKarticaID IS NULL
UPDATE Racun SET Komentar = 'Dodatno provjeriti!' WHERE DatumIzdavanja = '20040401' AND KomercijalistID IS NULL AND KreditnaKarticaID IS NULL


--Obrišite državu Njemaèku. U èemu je problem i kako ga riješiti?
DELETE FROM Drzava WHERE Naziv = 'Njemaèka'
--Obrišite sve kupce koji se prezivaju Trtimiroviæ. Je li se dogodila pogreška? Koliko ih je obrisano? 
SELECT * FROM Kupac WHERE Prezime = 'Trtimiroviæ'
DELETE FROM Kupac WHERE Prezime = 'Trtimiroviæ'
--Obrišite raèun s ID-em 75123.
SELECT * FROM Racun WHERE IDRacun = 75123
DELETE FROM Racun WHERE IDRacun = 75123


/*Upisati u bazu èinjenicu da je 18.05.2011. Robertu Mrkonjiæu (robi.mrki@gmail.si) iz Ljubljane izdan raèun RN18052011
za troje bijele trkaæe èarape velièine M i za 2 naljepnice za bicikl. Na nijedan artikl nije bilo popusta. 
Kupac je platio gotovinom, a prodaju je napravio novi komercijalist Garfild Maèkoviæ. */

--Promijenite u bazi netoèan podatak da je gospodin Mrkonjiæ iz Ljubljane; on je ustvari iz Beèa.

--Promijenite u bazi netoèan podatak da je gospodin Mrkonjiæ kupio naljepnice; on je ustvari kupio samo èarape.
