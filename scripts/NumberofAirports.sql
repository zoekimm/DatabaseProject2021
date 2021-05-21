-- receives an integer as input
-- prints given number of countries in a descending order of number of airports 

DELIMITER //
DROP PROCEDURE IF EXISTS NumberofAirports //

CREATE PROCEDURE Query1_NumberofAirports(IN numCountries INTEGER(10))
BEGIN
    SELECT countryName, COUNT(countryName) as numAirports
    FROM Airport
    GROUP BY countryName
	ORDER BY numAirports
	DESC LIMIT numCountries;
END; //

DELIMITER ;
