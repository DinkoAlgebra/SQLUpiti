--Napravite tablicu Polaznik i u nju umetnite nekoliko redaka. Napravite tablicu Zapisnik.
CREATE TABLE Polaznik (
	IDPolaznik INT PRIMARY KEY IDENTITY,
	Ime nvarchar(15),
	Prezime nvarchar(30),
)

INSERT INTO Polaznik (Ime, Prezime) VALUES ('Marko', 'Mariæ'),('Iva', 'Iviæ'),('Snješka', 'Bijeliæ')
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Mario', 'Mihiæ')
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Barbara', 'Aniæ')
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Marko', 'Bariæ')
CREATE TABLE Zapisnik (
	IDZapisa INT PRIMARY KEY IDENTITY,
	Akcija nvarchar(10),
	Detalji nvarchar(50),
	Vrijeme DATETIME DEFAULT GETDATE()
	)

--Napravite okidaè kojim æete svako umetanje retka u tablicu Polaznik zapisati u tablicu Zapisnik. 
GO
CREATE TRIGGER trg_AfterInsert_Polaznik
ON Polaznik
AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Zapisnik (Akcija, Detalji) VALUES ('Insert', 'Umetnut novi polaznik u tablicu Polaznik')

END

GO
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Unos', 'Prvi')
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Unos', 'Drugi')
--Promijenite okidaè tako da zapiše ime, prezime umetnutog polaznika u Zapisnik.
GO
DROP TRIGGER trg_AfterInsert_Polaznik
GO
CREATE TRIGGER trg_AfterInsert_Polaznik
ON Polaznik
AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Zapisnik (Akcija, Detalji) SELECT 'Insert', 'Umetnut' + ' ' +Ime + ' ' + Prezime FROM inserted;

END

GO
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Unos', 'Treæi')

/* Promijenite okidaè tako da se veže uz sve dogaðaje i u Zapisnik zapisuje broj redaka u inserted i deleted tablicama. 
Umetnite novog polaznika, promijenite svim polaznicima prezime i na kraju obrišite sve polaznike. */
GO
DROP TRIGGER trg_AfterInsert_Polaznik
GO
DROP TRIGGER trg_AfterInsertDelete_Polaznik
GO
CREATE TRIGGER trg_AfterInsertDelete_Polaznik
ON Polaznik
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @UmetnutiRed INT = (SELECT COUNT(*) FROM inserted)
	DECLARE @ObrisaniRed INT = (SELECT COUNT(*) FROM deleted)
	INSERT INTO Zapisnik (Akcija, Detalji) VALUES ('Insert', 'Umetnutih redaka:' + ' ' + CAST(@UmetnutiRed AS nvarchar) + ' ' + 'Obrisanih redaka:' + CAST(@ObrisaniRed AS nvarchar));
END

GO
INSERT INTO Polaznik (Ime, Prezime) VALUES ('Unos', 'Èetvrti')
UPDATE Polaznik SET Prezime='Promjena'
DELETE FROM Polaznik



--*****************

GO
DROP TRIGGER trg_AfterInsert_Polaznik
GO
DROP TRIGGER trg_AfterInsertDelete_Polaznik
GO
CREATE TRIGGER trg_AfterInsertDelete_Polaznik
ON Polaznik
AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	DECLARE @UmetnutiRed INT = (SELECT COUNT(*) FROM inserted)
	DECLARE @ObrisaniRed INT = (SELECT COUNT(*) FROM deleted)
	
	--Umetanje / Insert
	IF EXISTS (SELECT COUNT(*) FROM inserted) AND NOT EXISTS (SELECT COUNT(*) FROM deleted)
	BEGIN 
	INSERT INTO Zapisnik (Akcija, Detalji) VALUES ('Insert', 'Umetnutih redaka:' + ' ' + CAST(@UmetnutiRed AS nvarchar) + ' ' + 'Obrisanih redaka:' + CAST(@ObrisaniRed AS nvarchar));
	END

		--Brisanje
	IF EXISTS (SELECT COUNT(*) FROM deleted) AND NOT EXISTS (SELECT COUNT(*) FROM inserted)
	BEGIN 
	INSERT INTO Zapisnik (Akcija, Detalji) VALUES ('Delete', 'Umetnutih redaka:' + ' ' + CAST(@UmetnutiRed AS nvarchar) + ' ' + 'Obrisanih redaka:' + CAST(@ObrisaniRed AS nvarchar));
	END

		--Ažuriranje
	IF EXISTS (SELECT COUNT(*) FROM inserted) AND EXISTS (SELECT COUNT(*) FROM deleted)
	BEGIN 
	INSERT INTO Zapisnik (Akcija, Detalji) VALUES ('Update', 'Umetnutih redaka:' + ' ' + CAST(@UmetnutiRed AS nvarchar) + ' ' + 'Obrisanih redaka:' + CAST(@ObrisaniRed AS nvarchar));
	END
END

GO

--Promijenite okidaè tako da upisuje staru i novu vrijednost promijenjenog prezimena u Zapisnik.
