pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clona o repositório
                checkout scm
            }
        }

        stage('Yosys') {
            steps {
                // Realiza as etapas de compilação
                sh 'echo "Yosys"'
            }
        }

        stage('NextPNR') {
            steps {
                // Executa testes automatizados
                sh 'echo "NextPNR"'
            }
        }

        stage('ECPPACK') {
            steps {
                // Implementa ou faz o deploy da aplicação
                // (Substitua com seus comandos específicos)
                sh 'echo "Implementação/Deploy"'
            }
        }
    }
    
    post {
        success {
            // Ações a serem executadas em caso de sucesso
            echo 'Pipeline foi executada com sucesso!'
        }
        failure {
            // Ações a serem executadas em caso de falha
            echo 'A pipeline falhou. Realize as correções necessárias.'
        }
    }
}
