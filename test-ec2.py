import boto3

## set up connection to EC2
ec2 = boto3.resource('ec2')

## grab all instances with state 'running'
instances = ec2.instances.filter(
    Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

## print the instance id, instance type, KeyName and Name of all matching instances
for instance in instances:
    ami = ec2.Image(instance.image_id)
    print("Instance ID/Image: " + instance.id + "||" + ami.name + " (" + str(ami.description) + ")", 
    "State: " + instance.state['Name'],
    "Instance type: " + instance.instance_type, 
    instance.key_name, 
    instance.tags[0]['Value'] )

# Some testing with S3
s3 = boto3.resource('s3')
print("Checking S3 Bucket....")
for obj in s3.Bucket(name='rickstuff').objects.all():
    print(obj.key)