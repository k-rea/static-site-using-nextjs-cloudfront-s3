# Template for static site by cloudfront and S3 bucket

This is a basic template for building a static site using CloudFront and S3 bucket.

---

## 1. Usage

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
terraform --version
```

Terraform v1.1.8

#### Set environment variables

```shell
echo 'export AWS_PROFILE=xxxxx' >> .envrc
echo 'export TF_VAR_profile=${AWS_PROFILE}' >> .envrc
```

```shell

direnv allow

```

## 2. Create S3 bucket and cloudfront by Terraform

```shell
cd tf
```

```shell
tf init
```

```shell
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

## 3. Set up Next.js

```shell
npx create-next-app@latest ./service --typescript --use-npm
```

```shell
mkdir service/src
cp -f service/pages service/styles service/src
```

Edit service/package.json
```
- "build": "next build", 
+ "build": "next build && next export", 
```

Edit service/src/pages/index.tsx
Remove next/Image import.
Translate Image tag to img tag.

Generate Static site
```shell
cd service
npm run build
```

### Upload outfile to S3 bucket.

```shell
aws s3 cp service/out s3://${BUCKET_NAME} --recursive
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
aws s3 rm s3://${BUCKET_NAME}/ --recursive
```

```shell
tf destroy
```