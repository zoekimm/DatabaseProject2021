-- ActiveFlightPerAirline.sql
-- receives number of airlines 
-- that hold active status 

DELIMITER //
DROP PROCEDURE IF EXISTS activeFlightPerAirline //

CREATE PROCEDURE Query3_activeFlightPerAirline(IN numAirlines INTEGER(10))
BEGIN
    SELECT airlineName
    FROM Airline
	WHERE activeStatus LIKE '%Y%'
	ORDER BY airlineCode
	DESC LIMIT numAirlines;
END; //

DELIMITER ;
