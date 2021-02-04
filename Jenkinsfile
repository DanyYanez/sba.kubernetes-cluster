pipeline {
    agent any
    environment {        
	DOCKER_HUB_REPO = "danyyanez/sba_kuber"
	REGISTRY_CREDENTIAL = "dockerhub"
        CONTAINER_NAME = "proyect"
        STUB_VALUE = "200"
    }
    stages {
        stage('Stubs-Replacement'){
            steps {
                // 'STUB_VALUE' Environment Variable declared in Jenkins Configuration 
                echo "STUB_VALUE = ${STUB_VALUE}"
                sh "sed -i 's/<STUB_VALUE>/$STUB_VALUE/g' Config.py"
                sh 'cat Config.py'
            }
        }
        stage('Build') {
            steps {
		    script {
			//  Building new image
			sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
			sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'

			//  Pushing Image to Repository
			docker.withRegistry( '', REGISTRY_CREDENTIAL ) {
				sh 'docker push danyyanez/sba_kuber:$BUILD_NUMBER'
				sh 'docker push danyyanez/sba_kuber:latest'
			}
                
                	echo "Image built and pushed to repository"
		    }
	    }
        }
        stage('Deploy') {
            steps {
                script{
                    if (BUILD_NUMBER == "2") {
                        sh 'docker run --name $CONTAINER_NAME -d -p 6000:6000 $DOCKER_HUB_REPO'
                    }
                    else {
                        sh 'docker stop $CONTAINER_NAME'
                        sh 'docker rm $CONTAINER_NAME'
                        sh 'docker run --name $CONTAINER_NAME -d -p 6000:6000 $DOCKER_HUB_REPO'
                    }

                }
            }
        }
    }
}
