cd database
sudo docker remove elt-poc-postgres
sudo docker build . -t elt-poc-postgres

cd ../python
sudo docker remove elt-poc-python
sudo docker build . -t elt-poc-python

cd ..
sudo docker pull ghcr.io/dbt-labs/dbt-postgres:1.4.1