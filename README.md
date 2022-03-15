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
<code>$sudo apt install software-properties-common </code></br>
<code>$sudo add-apt-repository --yes --update ppa:ansible/ansible </code></br>
<code>$sudo apt install ansible</code></code></br>
<a href="https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu">Ansible-Ubuntu Documentation</a>
<br>
<br>

<a href="https://github.com/mikechngwk/CICD/blob/second-jenkins/README.md">Return to Jenkins</a>



