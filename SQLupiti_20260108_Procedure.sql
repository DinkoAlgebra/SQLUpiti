/*Napišite proceduru koja dohvaæa sve retke iz tablice Kupac. Pozovite proceduru. 
Promijenite proceduru tako da vraæa rezultate poredane po imenu pa po prezimenu. Uklonite proceduru. */
GO
CREATE PROCEDURE DohvatiKupce
AS
BEGIN 
	SELECT * FROM Kupac;
END

GO
--Pozovite proceduru
EXEC DohvatiKupce
GO
--Promijenite proceduru tako da vraæa rezultate poredane po imenu pa po prezimenu.
ALTER PROC DohvatiKupce
AS
BEGIN 
	SELECT * FROM Kupac ORDER BY Ime, Prezime;
END
GO
--Pozovite proceduru
EXEC DohvatiKupce
GO 
--Uklonite proceduru.
DROP PROCEDURE DohvatiKupce


/* 2. Napišite proceduru koja dohvaæa prvih 10 redaka iz tablice Proizvod, 
prvih 5 redaka iz tablice KreditnaKartica i zadnja 3 retka iz tablice Racun. 
Pozovite proceduru. Uklonite proceduru.
*/

--3. Napišite proceduru koja prima @ID proizvoda i  vraæa samo taj proizvod iz tablice Proizvod. Pozovite proceduru na oba naèina. Uklonite proceduru.
GO
CREATE PROCEDURE DohvatiProizvodPoID 
			@ID INT
AS
BEGIN 
	SELECT * FROM Proizvod WHERE IDProizvod = @ID;
END
GO
--Pozovite proceduru
--Bitan redoslijed
EXEC DohvatiProizvodPoID 1
GO
--Nije bitan redoslijed
EXEC DohvatiProizvodPoID @ID = 1
GO

--4. Napišite proceduru koja prima dvije cijene i vraæa nazive i cijene svih proizvoda èija cijena je u zadanom rasponu. 
--Pozovite proceduru na oba naèina. Uklonite proceduru.

--5. Napišite proceduru koja prima èetiri parametra potrebna za unos nove kreditne kartice. 
--Neka procedura napravi novi zapis u KreditnaKartica. Neka procedura prije i nakon umetanja dohvati broj zapisa u tablici. Pozovite proceduru na oba naèina. Uklonite proceduru.

--6. Napišite proceduru koja prima tri boje i za svaku boju vraæa proizvode u njoj. Pozovite proceduru i nakon toga je uklonite.
GO
CREATE PROCEDURE ProizvodiPoBojama 
			@Boja1 nvarchar(15), @Boja2 nvarchar(15),@Boja3 nvarchar(15)
AS
BEGIN 
	SELECT * FROM Proizvod WHERE Boja = @Boja1;
	SELECT * FROM Proizvod WHERE Boja = @Boja2;
	SELECT * FROM Proizvod WHERE Boja = @Boja3;
END
GO
--Pozovite proceduru
--Bitan redoslijed
EXEC ProizvodiPoBojama 'Crvena', N'Zelena', N'Šarena' --N dodajemo da nam odgovor podržava È,Ž,Š znakove
GO

/*7. Napišite proceduru koja prima parametre @IDProizvod i @Boja. Parametar @Boja neka bude izlazni parametar. 
Neka procedura za zadani proizvod vrati njegovu boju pomoæu izlaznog parametra. 
Pozovite proceduru na oba naèina i ispišite vraæenu vrijednost. Uklonite proceduru. */
GO
CREATE PROCEDURE DohvatiBojuProizvoda 
			@IDProizvod int, @Boja nvarchar(15) OUTPUT
AS
BEGIN 
	SELECT @Boja = Boja FROM Proizvod WHERE IDProizvod = @IDProizvod;
END
GO
--SELECT Boja FROM Proizvod WHERE IDProizvod = 679
--Pozovite proceduru
--Potrebno deklarirati varijablu - izlazni parametar
--bitan redoslijed
DECLARE @Boja2 nvarchar(15)
EXEC DohvatiBojuProizvoda 679, @Boja2 OUTPUT
PRINT 'Boja proizvoda je:' + @Boja2
GO
--nije bitan redoslijed upisivanja parametara
DECLARE @BojaRezultat nvarchar(15)
EXEC DohvatiBojuProizvoda @IDProizvod = 679, @Boja = @BojaRezultat OUTPUT
PRINT 'Boja proizvoda je:' + @BojaRezultat
GO


/* 8. Napišite proceduru koja prima kriterij po kojemu æete filtrirati prezimena iz tablice Kupac. 
Neka procedura pomoæu izlaznog parametra vrati broj zapisa koji zadovoljavaju zadani kriterij. 
Neka procedura vrati i sve zapise koji zadovoljavaju kriterij. Pozovite proceduru i ispišite vraæenu vrijednost. 
Uklonite proceduru. */

/* 9. Napišite proceduru koja za zadanog komercijalistu pomoæu izlaznih parametara vraæa njegovo ime i prezime te ukupnu kolièinu izdanih raèuna.  */


--RETURN parametar, provjera postoji li Grad

GO
CREATE PROCEDURE GradPostoji 
			@GradNaziv nvarchar(30)
AS
BEGIN 
	IF EXISTS (SELECT 1 FROM Grad WHERE Naziv = @GradNaziv)
	BEGIN
		RETURN 0;
	END
	ELSE
	BEGIN
		RETURN 1;
	END
END
GO
--Pozovite proceduru
--Bitan redoslijed
DECLARE @ReturnCode int;
EXEC @ReturnCode = GradPostoji @GradNaziv='Zagreb'

--EXEC @ReturnCode = GradPostoji @GradNaziv='Maribor'

IF @ReturnCode = 0
	PRINT 'Grad postoji'
ELSE
	PRINT 'Grad ne postoji'
GO