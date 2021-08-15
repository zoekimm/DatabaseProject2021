-- CountryByGDP.sql
-- receives an integer as input
-- prints input number of countries in descending order of GDP

DELIMITER //
DROP PROCEDURE IF EXISTS CountryByGDP //

CREATE PROCEDURE CountryByGDP(IN countryNameInput varchar(30))
BEGIN
    SELECT GDP
    FROM Country
    WHERE countryName = countryNameInput;
END; //

DELIMITER ;
