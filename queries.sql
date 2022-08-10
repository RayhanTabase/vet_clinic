SELECT * FROM animals WHERE name LIKE '%mon'; -- Find all animals whose name ends in "mon".
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth < '2019-01-01'; -- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3; -- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu'; -- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT name, escape_attempts FROM animals WHERE weight_in_kg > 10.5; -- List name and escape attempts of animals that weigh more than 10.5kg
SELECT * FROM animals WHERE neutered = TRUE; -- Find all animals that are neutered.
SELECT * FROM animals WHERE NOT name = 'Gabumon'; -- Find all animals not named Gabumon.
SELECT * FROM animals WHERE weight_in_kg >= 10.4 AND weight_in_kg <= 17.3; -- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT COUNT(*) AS totalAnimals FROM animals; -- How many animals are there?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0; -- How many animals have never tried to escape?
SELECT AVG(weight_in_kg) FROM animals; -- What is the average weight of animals?

SELECT
CASE WHEN neutered = TRUE THEN 'neutered' ELSE 'not neutered' END AS is_neutered
FROM 
( 
  SELECT neutered , SUM(escape_attempts) as total
  FROM animals 
  GROUP BY neutered 
  ORDER BY total DESC
) AS animals
LIMIT 1; -- Who escapes the most, neutered or not neutered animals?

SELECT species, Min(weight_in_kg) AS min_weight, Max(weight_in_kg) AS max_weight FROM animals GROUP BY species; -- What is the minimum and maximum weight of each type of animal?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

-- What animals belong to Melody Pond?
SELECT animals.name
FROM animals
INNER JOIN owners ON animalS.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name
FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id
ORDER BY owners.full_name;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name)
FROM animals
INNER JOIN species ON animals.species_id = species.id
GROUP BY species.id;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM
  (
  SELECT animals.owner_id, animals.name
  FROM animals
  INNER JOIN species ON animals.species_id = species.id
  WHERE species.name = 'Digimon'
  ) as animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name 
FROM animals
INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name
FROM 
( 
  SELECT  owners.full_name, COUNT(owners.id) as total
  FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
  GROUP BY owners.id
  ORDER BY total DESC
) AS owners
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name)
FROM
(
SELECT animals.name FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' 
GROUP BY animals.id
) AS animals;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet, species.name AS specialty FROM specializations 
RIGHT JOIN vets ON specializations.vet_id = vets.id 
JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name FROM 
(
  SELECT animals.name,COUNT(animals.id) AS total_visits FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.id
ORDER BY total_visits DESC
) AS animals
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM 
(
SELECT animals.name, date_of_visit FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit
) AS animals
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, vets.*, date_of_visit
FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
ORDER BY date_of_visit DESC 
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(animals)
FROM
(
SELECT animals.name AS animals, animals.species_id, vets.name AS vet, species.id AS specialty, date_of_visit
FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN specializations ON vets.id = specializations.vet_id
INNER JOIN species ON specializations.species_id = species.id
WHERE animals.species_id <> species.id
) AS animals;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name
FROM
(
SELECT species.name, COUNT(species.name) total_visits FROM visits 
INNER JOIN vets ON visits.vet_id = vets.id 
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY total_visits DESC
) AS species
LIMIT 1;

-- EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
-- EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
-- EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';


-- stored procedure to return animals with escape attempts greater than 3
create or replace FUNCTION high()
  returns TABLE (name varchar , escape_attempts int) 
AS
$func$
  SELECT name, escape_attempts
  FROM animals where escape_attempts > 3;
$func$ 
LANGUAGE sql;