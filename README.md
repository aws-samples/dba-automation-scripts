# Code samples
## Part 2 - Role of the DBA when moving to RDS: Automation
An important aspect of being an effective DBA when your business is running at top speed is leveraging code and automation whenever you can. 
Use the examples in this blog to help jumpstart your automation efforts.

## Main Files
Cloud formation template that will create a simple, base SQL Server RDS database open to 0.0.0.0/0.
Strongly advise that you modify the CIDR range for your environment.

    cloudformation-sqlserver-master-database.yaml
    
Cloud formation script to restore your SQL Server snapshot with several CloudWatch alarms enabled.

You can deploy the stack from the AWS console or from the AWS CLI with a parameter file. 
For more information on AWS CLI deployments: http://docs.aws.amazon.com/cli/latest/reference/cloudformation/ 

    cloudformation-restore-sqlserver.yaml

### Bash shell script samples
Bash script demonstrating creation of various AWS/RDS CloudWatch alarms on an existing database.

    create-alerts.sh
    
Bash script demonstrating database creation with the AWS CLI

    create-database-instance.sh
    
Bash script initiating a manual Amazon RDS snapshot

    create-manual-snapshot.sh
    
Bash script removing existing CloudWatch alarms

    delete-alerts.sh
    
Bash script demonstrating how to modify a database instance size, parameter group, and option group. Script assumes that the parameter group and the option group already exist.

    modify-database-instance.sh
    
Bash script to restore a database to a point in time. Check your latest restore time for your instance and update the script accordingly.

    restore-to-pointintime.sh
    
   