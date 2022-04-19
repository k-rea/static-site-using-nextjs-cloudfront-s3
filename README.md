# Template for static site by cloudfront and S3 bucket

This is a basic template for building a static site using CloudFront and S3 bucket.

---

## Usage
### Environment
```shell
direnv --version
```
2.30.3

```shell
aws --version
```
aws-cli/2.4.23 Python/3.9.10 Darwin/21.1.0 source/x86_64 prompt/off

```shell
tfenv --version
```
tfenv 2.2.3

### Install and setting
#### Install terraform
```shell
tfenv install
teffaform --version
```
Terraform v1.1.8

#### Set environment variables
```shell
echo 'export AWS_PROFILE=xxxxx' >> .envrc
echo 'export TF_VAR_profile=${AWS_PROFILE}' >> .envrc

direnv allow
```


### Create S3 bucket and cloudfront

```shell
cd tf
tf init
tf apply
```

Check if the S3 bucket created using Terraform exists.
```shell
aws s3 ls
```

### Set bucket name and cloudfront domain
```shell
cd ../
echo 'export BUCKET_NAME=xxx' > .envrc
echo 'export DOMAIN_NAME=xxx' > .envrc
direnv allow
```

### Upload index.html to S3 bucket.
```shell
aws s3 cp index.html s3://${BUCKET_NAME}
```

### Check Website
```shell
http https://${DOMAIN_NAME}
```
---
## Clean up website
### Terraform destroy
Empty the S3 bucket before destroying the environment.
```shell
aws s3 rm s3://${BUCKET_NAME}/index.html
```

```shell
tf destroy
```