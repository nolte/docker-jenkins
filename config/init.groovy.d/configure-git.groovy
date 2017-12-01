import jenkins.model.*

def inst = Jenkins.getInstance()

def desc = inst.getDescriptor("hudson.plugins.git.GitSCM")

desc.setGlobalConfigName("jenkins")
desc.setGlobalConfigEmail("jenkins@noltarium.de")

desc.save()
