sudo docker run --name elt-poc-dbt -it --rm \
--mount type=bind,source=/home/bartjan/elt-pipline-equip-leasing/dbt/dbt_project,target=/usr/app \
--mount type=bind,source=/home/bartjan/elt-pipline-equip-leasing/dbt,target=/root/.dbt/ \
ghcr.io/dbt-labs/dbt-postgres:1.4.1 \
run