
import jenkins.model.*
import hudson.model.*


jdkDesc = Jenkins.instance.getDescriptorByName("hudson.model.JDK");
JDK jdk = new JDK("Java 8", "/docker-java-home");
jdkDesc.setInstallations(jdk);
