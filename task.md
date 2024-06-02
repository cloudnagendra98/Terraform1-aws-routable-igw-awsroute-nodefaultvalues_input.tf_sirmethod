* web
    * ingress
        * http (80): allow to all
        * ssh (22) : allow to all
* app
    * ingress
        * ssh (22) : allow to all
        * http (8080) : allow within the vpc range 
*  db
    * ingress 
        * tcp (3306) : allow within the vpc range 

Remove default values from inputs.tf as any new user must enter the attributes when using dev.tfvars file default values...so we remove default values from inputs.tf 

This is our task now in this section: we done above things in previous tasks now we are going to fetch routable using some scripting and then creating internetgate way and then will attach routetable with internetgateway using aws_route

In aws to make network work 
   * we need to create an internet gateway and attach to vpc 
   * we need to add route to the default route table to internet gateway

(Datasources:
 Datasources in terraform allows us to fetch information from provider. They are not used to create resources. They are used to fetch information. They are like select query; getting information.

 Resources will create something . Datasources will not create anything, they will try to figure out or pull the information.)

* Lets use datasource of route table to figure out the default route table id

*Outputs: They print or expose the information/ detail