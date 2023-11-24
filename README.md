# Proof of concept elt pipeline using dbt and postgreSQL

To run:

- fix mount points in dbt.sh
- create_docker_images.sh
- run ./database_start.sh in a separate terminal to start the database (always clean no persistent storage)
- run ./python_start.sh (load data into the database, data is included into the docker image)
- run ./dbt.sh (magic :D)
- run database_bash.sh, use the provided command to connect the the database using psql
- execute BI-server queries to answer the questions

# Definitions 
Term        | Definition
-----------:| ----------------------------------------------------------:|
t           | Loans are repaid in terms, this is the number of the term.
installment | Amount that’s paid in that month.
principal   | Amount that’s repaid of the loan in that month.
interest    | Amount that’s paid as interest on the loan in that month.
outstanding | Amount that’s still remaining to be paid on a loan. 