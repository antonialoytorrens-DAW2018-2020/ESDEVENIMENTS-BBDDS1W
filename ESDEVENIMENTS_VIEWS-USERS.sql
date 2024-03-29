/*Vistes*/
DROP VIEW IF EXISTS VISTA_ESDEVENIMENT_BUTACA;
CREATE VIEW VISTA_ESDEVENIMENT_BUTACA AS 
SELECT RECINTE.NOM_RECINTE, ESDEVENIMENT.NOM, ESDEVENIMENT.DESCRIPCIO, 
ESDEVENIMENT.DATA_INICI, ESDEVENIMENT.DATA_FI, ESDEVENIMENT.PREU, 
BUTACA.PK_FILA_BUTACA AS FILA_BUTACA, BUTACA.PK_NUMERO_BUTACA AS COLUMNA_BUTACA, 
(AFORAMENT-OCUPACIO) AS PLACES_RESTANTS 
FROM ESDEVENIMENT 
INNER JOIN RECINTE ON ESDEVENIMENT.FK_CODI_RECINTE = RECINTE.PK_CODI_RECINTE
LEFT OUTER JOIN BUTACA ON RECINTE.PK_CODI_RECINTE = BUTACA.PK_FK_CODI_RECINTE;

DROP VIEW IF EXISTS VISTA_ESDEVENIMENT_TIPUS;
CREATE VIEW VISTA_ESDEVENIMENT_TIPUS AS SELECT PK_FK_ID_TIPUS_ESDEVENIMENT, ESDEVENIMENT.NOM, NOM_TIPUS 
FROM ESDEVENIMENT 
INNER JOIN TIPUS_ESDEVENIMENT ON ESDEVENIMENT.PK_ID_ESDEVENIMENT = TIPUS_ESDEVENIMENT.PK_FK_ID_TIPUS_ESDEVENIMENT 
INNER JOIN TIPUS ON TIPUS_ESDEVENIMENT.PK_FK_CODI_TIPUS = TIPUS.PK_CODI_TIPUS;

DROP VIEW IF EXISTS VISTA_ENTRADAVENUDA_PUNT_VENTA;
CREATE VIEW VISTA_ENTRADAVENUDA_PUNT_VENTA AS 
SELECT PK_NUMERO_ENTRADA, ESDEVENIMENT.NOM AS NOM_ESDEVENIMENT, PUNT_VENTA.NOM AS NOM_PUNT_VENTA
FROM ENTRADA INNER JOIN ESDEVENIMENT ON ENTRADA.PK_FK_ID_ENTRADA_ESDEVENIMENT = ESDEVENIMENT.PK_ID_ESDEVENIMENT 
INNER JOIN PUNT_VENTA ON ENTRADA.FK_CODI_PUNT_VENTA = PUNT_VENTA.PK_CODI_PUNT_VENTA;

DROP VIEW IF EXISTS VISTA_ESDEVENIMENT_RESTRICCIO;
CREATE VIEW VISTA_ESDEVENIMENT_RESTRICCIO AS 
SELECT ESDEVENIMENT.NOM, RESTRICCIO.TIPUS_RESTRICCIO, RESTRICCIO.DESCRIPCIO FROM ESDEVENIMENT 
INNER JOIN RESTRICCIO_ESDEVENIMENT ON ESDEVENIMENT.PK_ID_ESDEVENIMENT = RESTRICCIO_ESDEVENIMENT.PK_FK_ID_REST_ESDEVENIMENT 
INNER JOIN RESTRICCIO ON RESTRICCIO_ESDEVENIMENT.PK_FK_CODI_RESTRICCIO = RESTRICCIO.PK_CODI_RESTRICCIO;

/*Usuaris*/
CREATE USER 'supervisor' IDENTIFIED BY 'SuperVisor123_01';
GRANT ALL PRIVILEGES ON AJUNTAMENT TO 'supervisor'@'localhost' IDENTIFIED BY 'SuperVisor123_01';
FLUSH PRIVILEGES;

CREATE USER 'administrador' IDENTIFIED BY 'Admin456_01';
GRANT ALL PRIVILEGES ON AJUNTAMENT TO 'administrador'@'localhost' IDENTIFIED BY 'Admin456_01';
FLUSH PRIVILEGES;

CREATE USER 'cliente' IDENTIFIED BY 'Clie111_01';
GRANT SELECT(VISTA_ESDEVENIMENT_BUTACA, VISTA_ESDEVENIMENT_TIPUS, VISTA_ESDEVENIMENT_RESTRICCIO) ON AJUNTAMENT TO 'cliente'@'localhost' IDENTIFIED BY 'Clie111_01';
FLUSH PRIVILEGES;

SELECT AFORAMENT, CAPACITAT, OCUPACIO FROM ESDEVENIMENT INNER JOIN RECINTE WHERE ESDEVENIMENT.FK_CODI_RECINTE = RECINTE.PK_CODI_RECINTE AND OCUPACIO > 0 ;