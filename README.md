## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://github.com/ThePallas/ELk_Stack_Project/tree/main/Diagrams/Cloud_Project_Diagram.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select playbook files may be used to install only certain pieces of it, such as Filebeat.
All .yml files are stored in the https://github.com/ThePallas/ELk_Stack_Project/tree/main/Ansible directory on the repository.

-install-elk.yml sets up the ELK server
-filebeat-config.yml is the configuration file for filebeat-playbook.yml.
-filebeat-playbook.yml is the playbook that installs and launches filebeat on the web servers.
-metricbeat-config.yml is the configuration file for the metricbeat-playbook.yml.
-metricbeat-playbook.yml is the ansible playbook that installs and launches metricbeat on the web servers.


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available in addition to restricting access to the network.
-Load balancing provides a layer of security against DDoS attacks because it distributes the traffic across the backend servers.
-The Jump box is used as a gateway and it is a single secure node where the network can be configured without prematurely exposing changes to users or disrupting the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- Filebeat monitors the log files or other items specified, collects the events from the logs and forwards them to Elasticsearch or Logstash for indexing.
- Metricbeat periodically collects metric data from the targeted servers and forwards it to elasticsearch and/or logstash.
The configuration details of each machine may be found below.

| Name               | Function    |IP Address |Operating System|
|--------------------|------------|------------|----------------|
| JumpBoxProvisioner | Gateway    | 10.0.0.4   | Linux          |
| Web-1              | DVWA Server| 10.0.0.5   | Linux          |
| Web-2              | DVWA Server| 10.0.0.6   | Linux          |
| Web-3              | DVWA Server| 10.0.0.7   | Linux          |
| RedELK             | ELK Server | 10.1.0.4   | Linux          |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Gateway machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 15.181.177.143          

Machines within the network can only be accessed by My workstation.
- 15.181.177.143 *Note my workstation IP address is dynamic via VPN, therefore the inbound rule has to be periodically updated.  

A summary of the access policies in place can be found in the table below. Web-1, Web-2 & Web-3 are part of a backend pool and are accessible via the Load Balancer.

| Name               | Publicly  Accessible | Allowed IP  Addresses   |
|--------------------|----------------------|-------------------------|
| JumpBoxProvisioner | Yes                  | 15.181.177.143          |
| RedELK             | Yes                  | 15.181.177.143 10.0.0.4 |
| Web-1              | No                   | 10.0.0.4                |
| Web-2              | No                   | 10.0.0.4                |
| Web-3              | No                   | 10.0.0.4                |
| RedTeamLB          | Yes                  | 15.181.177.143          |
|                    |                      |                         |




### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- automating with ansible allows quick deployment to all servers at once.  
-It helps maintain consistency and can reduce replication errors.

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- Install Docker
- Install python
- install Docker module
- Increase memory
- Enable Docker service start on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

The screenshot is located in https://github.com/ThePallas/ELk_Stack_Project/tree/main/Images/DockerPS.png on this repository.

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5 (Web-1)
- 10.0.0.6 (Web-2)
- 10.0.0.7 (Web-3)

We have installed the following Beats on these machines:
-Filebeat
-Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects log events from the /var/log/*.log files on each of the monitored machines. It reads the designated logs then aggregates them to be presented in kibana.  In this deployment the system module is enabled.
- Metricbeat uses modules to collect infrastructure metrics from the designated services.  In this deployment the docker and system modules are enabled.


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk.yml file to the ansible directory.
- Update the hosts file to include the [elk] section and the IP address for the elk host machine.
- Run the playbook, and navigate to kibana to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? install-elk.yml is the playbook for the installation.Where do you copy it? I copied to the ansible container.
- _Which file do you update to make Ansible run the playbook on a specific machine? Updated the hosts.yml file to specify where the playbook should run  the [elk] tag identifies the elk server and the [webservers] section indicates which machines will be monitored.  How do I specify which machine to install the ELK server on versus which to install Filebeat on?_[elk] section specifies the ELK server address and the [webservers] section specifies the targets (machines to be monitored]
- _Which URL do you navigate to in order to check that the ELK server is running? http://[ELK VM public IP]:5601.  For this deployment the url is http://52.238.25.203:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

Prerequisites
VMs are created with NSGs and appropriate inbound / outbound rules.
Workstation IP is allowed to connect to jumpbox.
Docker and Ansible are installed on jumpbox provisioner.
VMs are started in Azure.

1. Launch Linux terminal.
2. Connect to the jump box from an allowed workstation with an allowed userID via ssh.  ssh <admin username>@<jumpbox ipaddr>
3.  If you know the container name, skip to the next step, else get the docker container name that has ansible installed with sudo docker container list -a.  Note the container name.
4.  Start the docker container with sudo docker start <docker container name>
5.  Attach the docker container with sudo docker attach <docker container name>.  You will know the container is running because the prompt will change to the container prompt.
6.  From the docker container that already has Ansible configured, update the ansibile host file to include the ip for the ELK server in an [elk] group.
7.  create an elk install playbook.  See https://github.com/ThePallas/ELk_Stack_Project/tree/main/Ansible/install-elk.yml file on this repository.
8.  Run the elk install playbook.  ansible-playbook <elk install playbook name>
9.  Once the container is running, use a browser to navigate to http://<ELK server external IP address>:5601/app/kibana , if the web page displays, the configuration is correct.
10.  Add Filebeat and Metricbeat. 
For Filebeat
Prerequisites
All VMs are set up and configured
Workstation can connect to jumpbox.
Docker and Ansible are installed on jumpbox provisioner.
VMs are started in Azure.
Kibana is successfully set up on ELK server.

1.  Go to the Add Log Data page of the ELK server.  
2.  Choose system logs, then DEB tab.  The instructions for installing filebeat are displayed on the page.
3.  From the terminal window, use curl to pull down the filebeat config file.  *our class used curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml
4. update the hosts ip with the ip address of the ELK server in the output.elasticsearch section and the setup.kibana section in the filebeat-config.yml file and save the changes.
5. create a filebeat-playbook file using the information listed on the DEB tab.  See the ELk_Stack_Project/Ansible/filebeat-playbook.yml on this repository.
6. Run the playbook. ansible-playbook <playbook name>
7. check the data is being retrieved by clicking the check data button on the kibana DEB tab.  Expect message indicating the data is successfully retrieved.  
8.  once the data retrieval has been confirmed, click the System Logs Dashboard button to view the data visualizations.

For Metricbeat
Prerequisites
All VMs are set up and configured
Workstation can connect to jumpbox.
Docker and Ansible are installed on jumpbox provisioner.
VMs are started in Azure.
Kibana is successfully set up on ELK server.

1.  Go to the Add Docker Metrics page of the ELK server.  
2.  Choose system logs, then DEB tab.  The instructions for installing filebeat are displayed on the page.
3.  From the terminal window, use curl to pull down the metricbeat config file.  *our class used curl https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat/Filebeat > /etc/ansible/metricbeat-config.yml
4. update the hosts ip with the ip address of the ELK server in the output.elasticsearch section and the setup.kibana section in the metricbeat-config.yml file and save the changes.
5. create a metricbeat-playbook file using the information listed on the DEB tab.  See the ELk_Stack_Project/Ansible/metricbeat-playbook.yml on this repository.
6. Run the playbook. ansible-playbook <playbook name>
7. check the data is being retrieved by clicking the check data button on the kibana DEB tab.  Expect message indicating the data is successfully retrieved.  
8.  once the data retrieval has been confirmed, click the Docker Metrics Dashboard button to view the data visualizations.

