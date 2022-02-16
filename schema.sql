CREATE DATABASE vet_clinic;
\c vet_clinic;
CREATE TABLE animals (
  id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200) NOT NULL,
  date_of_birth DATE NOT NULL, 
  escape_attempts INT NOT NULL, 
  neutered BIT NOT NULL,
  weight_in_kg FLOAT NOT NULL
);


