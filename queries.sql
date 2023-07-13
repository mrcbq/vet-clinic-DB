/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

-- Update the animals table by setting the species column to 'digimon' for animals with a name ending in 'mon'
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the animals table by setting the species column to 'pokemon' for animals without a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
-- Verify the changes persist after commit
SELECT * FROM animals;

-- Delete all records in the animals table inside a transaction
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;
