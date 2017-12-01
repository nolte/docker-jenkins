import jenkins.model.*
import hudson.model.ListView
import hudson.model.*
import hudson.plugins.nested_view.NestedView;
//https://github.com/jenkinsci/nested-view-plugin
def name = 'featureBuilds'

def overview = new NestedView("Gitflow Overview")

def mastersBuilds = new ListView("masters",overview)
mastersBuilds.setIncludeRegex(".*master")
mastersBuilds.setRecurse(true)

def developBuilds = new ListView("develop",overview)
developBuilds.setIncludeRegex(".*develop")
developBuilds.setRecurse(true)

def featureBuilds = new ListView("features",overview)
featureBuilds.setIncludeRegex(".*feature")
featureBuilds.setRecurse(true)


def gitflowControllBuilds = new ListView("gitflow-controll",overview)
gitflowControllBuilds.setIncludeRegex(".*gitflow-.*")
gitflowControllBuilds.setRecurse(true)


overview.addView(gitflowControllBuilds)
overview.addView(mastersBuilds)
overview.addView(developBuilds)
overview.addView(featureBuilds)


//Jenkins.instance.deleteView(overview)
Jenkins.instance.addView(overview)



println overview
