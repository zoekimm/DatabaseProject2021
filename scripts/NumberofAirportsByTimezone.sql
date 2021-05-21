DELIMITER //
DROP PROCEDURE IF EXISTS NumberofAirportsByTimezone//

CREATE PROCEDURE Query2_NumberofAirportsByTimezone(IN timezoneInput VARCHAR(10))
BEGIN
    SELECT airportName
    FROM Airport
    WHERE timezone = timezoneInput;
END; //

DELIMITER ;
