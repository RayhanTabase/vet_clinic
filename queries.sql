SELECT * FROM animals WHERE name LIKE '%mon'; -- Find all animals whose name ends in "mon".
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-01-01'; -- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE neutered = '1' AND escape_attempts < 3; -- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'; -- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT name, escape_attempts FROM animals WHERE weight_in_kg > 10.56; -- List name and escape attempts of animals that weigh more than 10.5kg
SELECT * FROM animals WHERE neutered = '1'; -- Find all animals that are neutered.
SELECT * FROM animals WHERE NOT name = 'Gabumon'; -- Find all animals not named Gabumon.
SELECT * FROM animals WHERE weight_in_kg >= 10.4 AND weight_in_kg <= 17.3; -- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)