# AWS_N_Tier
Arquitectura y despliegue completo de un N-Tier en VPC con módulos

La estructura de directorios para el proyecto se intenta asemejar a la siguiente:

stage
  └ vpc
  └ services
      └ frontend-app
      └ backend-app
  └ data-storage
      └ mysql
      └ redis
prod
  └ vpc
  └ services
      └ frontend-app
      └ backend-app
  └ data-storage
      └ mysql
      └ redis
mgmt
  └ vpc
  └ services
      └ bastion-host
      └ jenkins
global
  └ iam
  └ s3

STage --> desarrollo
prod --> produccion
mgmt --> meta infraestructura ( bastion, ci/cd, etc. )
global --> buckets y Iams
