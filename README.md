<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158131239-99cc298d-2524-4b86-97a4-f1ddee3ebad0.png" />
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158203676-c32049f9-6005-4186-a2c0-411a5c369b23.png" />
</p>

## Jenkin's Plugins : 
<ul style=“list-style-type:square”>
<li>Slack</li>
<li>Ansible</li>
<li>Nexus Artifact Uploader</li>
  <li>Copy Artifact</li>
  <li>SonarQube Scanner</li>
  <li>Sonar Quality Gates</li>
  <li>SonarQube Scanner</li>
  <li>Zentimestamp</li>
  <li>Violations</li>
  <li>Build Pipeline</li>

## Set up Nexus.
Now, proceed to branch : <a href="https://github.com/mikechngwk/CICD/tree/third-nexus-setup">third-nexus-setup</a>
  
## Set up SonarQube.
Now, proceed to branch : <a href="https://github.com/mikechngwk/CICD/tree/fourth-sonarqube-setup">fourth-sonarqube-setup</a>
 
## Integrate Jenkins with Slack 
Integrate your Jenkins with Slack, you may refer to this <a href="https://www.youtube.com/watch?v=TWwvxn2-J7E&t=19s">Slack-Jenkins-Integration</a>
  
 ## Build jobs in Pipeline
  
<p align="center">
  <ins>1st Job: Build-Artifact</ins><br>
</p>
Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>install -DskipTests</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li>
    </ul><br>

Post-Build Action: Archive the artifacts
<ul style=“list-style-type:square”>
  <li>Files to archive: **/.war</li>
  </ul><br>
  
Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
  </ul><br>

Post-Build Action: Build Other projects
<ul style=“list-style-type:square”>
  <li>Project Name: Test</li>
  </ul><br>
  
<p align="center">
  <ins>2nd Job: Test</ins><br>
</p>
Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>test</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li>
  </ul><br>

  Post-Build Action: Build Other projects
<ul style=“list-style-type:square”>
  <li>Project Name: Integration-Test</li>
  </ul><br>
  
Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
   </ul><br>
  
  
  
   <p align="center">
  <ins>3rd Job: Integration-Test</ins><br>
</p>
Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>verify -DskipUnitTests</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li>
  </ul><br>
 

Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
   </ul><br>
  
  Post-Build Action: Build Other projects
<ul style=“list-style-type:square”>
  <li>Project Name: Code-Analysis-CheckStyles</li>
  </ul><br>
  
  
  
 <p align="center">
  <ins>4th Job: Code-Analysis-CheckStyles</ins><br>
</p>
Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>checkstyle:checkstyle</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li></ul><br>
 
Post-Build Action: Report Violations
<ul style=“list-style-type:square”>
  <li>Adjust your checkstyle violations on the threshold for Failure & Unstable</li>
  <li>XML Filename pattern: target/checkstyle-result.xml (generated from checkstyle checks)</li></ul><br>

  Post-Build Action: Build Other projects
<ul style=“list-style-type:square”>
  <li>Project Name: Sonarqube-Code-Analysis</li>
  </ul><br>
  
Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
   </ul><br>
  
  
 <p align="center">
  <ins>5th Job: Sonarqube-Code-Analysis</ins><br>
</p>
Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>Install</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li> </ul><br>

Build: Invoke top-level Maven targets
<ul style=“list-style-type:square”>
  <li>Goal: <code>checkstyle:checkstyle</code></li>
  <li>Settings file in filesystem</li>
  <li>File path: settings.xml</li>
  <li>Properties: Fill up the properties based on your variables.<br>Eg. NEXUSPORT=8081, RELEASE-REPO= CICD-Maven-Repository-RELEASE</li> </ul><br>

Build: Execute SonarQube Scanner
<ul style=“list-style-type:square”>
  <li>Analysis properties: <code>userdata/sonar-application.properties</code></li>
  </ul><br>

Post-Build Action: Quality Gates Sonarqube Plugin
<ul style=“list-style-type:square”>
  <li>Project key: (What you have included in the Analysis properties above)</li>
    <li>Job Status when analysis fails: FAILED</li>
   </ul><br>

  Post-Build Action: Build Other projects
<ul style=“list-style-type:square”>
  <li>Project Name: Deploy-To-Nexus</li>
  </ul><br>
  
Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
   </ul><br>
  
 <p align="center">
  <ins>6th Job: Deploy-To-Nexus</ins><br>
</p>
  
General: Tick "Change data pattern for the BUILD_TIMESTAMP(build timestamp) variable)
<ul style=“list-style-type:square”>
  <li>Date & Time Pattern: yy-MM-dd_HHmm</li> </ul><br>
  
Build: Copy artifacts from another project
<ul style=“list-style-type:square”>
  <li>Project Name: Build</li>
  <li>Artifacts to copy: **/*.war</li>   </ul><br>
  
Build: Nexus artifact uploader
<ul style=“list-style-type:square”>
  <li>Nexus Version: NEXUS3</li>
  <li>Nexus URL: Private-IP of Nexus Server - Copy from AWS</li>
  <li>Credentials : username with password </li>
  <li>GroupId: CICD-QA</li>
  <li>Version: $BUILD_ID</li>
  <li>Repository: CICD-Maven-RELEASE</li>
  <li>ArtifactId: $BUILD_TIMESTAMP</li>
  <li>File: target/cicd.war</li>  
  </ul><br>
  
  Post-Build Action: Slack-Notification
<ul style=“list-style-type:square”>
  <li>Notify Build-Start</li>
    <li>Notify Success</li>
    <li>Notify Unstable</li>
      <li>Notify Every Failure</li>
   </ul><br>





