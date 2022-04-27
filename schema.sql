CREATE DATABASE vet_clinic;
\c vet_clinic;
CREATE TABLE animals (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200) NOT NULL,
  date_of_birth DATE NOT NULL, 
  escape_attempts INT NOT NULL, 
  neutered BOOLEAN NOT NULL,
  weight_in_kg FLOAT NOT NULL
);

ALTER TABLE animals
ADD species varchar(200);

-- Create a table named owners with the following columns
CREATE TABLE owners (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(500) NOT NULL,
  age INT NOT NULL
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
