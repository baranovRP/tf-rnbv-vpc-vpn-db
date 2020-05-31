# tf-rnbv-vpc-vpn-db 

Infrastructure splitted on three separated states:
* VPC (network)
* RDS (database)
* VPN (managment)

RDS and VPN depended from VPC

Prerequisite:
s3 bucket and dynamodb table

How to run, order of initialization:
1. Init and setup VPC
```shell script
$ cd live/stage/network/vpc 
$ terraform init
$ terraform plan
$ terraform apply
```
2 *. Init and setup db
```shell script
$ cd live/stage/rds
$ terraform init
$ terraform plan
$ terraform apply
```
3 * . Init and setup db
```shell script
$ cd mgmt/vpn
$ terraform init
$ terraform plan
$ terraform apply
```
