stage('build') {
    node() {
        checkout scm
        docker.withRegistry('http://bill:5043') {
          def customImage = docker.build("services/jenkins:2.91")
          customImage.push()
        }
    }
}
