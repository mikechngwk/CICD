<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158131614-172887e7-86dd-4758-9c9c-f385b24f5d84.png" />
</p>

## Description : 
Ansible will be installed in Jenkins Server and be used to set up our UAT & Prod servers. 

## Playbooks:
1. site.yml : Calls tomcat_setup.yml & cicd-app-setup.yml
2. tomcat_setup.yml : Setup tomcat service
3. cicd-app-setup.yml : Download artifacts from Nexus repo and deploy to tomcat server with a rollback feature.

## Playbook: tomcat_setup.yml
From our AWS EC2 instance, our cicd-staging-uat-server is in Ubuntu 18.0 OS. <br>
As such, the tomcat_setup will download all the dependencies like JDK & setup tomcat SVC file from <code>template/ubuntu18-svcfile.j2</code> <br>
tomcat SVC file is to enable Linux's systemctl commands in starting the tomcat service.

## Playbook: cicd-app-setup.yml
cicd-app-setup.yml will be used to: <br>
1. Download latest cicd_artifact.war from Nexus's CICD-Maven-RELEASE repository.
2. Archive by collecting details of existing artifact (for rollback purposes) - <code>archive_stat</code>
3. Rollback feature
4. Deploy artifact into cicd-prod-server

## Setting up Ansible in Jenkins server
1. Connect into Jenkins Server using SSH.
2. Install Ansible on Jenkins  
<code>$sudo apt update</code><br>
<code>$sudo apt install software-properties-common</code></br>
<code>$ sudo apt install software-properties-common </code></br>
<code>$ sudo add-apt-repository --yes --update ppa:ansible/ansible </code></br>
<code>$ sudo apt install ansible</code></code></br>



<p align="center">
  <ins>SG: CICD-Jenkins-SG</ins><br>
</p>
Inbound rule1: 
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: MyIP</li>
<li>Description: For our local machine to connect to Jenkins through SSH port 22.</li>
</ul>
Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: MyIP</li>
<li>Port Range: 8080</li>
<li>Description: Jenkins run on port 8080</li>
</ul>
Inbound rule3:(To be added after sonarqube-security-group is created)
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source Type: Custom</li>
<li>Source: (Sonarqube SecurityGroup)</li>
<li>Description: Allow sonarqube to access Jenkins to extract code-analysis for sonarqube to generatea reports for quality gates.</li>
</ul>
Inbound rule4:(To be added after jenkins-security-group is created)
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: Custom</li>
<li>Source: Jenkins Security Group</li>
<li>Description: Allow ansible running in Jenkins to connect to this node using SSH port 22</li>
</ul>
Inbound rule5:(To be added after windows-security-group is created)
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source Type: Custom</li>
<li>Source: Windows-SG</li>
<li>Description: Allow windows server/slave to connect jenkins/master</li>
</ul>


<p align="center">
  <ins>SG: CICD-Nexus-SG</ins><br>
</p>
Inbound rule1:(To be added after jenkins-security-group is created)
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: Custom</li>
  <li>Port range: 8081</li>
<li>Source: Jenkins Security Group</li>
<li>Description: Allow Jenkins to upload artifact to nexus server</li>
</ul>

Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: Custom</li>
  <li>Port range: 22</li>
<li>Source: MyIP</li>
<li>Description: Allow local machine to connect to Nexus through SSH</li>
</ul>

Inbound rule3:(To be added after app-server-security-group is created)
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: Custom</li>
  <li>Port range: 8081</li>
<li>Source: app-server-security-group</li>
<li>Description: Allows app server(tomcat) to download artifact</li>
</ul>

Inbound rule4:
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: MyIP</li>
  <li>Port range: 8081</li>
<li>Source: MyIP</li>
<li>Description: Nexus port = 8081</li>
</ul>

<p align="center">
  <ins>SG: CICD-Sonar-SG</ins><br>
</p>
Inbound rule1:
<ul style=“list-style-type:square”>
<li>Type: HTTP</li>
<li>Source Type: All-IpV4</li>
  <li>Port range: 80</li>
<li>Source: 0.0.0.0/0</li>
<li>Description: To allow ngix to forward request to sonarqube server</li>
</ul>

Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source Type: All-IpV4</li>
  <li>Port range: All</li>
<li>Source: Jenkins-Security-Group</li>
<li>Description: Allow Jenkins to upload report to sonarqube server</li>
</ul>

<p align="center">
  <ins>SG: CICD-WindowsServer-SG</ins><br>
</p>
Inbound rule1:
<ul style=“list-style-type:square”>
<li>Type: RDP</li>
<li>Source Type: MyIP</li>
  <li>Port range: 3389</li>
<li>Description: To allow our local machine to connect to windows server through RDP</li>
</ul>

Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source type: Custom</li>
  <li>Port range: All</li>
  <li>Source: Jenkins-security-group</li>
<li>Description: Allow Jenkins to connect this node for software testing(selenium)</li>
</ul>

<p align="center">
  <ins>SG: CICD-Backend-staging-sg</ins><br>
</p>
Inbound rule1:
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: MyIP</li>
  <li>Port range: 22</li>
  <li>Source: MyIP</li>
<li>Description: Login to this instance from local machine through SSH</li>
</ul>

Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source Type: Custom</li>
  <li>Port range: All</li>
  <li>Source: app-staging-security-group</li>
<li>Description:Allows tomcat to connect this node on all ports</li>
</ul>

<p align="center">
  <ins>SG: CICD-app-staging-sg</ins><br>
</p>
Inbound rule1:
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: MyIP</li>
  <li>Port range: 22</li>
  <li>Source: MyIP</li>
<li>Description: To connect from SSH from local machine</li>
</ul>

Inbound rule2:
<ul style=“list-style-type:square”>
<li>Type: All traffic</li>
<li>Source Type: Custom</li>
  <li>Port range: All</li>
  <li>Source: 0.0.0.0/0</li>
</ul>

Inbound rule3:
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: Custom</li>
  <li>Port range: 8080</li>
  <li>Source: Windows-server-security-group</li>
<li>Description: Allow windows to connect using private IP</li>
</ul>

Inbound rule4:
<ul style=“list-style-type:square”>
<li>Type: SSH</li>
<li>Source Type: Custom</li>
  <li>Port range: 22</li>
  <li>Source: Jenkins-Server-Security-Group</li>
<li>Description: Allow Ansible running in Jenkins to connect to this node</li>
</ul>

Inbound rule5:
<ul style=“list-style-type:square”>
<li>Type: Custom TCP</li>
<li>Source Type: Custom</li>
  <li>Port range: 8080</li>
  <li>Source: 0.0.0.0/0</li>
<li>Description: To be able to access the tomcat server webpage</li>
</ul>

## EC2 Instances :
<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158169098-d1ed585a-58bc-4a48-9a35-b1d29521673d.png" />
</p>

We will setup EC2 instances for all of our servers.
Most of the EC2 instances will be setup as Platform As Code (PAC). Refer to <code> <b>userdata</b></code>for the bash scripts for each individual servers.

<p align="center">
  <ins>CICD-SonarQube-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: Ubuntu 18.0</li>
<li>Tier: t2.medium</li>
  <li>PaC: userdata/sonar-setup.sh</li>
  <li>Security-Group: CICD-Sonar-SG </li>
</ul>

<p align="center">
  <ins>CICD-Nexus-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: CentOS 7.0</li>
<li>Tier: t2.medium</li>
  <li>PaC: userdata/nexus-setup.sh</li>
  <li>Security-Group: CICD-Nexus-SG </li>
</ul>

<p align="center">
  <ins>CICD-Jenkins-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: Ubuntu 18.0</li>
<li>Tier: t2.small</li>
  <li>PaC: userdata/jenkins-setup.sh</li>
  <li>Security-Group: CICD-Jenkins-SG </li>
</ul>

<p align="center">
  <ins>CICD-app01-staging-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: Ubuntu 18.0</li>
<li>Tier: t2.small</li>
  <li>Security-Group: CICD-app-staging-sg</li>
</ul>

<p align="center">
  <ins>CICD-be01-staging-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: CentOS 7.0</li>
<li>Tier: t2.micro</li>
  <li>PaC: <code>backend-stack.sh</code></li>
  <li>Security-Group: CICD-Backend-staging-sg</li>
</ul>

<p align="center">
  <ins>CICD-WindowsServer-Server</ins><br>
</p>
<ul style=“list-style-type:square”>
<li>AMI: Windows_Server-2019-English-Full-Base-2022.03.09</li>
<li>Tier: t2.small</li>
  <li>Security-Group: CICD-WindowsServer-SG</li>
</ul>





