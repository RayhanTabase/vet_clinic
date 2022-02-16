INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_in_kg) 
VALUES 
(
  'Agumon',
  '2020-02-03',
  0,
  FALSE,
  10.23
),
(
  'Gabumon',
  '2018-11-15',
  2,
  TRUE,
  8
),
(
  'Pikachu',
  '2021-01-07',
  1,
  FALSE,
  15.04
),
(
  'Devimon',
  '2017-05-12',
  5,
  TRUE,
  11
);


INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_in_kg) 
VALUES 
(
  'Charmander',
  '2020-02-08',
  0,
  FALSE,
  -11
),
(
  'Plantmon',
  '2022-11-15',
  2,
  TRUE,
  -5.7
),
(
  'Squirtle',
  '1993-02-04',
  3,
  FALSE,
  -12.13
),
(
  'Angemon',
  '2005-06-12',
  1,
  TRUE,
  -45
),
(
  'Boarmon',
  '2005-06-07',
  7,
  TRUE,
  20.4
),
(
  'Blossom',
  '1998-10-13',
  3,
  TRUE,
  17
),
(
  'Boarmon',
  '2005-06-07',
  5,
  TRUE,
  20.4
);

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepointdob;
UPDATE animals SET weight_in_kg = weight_in_kg * -1;
ROLLBACK TO SAVEPOINT savepointdob;
UPDATE animals SET weight_in_kg = weight_in_kg * -1 WHERE weight_in_kg < 0;
COMMIT;
