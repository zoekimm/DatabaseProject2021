-- cleanup.sql
-- drop all tables

SET foreign_key_checks = 0;

-- drop if already there to avoid conflicts/errors
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Country;

SET foreign_key_checks = 1;
