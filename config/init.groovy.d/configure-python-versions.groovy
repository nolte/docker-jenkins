// Configure the https://wiki.jenkins.io/display/JENKINS/ShiningPanda+Plugin
// base for python2 and python3 jobs

import jenkins.model.*
import hudson.model.*
import jenkins.plugins.shiningpanda.tools.PythonInstallation

pythonDesc = Jenkins.instance.getDescriptorByName("jenkins.plugins.shiningpanda.tools.PythonInstallation");
PythonInstallation python2 = new PythonInstallation("System-CPython-2.7","usr/bin/python2",null)
PythonInstallation python3 = new PythonInstallation("System-CPython-3","usr/bin/python3",null)
pythonDesc.setInstallations(python2,python3);
