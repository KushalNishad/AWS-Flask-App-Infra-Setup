/* Notes on AWS credentials:
  - This path is created when you run 'aws configure' to set up AWS CLI access.
  - Ensure you have added your AWS access key and secret key to the credentials file.
  - Never commit your actual AWS credentials to version control.
  - Consider using environment variables or AWS profiles for enhanced security.
*/
# Path to the AWS credentials file

provider "aws" {
  region = "us-east-2"
}