SELECT 
		Naziv,
		Boja,
		CijenaBezPDV
FROM Proizvod
WHERE CijenaBezPDV > 
	(SELECT AVG(CijenaBezPDV)  --podupit koji vraæa vrijednost 631.7002 
	 FROM Proizvod)
ORDER BY 
		CijenaBezPDV DESC

--Konstantni:
	SELECT Naziv,
		(
			SELECT COUNT(*) 
			FROM Proizvod
		) AS BrojProizvoda
	FROM Proizvod

--Korelirani:
	SELECT TOP 5 Naziv,
	(
		SELECT SUM(s.Kolicina) 
		FROM Stavka AS s
	WHERE s.ProizvodID =p.IDProizvod
	) AS Prodano
	FROM Proizvod AS p
	ORDER BY Prodano DESC


--Konstatni:
	SELECT 
		Naziv
	FROM Proizvod
	WHERE CijenaBezPDV > 
	(
		SELECT AVG(CijenaBezPDV) 
		FROM Proizvod
	)

--Korelirani s operatorom usporeðivanja:
	SELECT *
	FROM Kupac AS k
	WHERE 
	(
		SELECT COUNT(*) 
		FROM Racun AS r
 		WHERE r.KupacID =k.IDKupac
	) >= 27
	

--Konstantni s operatorom IN:
	SELECT *
	FROM Proizvod AS p
	WHERE IDProizvod IN 
	(
		SELECT DISTINCT 	
		s.ProizvodID
		FROM Stavka AS s
	)

--Korelirani s operatorom EXISTS:
	SELECT *
	FROM Proizvod AS p
	WHERE EXISTS
	(
		SELECT * 
		FROM Stavka AS s
	WHERE s.ProizvodID =p.IDProizvod
	)

--Ispišite sve potkategorije i za svaku ispišite broj proizvoda u njoj.

--Riješite prethodni zadatak pomoæu spajanja.

--Ispišite sve kategorije i za svaku ispišite broj proizvoda u njoj.

--Ispišite sve proizvode i pokraj svakog ispišite zaraðeni iznos, od najboljih prema lošijim.

--Dohvatite sve proizvode, uz svaki proizvod ispišite prosjeènu cijenu svih proizvoda te razliku prosjeène cijene svih proizvoda i cijene tog proizvoda. U obzir uzmite samo proizvode s cijenom veæom od nule.

--Dohvatite imena i prezimena 5 komercijalista koji su izdali najviše raèuna.

--Dohvatite imena i prezimena 5 najboljih komercijalista po broju realiziranih raèuna te uz svakog dohvatite i iznos prodane robe.

--Dohvatite sve boje proizvoda. Uz svaku boju pomoæu podupita dohvatite broj proizvoda u toj boji.

--Dohvatite imena i prezimena svih kupaca iz Frankfurta i uz svakog ispišite broj raèuna koje je platio karticom, od višeg prema nižem.

--Vratite sve proizvode èija je cijena pet ili više puta veæa od prosjeka.

--Vratite sve proizvode koji su prodavani, ali u kolièini manjoj od 5.

--Vratite sve proizvode koji nikad nisu prodani:
	--Pomoæu IN ili NOT IN
	--Pomoæu EXISTS ili NOT EXISTS
	--Pomoæu spajanja

--Vratite kolièinu zaraðenog novca za svaku boju proizvoda.

--Vratite kolièinu zaraðenog novca za svaku boju proizvoda, ali samo za one boje koje su zaradile više od 20.000.000.

--Vratiti sve proizvode koji imaju dodijeljenu potkategoriju i koji su prodani u kolièini veæoj od 5000. Uz svaki proizvod vratiti prodanu kolièinu i naziv kategorije.


--Upit u FROM dijelu je privremena tablica
SELECT Podaci.PotkategorijaID, Podaci.Boja, Podaci.Kolicina
FROM (
    SELECT PotkategorijaID, Boja, COUNT(*) AS Kolicina
    FROM Proizvod
    WHERE PotkategorijaID IS NOT NULL
    GROUP BY PotkategorijaID, Boja
) AS Podaci
WHERE Podaci.Kolicina > 10
ORDER BY Podaci.Kolicina DESC;



SELECT TOP 3 * FROM Kupac
GO

DECLARE @Ime nvarchar(50)
SELECT @Ime = Ime FROM Kupac WHERE IDKupac = 9821
PRINT @Ime
GO

PRINT @Ime -- Greška!

GO
DECLARE @ime nvarchar(50)
SET @ime = 'Ana'
SELECT @ime
PRINT @ime
GO
DECLARE @prodano int
SET @prodano = (SELECT SUM(Kolicina) FROM Stavka)

GO
DECLARE @NazivProizvoda nvarchar(50)
DECLARE @BojaProizvoda nvarchar(50)
		SELECT 
			@NazivProizvoda = p.Naziv,
			@BojaProizvoda = p.Boja
		FROM Proizvod AS p WHERE p.IDProizvod = 741
Select @NazivProizvoda
PRINT @BojaProizvoda
GO

