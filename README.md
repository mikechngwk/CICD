<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158134282-f1ff806c-318e-4221-afb0-7cb3849169cc.png" />
</p>

## EC2's Security Group : 
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





