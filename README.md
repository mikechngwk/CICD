<p align="center">
  <img src="https://user-images.githubusercontent.com/79030801/158134570-261777f5-8185-4974-ba06-81056ef651a8.png" />
</p>

## Nexus Repository : 


<p align="center">
  <ins>Create: CICD-Maven-Central-Repository (maven-proxy)</ins><br>
</p>
This repository stores all the dependencies needed for Maven to build your artifact. <br>
Remote Storage: https://repo1.maven.org/maven2/
<br>

<p align="center">
  <ins>Create: CICD-Maven-Repository-RELEASE (maven-hosted)</ins><br>
</p>
This repository stores all artifacts built by maven which will be downloaded to UAT-staging server. <br>
<br>

<p align="center">
  <ins>Create: CICD-Maven-Repository-SNAPSHOT (maven-hosted)</ins><br>
</p>
This repository stores all artifacts built by maven when the artifact is a snapshot<br>
<br>

<p align="center">
  <ins>Create: CICD-Maven-Group (maven-group)</ins><br>
</p>
This repository stores all the contents of CICD-Maven-Repository-RELEASE & CICD-Maven-Central-Repository <br>& CICD-Maven-Repository-SNAPSHOT<br>
<br>



<a href="https://github.com/mikechngwk/CICD/tree/second-jenkins">Return to Jenkins</a>



