Echo Service App Project:

1. App Usage:
   
        - The app is an api that returns the body request sent plus the server public IP, and write in to a logfile.
            ~$ curl https://public-ip-of-the-deployed-server:5000/body-request-api
        - You can use curl, postman, or also a web page in order to send the API request.
        - The app listens on port 5000 by default, it is dockerized/containerized and pushed to dockerhub.
            Image Name : samer1984/echo-service
        - To deploy the app on to a docker infra server, please run the following command :
            NOTE: The command exposes port 5000 (beware if this port is in user).
                  The /var/log directory is an example, please modify this as per your needs.
            ~$ docker run -d --name=echo-service -p 5000:5000 -v /var/log:/app/log samer1984/echo-service:latest
    
2. Building the app:
   
        - To build the app please refer to Dockerfile in order to build :
            ~$ docker build -t echo-service:latest .

3. Deploy the app on aws, please refer to directory terraform-IaC
    
        - The terraform Code applies the echo-service-app into an EC2 instance.
        - For Hardware redundancy I have added a placement group type spread in order to split the EC2 instances
            into different hardware within the same AZ.
        - For Load and redundancy I have added an autoscaling group with a launch template with a maximum of 3 instances.
        - The monitoring is enabled by default for all instances within the cloudwatch, you can check the cloudwatch 
            cpu utilization with p99 latency for response time of the api. 
            NOTE: please refer to the monitoring-requests pics for illustration.
        - In terms of security it uses the default vpc with an inbound rule for opening port 5000 to public.
        - There is a bug when trying to destroy the 7 components of the terraform which stays about cannot deleting
            placement group since it is already in use with the below error :
   
            "Error: InvalidPlacementGroup.InUse: The placement group 'echo_service_app_pg' is in use and may not be deleted."

            NOTE: This error happens when terraform tries to delete the placement group while the EC2 instance 
                    are not being fully terminated, so please wait couple of minutes then reapply again the terraform destroy.