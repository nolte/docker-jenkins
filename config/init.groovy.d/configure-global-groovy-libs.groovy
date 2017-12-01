import org.jenkinsci.plugins.workflow.libs.SCMSourceRetriever;
import org.jenkinsci.plugins.workflow.libs.LibraryConfiguration;
import jenkins.plugins.git.GitSCMSource;
import jenkins.model.*

def instance = Jenkins.getInstance()


def globalLibsDesc = instance.getDescriptor("org.jenkinsci.plugins.workflow.libs.GlobalLibraries")


SCMSourceRetriever retriever = new SCMSourceRetriever(new GitSCMSource("groovy-gitflow-job-utils","ssh://git@bill:10022/configuration/jenkins/groovy-gitflow-job-utils.git","b8562cfa-bca8-4222-ab12-2e5696d1014b","*","",false))
LibraryConfiguration pipeline = new LibraryConfiguration("gitflow", retriever);


globalLibsDesc.get().setLibraries([pipeline])
