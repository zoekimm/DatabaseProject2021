DELIMITER //
DROP PROCEDURE IF EXISTS NumberofFlights //

CREATE PROCEDURE NumberofFlights(IN countryNameInput VARCHAR(30))
BEGIN
    SELECT COUNT(originCode) as 'Count'
    FROM Route
    WHERE originCode IN (SELECT airportCode
                    FROM Airport
                    WHERE countryName = countryNameInput) AND destinationCode IN (SELECT airportCode
                    FROM Airport
                    WHERE countryName = countryNameInput);
END; //

DELIMITER ;
