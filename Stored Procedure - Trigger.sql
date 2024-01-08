
---DISEÑO DE LAS TABLAS ---

ALTER TABLE LECTOR
ALTER COLUMN NRO_LECTOR int NOT NULL;

ALTER TABLE COPIAS
ALTER COLUMN NRO_LIBRO int NOT NULL;

ALTER TABLE COPIAS
ALTER COLUMN NRO_COPIA smallint NOT NULL;

ALTER TABLE PRESTAMO
ALTER COLUMN NRO_LECTOR int NOT NULL;


ALTER TABLE PRESTAMO
ALTER COLUMN NRO_LIBRO int NOT NULL;


ALTER TABLE PRESTAMO
ALTER COLUMN NRO_COPIA smallint NOT NULL;


-- Restricciones de Integridad

-- PK para las tablas
ALTER TABLE LIBRO
ADD CONSTRAINT PK_LIBRO PRIMARY KEY (NRO_LIBRO);

ALTER TABLE TIPOLIBRO
ADD CONSTRAINT PK_TIPOLIBRO PRIMARY KEY (TIPO);

ALTER TABLE LECTOR
ADD CONSTRAINT PK_LECTOR PRIMARY KEY (NRO_LECTOR);

ALTER TABLE COPIAS
ADD CONSTRAINT PK_COPIAS PRIMARY KEY (NRO_LIBRO, NRO_COPIA);

ALTER TABLE PRESTAMO
ADD CONSTRAINT PK_PRESTAMO PRIMARY KEY (NRO_LECTOR, NRO_LIBRO, NRO_COPIA, F_PREST);

-- FK para garantizar la integridad referencial
ALTER TABLE COPIAS
ADD CONSTRAINT FK_COPIAS_LIBRO FOREIGN KEY (NRO_LIBRO) REFERENCES LIBRO(NRO_LIBRO);

ALTER TABLE PRESTAMO
ADD CONSTRAINT FK_PRESTAMO_LIBRO FOREIGN KEY (NRO_LIBRO, NRO_COPIA) REFERENCES COPIAS(NRO_LIBRO, NRO_COPIA);

ALTER TABLE PRESTAMO
ADD CONSTRAINT FK_PRESTAMO_LECTOR FOREIGN KEY (NRO_LECTOR) REFERENCES LECTOR(NRO_LECTOR);

-- Checks para los campos ESTADO
ALTER TABLE COPIAS
ADD CONSTRAINT CK_COPIAS_ESTADO CHECK (ESTADO IN ('P', 'D', 'N'));

ALTER TABLE LIBRO
ADD CONSTRAINT CK_LIBRO_ESTADO CHECK (ESTADO IN ('D', 'N'));

-- Default Values para el campo ESTADO en LECTOR
ALTER TABLE LECTOR
ADD CONSTRAINT DF_LECTOR_ESTADO DEFAULT ('H') FOR ESTADO;


-- Trigger para verificar la habilitación de un préstamo al realizar uno nuevo, y actualizar el estado de la copia en caso de realizarse el préstamo

CREATE TRIGGER [dbo].[TriggerVerificarHabilitacionPrestamo]
ON [dbo].[PRESTAMO]
AFTER INSERT
AS
BEGIN
    DECLARE @NRO_LECTOR int;
	DECLARE @NRO_LIBRO int;
	DECLARE @NRO_COPIA smallint;

    SELECT @NRO_LECTOR = NRO_LECTOR
    FROM INSERTED;

    SELECT @NRO_LIBRO = NRO_LIBRO
    FROM INSERTED;

    SELECT @NRO_COPIA = NRO_COPIA 
    FROM INSERTED;
     
    EXEC VerificarCopiaDisponible @NRO_LIBRO, @NRO_COPIA
    EXEC VerificarLectorHabilitado @NRO_LECTOR
	
   
-- Actualizar el estado de la Copia---
	UPDATE COPIAS
    SET ESTADO = CASE
        WHEN INSERTED.F_DEVOL IS NULL THEN 'P'
        ELSE 'D'
    END
    FROM INSERTED
    WHERE COPIAS.NRO_LIBRO = INSERTED.NRO_LIBRO AND COPIAS.NRO_COPIA = INSERTED.NRO_COPIA;

    PRINT 'Préstamo realizado con éxito. Estado de la Copia actualizado';
END;






-- SP para verificar la habilitación de un lector---

CREATE PROCEDURE [dbo].[VerificarLectorHabilitado]
    @NRO_LECTOR int
   
AS
BEGIN
    DECLARE @LectorEstado char(1);

    SELECT @LectorEstado = ESTADO
    FROM LECTOR
    WHERE NRO_LECTOR = @NRO_LECTOR;

    IF @LectorEstado <> 'H'
    BEGIN
        THROW 50000, 'El lector no está habilitado para realizar préstamos.', 1;
    END;

END;




-- SP para verificar la disponibilidad de una copia---

CREATE PROCEDURE [dbo].[VerificarCopiaDisponible]
    @NRO_LIBRO int,
	@NRO_COPIA smallint

AS
BEGIN
    DECLARE @CopiaEstado char(1);
  
    SELECT @CopiaEstado = ESTADO
    FROM COPIAS
    WHERE NRO_LIBRO = @NRO_LIBRO AND NRO_COPIA = @NRO_COPIA;
	PRINT @CopiaEstado

	PRINT @CopiaEstado
    IF @CopiaEstado = 'P'
    BEGIN
        THROW 50000, 'La copia no está disponible para el préstamo.', 1;
    END;
END;


   -- ----trigger que se activará después de que una fila en la tabla `PRESTAMO` haya sido actualizada para reflejar una devolución.
   --Este trigger verificará la columna `F_DEVOL` y, si es distinta de NULL, llamará al procedimiento almacenado `ActualizarEstadoLibro` ---------------------------


CREATE TRIGGER TriggerActualizarEstadoLibro
ON PRESTAMO
AFTER UPDATE
AS
BEGIN
    DECLARE @NRO_LIBRO int;
	DECLARE @NRO_COPIA int;

    IF UPDATE(F_DEVOL)
    BEGIN
        SELECT @NRO_LIBRO = ins.NRO_LIBRO, @NRO_COPIA = ins.NRO_COPIA
        FROM inserted ins
        WHERE ins.F_DEVOL IS NOT NULL;
        
        EXEC ActualizarEstadoCopia @NRO_LIBRO, @NRO_COPIA 
    END
END;




-----------SP `ActualizarEstadoCopia` para modificar el estado del libro en la tabla `COPIA`.-----------------------------------------
-

CREATE PROCEDURE ActualizarEstadoCopia
    @NRO_LIBRO int,
	@NRO_COPIA int
AS
BEGIN
    UPDATE COPIAS
    SET ESTADO = 'D'
    WHERE NRO_LIBRO = @NRO_LIBRO AND NRO_COPIA = @NRO_COPIA;
END;



-- Función para calcular la fecha estimada de devolución
CREATE FUNCTION CalcularFechaEstimadaDevolucion
(
    @FechaPrestamo datetime,
    @DiasPrestamo int
)
RETURNS datetime
AS
BEGIN
    DECLARE @FechaEstimadaDevolucion datetime;

    -- Calcular la fecha estimada de devolución sumando los días al préstamo
    SET @FechaEstimadaDevolucion = DATEADD(DAY, @DiasPrestamo, @FechaPrestamo);

    RETURN @FechaEstimadaDevolucion;
END;


-- Vista para mostrar inconsistencias entre copias y préstamos
CREATE VIEW InconsistenciasCopiasPrestamos
AS
SELECT COPIAS.NRO_LIBRO, COPIAS.NRO_COPIA
FROM COPIAS
LEFT JOIN PRESTAMO ON COPIAS.NRO_LIBRO = PRESTAMO.NRO_LIBRO AND COPIAS.NRO_COPIA = PRESTAMO.NRO_COPIA
WHERE COPIAS.ESTADO IS NULL OR PRESTAMO.NRO_COPIA IS NULL;


-- Transacción de ejemplo
BEGIN TRAN

UPDATE LIBRO
SET PRECIO_ACT = PRECIO_ACT * 1.1  -- Incrementa el precio actual de los libros en un 10%

-- Verifica si hubo algún error durante la actualización
IF @@ERROR = 0
BEGIN
    COMMIT TRAN
END
ELSE
BEGIN
	ROLLBACK TRAN
    RAISERROR('Error durante la actualización de precios.', 16, 1);
END;


