CREATE DATABASE vet_clinic;
\c vet_clinic;
CREATE TABLE animals (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200) NOT NULL,
  date_of_birth DATE , 
  escape_attempts INT , 
  neutered BOOLEAN ,
  weight_in_kg FLOAT
);

ALTER TABLE animals
ADD species varchar(200);

-- Create a table named owners with the following columns
CREATE TABLE owners (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(500) NOT NULL,
  age INT
);

-- Create a table named species with the following columns
CREATE TABLE species (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200) NOT NULL
);

-- Modify animals table
ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT REFERENCES species(id) ON DELETE SET NULL;

ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id) ON DELETE SET NULL;

-- Create a table named vets with the following columns
CREATE TABLE vets (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200) NOT NULL,
  age INT,
  date_of_graduation DATE
);

-- There is a many-to-many relationship between the tables species and vets
CREATE TABLE specializations (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
	vet_id INT NOT NULL,
	species_id INT NOT NULL,
	FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE,
	FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE CASCADE
);

-- There is a many-to-many relationship between the tables animals and vets
CREATE TABLE visits (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
	animal_id INT NOT NULL,
	vet_id INT NOT NULL,
  date_of_visit DATE,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE CASCADE,
	FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE CASCADE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);