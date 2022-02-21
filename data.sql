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
);

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepointdob;
UPDATE animals SET weight_in_kg = weight_in_kg * -1;
ROLLBACK TO savepointdob;
UPDATE animals SET weight_in_kg = weight_in_kg * -1 WHERE weight_in_kg < 0;
COMMIT;

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_in_kg) 
VALUES 
(
  'Plantmon',
  '2022-11-15',
  2,
  TRUE,
  -5.7
);

-- Insert the following data into the owners table
INSERT INTO owners (full_name,age) 
VALUES 
(
  'Sam Smith',
  34
),
(
  'Jennifer Orwell',
  19
),
(
  'Bob',
  45
),
(
  'Melody Pond',
  77
),
(
  'Dean Winchester',
  14
),
(
  'Jodie Whittaker',
  38
);

-- Insert the following data into the species table
INSERT INTO species (name)
VALUES (
  'Pokemon'
),
(
  'Digimon'
);

-- Modify your inserted animals so it includes the species_id value
BEGIN;
UPDATE animals SET species_id = 
(
  SELECT id FROM species WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals SET species_id = 
(
  SELECT id FROM species WHERE name = 'Pokemon'
)
WHERE species_id IS NULL;
COMMIT;

-- Modify your inserted animals to include owner information (owner_id)
BEGIN;
UPDATE animals SET owner_id = 
(
  SELECT id FROM owners WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';
COMMIT;

BEGIN;
UPDATE animals SET owner_id = 
(
  SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
)
WHERE name = 'Gabumon' OR name = 'Pikachu';
COMMIT;

BEGIN;
UPDATE animals SET owner_id = 
(
  SELECT id FROM owners WHERE full_name = 'Bob'
)
WHERE name = 'Devimon' OR name = 'Plantmon';
COMMIT;

BEGIN;
UPDATE animals SET owner_id = 
(
  SELECT id FROM owners WHERE full_name = 'Melody Pond'
)
WHERE 
name = 'Charmander'
OR name = 'Squirtle'
OR name = 'Blossom';
COMMIT;

BEGIN;
UPDATE animals SET owner_id = 
(
  SELECT id FROM owners WHERE full_name = 'Dean Winchester'
)
WHERE name = 'Angemon' OR name = 'Boarmon';
COMMIT;

-- Insert the following data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES 
(
  'William Tatcher',
  45,
  '2000-04-23'
),
(
  'Maisy Smith',
  26,
  '2019-01-17'
),
(
  'Stephanie Mendez',
  64,
  '1981-05-04'
),
(
  'Jack Harkness',
  38,
  '2008-06-08'
);

-- Insert the following data for specialties
INSERT INTO specializations (vet_id, species_id)
VALUES
(
  (
    SELECT id FROM vets
    WHERE vets.name = 'William Tatcher'
  ),
  (
    SELECT id FROM species
    WHERE species.name = 'Pokemon'
  )
),
(
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  (
    SELECT id FROM species
    WHERE species.name = 'Pokemon'
  )
),
(
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  (
    SELECT id FROM species
    WHERE species.name = 'Digimon'
  )
),
(
  (
    SELECT id FROM vets
    WHERE vets.name = 'Jack Harkness' 
  ),
  (
    SELECT id FROM species
    WHERE species.name = 'Digimon'
  )
);

-- Insert the following data for visits
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Agumon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'William Tatcher'
  ),
  '2020-05-24'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Agumon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  '2020-07-22'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Gabumon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Jack Harkness'
  ),
  '2021-02-02'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Pikachu' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2021-01-05'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Pikachu' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2020-03-08'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Pikachu' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2021-05-14'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Devimon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  '2021-05-04'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Charmander' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Jack Harkness'
  ),
  '2021-02-24'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Plantmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2019-12-21'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Plantmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'William Tatcher'
  ),
  '2020-08-10'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Plantmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2021-04-07'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Squirtle' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  '2019-09-29'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Angemon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Jack Harkness'
  ),
  '2020-10-03'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Angemon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Jack Harkness'
  ),
  '2020-11-04'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Boarmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2019-01-24'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Boarmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2019-05-15'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Boarmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2020-02-27'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Boarmon' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Maisy Smith'
  ),
  '2020-08-03'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Blossom' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'Stephanie Mendez'
  ),
  '2020-05-24'
),
(
  (
    SELECT id FROM animals
    WHERE animals.name = 'Blossom' 
  ),
  (
    SELECT id FROM vets
    WHERE vets.name = 'William Tatcher'
  ),
  '2021-01-11'
);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
