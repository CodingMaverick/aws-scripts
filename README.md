# aws-scripts
Useful scripts for AWS stuff:

**trusted-avisor.py** Displays all available checks, including its state (color-coded, by the way). Remember you need Business or Enterprise Support to get the full stack of checks.

**test-ec2.py** Simple EC2 test to display information about your running instances.

**sts-get-session.sh** 

Helper to get an sts token using your MFA. Yes, it has very limited error handling, feel free to contribute! During a successful execution, it will create 3 files:
* sts_token.json: The raw JSON output of the `aws sts get-session-token` command. This is a temporary file and gets deleted during the execution
* sts_set_variables.sh: Just run `source ./sts_set_variables.sh` to set the environment variables
* sts_unset_variables.sh: Just run `source ./sts_unset_variables.sh` to unset the environment variables

The above files can (and should) be removed after execution.
