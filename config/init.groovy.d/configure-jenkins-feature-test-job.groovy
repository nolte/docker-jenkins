import javaposse.jobdsl.plugin.*;
import hudson.plugins.git.GitSCM;
import hudson.plugins.git.BranchSpec;
import hudson.triggers.SCMTrigger;
import hudson.triggers.TimerTrigger;
import jenkins.model.Jenkins;
import org.jenkinsci.plugins.workflow.cps.*;
import org.jenkinsci.plugins.workflow.job.WorkflowJob;
import org.jenkinsci.plugins.workflow.flow.FlowDefinition;

jenkins = Jenkins.instance;

jobName = "feature-test-job"

job = jenkins.getJob(jobName);

if(job!=null)
 job.delete();

workflowJob = new WorkflowJob(jenkins, jobName);

def jobDSL="""
pipeline {
    agent none
    stages {
        stage('Run Tests') {
            parallel {
                stage('check kubectl v1.6.1') {
                    agent any
                    steps {
                        sh "/opt/kubectl/v1.6.1/kubectl version"
                    }
                }
                stage('check kubectl v1.13.0') {
                    agent any
                    steps {
                        sh "/opt/kubectl/v1.13.0/kubectl version"
                    }
                }
                stage('check oc v3.6.0') {
                    agent any
                    steps {
                        sh "/opt/openshift-origin-client-tools/v3.6.0/oc version"
                    }
                }
                stage('check oc v3.11.0') {
                    agent any
                    steps {
                        sh "/opt/openshift-origin-client-tools/v3.11.0/oc version"
                    }
                }
                stage('check kustomize') {
                    agent any
                    steps {
                        sh "/opt/kustomize/v1.0.11/kustomize version"
                    }
                }
                stage('check terraform') {
                    agent any
                    steps {
                        sh "/opt/terraform/v0.11.11/terraform version"
                    }
                }
            }
        }
    }
}
""";
//http://javadoc.jenkins.io/plugin/workflow-cps/index.html?org/jenkinsci/plugins/workflow/cps/CpsFlowDefinition.html
def flowDefinition = new org.jenkinsci.plugins.workflow.cps.CpsFlowDefinition(jobDSL, true);
workflowJob.setDefinition(flowDefinition)


jenkins.add(workflowJob, workflowJob.name);
