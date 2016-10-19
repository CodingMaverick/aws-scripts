import boto3

## Colors class from https://svn.blender.org/svnroot/bf-blender/trunk/blender/build_files/scons/tools/bcolors.py
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

## Support API only works from us-east-1, so initializing client with that specific region
client = boto3.client('support', region_name='us-east-1')

## How many checks do we have? What are their names?
response = client.describe_trusted_advisor_checks(
    language='en'
)

number_checks = len(response["checks"])
print("Found " + str(number_checks) + " active checks:")
for i in range(0,number_checks):
    check = response['checks'][i]
    ## Check each check and get its status
    check_result = client.describe_trusted_advisor_check_result(
        checkId=check['id'],
        language='en')
    status = check_result['result']['status']

    ## Use some colors for each status code
    color = bcolors.OKBLUE
    if(status == "ok"):
        color = bcolors.OKGREEN
    elif(status=="warning"):
        color = bcolors.WARNING
    elif(status=="error"):
        color = bcolors.FAIL
    print( color + check['name'] + " (" + status + ")" )
    ##for k,v in response['checks'][i].items():