pipeline {
    agent any

    options {
        parallelsAlwaysFailFast()
    }

    stages {
        stage('Git Clone') {
            steps {
                sh 'rm -Rf Risco-5/ build/'
                sh 'git clone https://github.com/JN513/Risco-5'
                sh 'cd Risco-5'
            }
        }

        stage('IVerilog') {
            steps {
                sh 'mkdir -p build'
                sh 'cp Risco-5/software/memory/add.hex Risco-5/software/memory/generic.hex'
                sh'''
                    /eda/oss-cad-suite/bin/iverilog -o build/soc_test.o -s soc_tb Risco-5/src/core/*.v Risco-5/src/peripheral/*.v Risco-5/tests/soc_test.v
                    '''
                sh '/eda/oss-cad-suite/bin/vvp build/soc_test.o'
                sh 'rm -f Risco5/software/memory/generic.hex'
            }
        }

        stage('Síntese') {
            parallel {
                stage('OSS-Cad-Suite') {
                    stages{
                        stage('Yosys'){
                            steps {
                                sh'''
                                    /eda/oss-cad-suite/bin/yosys -p " \
                                        read_verilog Risco-5/fpga/ecp5/*.v; \
                                        read_verilog Risco-5/debug/clk_divider.v; \
                                        read_verilog Risco-5/src/core/*.v; \
                                        read_verilog Risco-5/src/peripheral/*.v; \
                                        synth_ecp5 -json ./build/out.json -abc9 \
                                    "
                                    '''
                            }
                        }

                        stage('NextPNR') {
                            steps {
                                sh '''
                                    /eda/oss-cad-suite/bin/nextpnr-ecp5 --json ./build/out.json --write ./build/out_pnr.json --45k \
                                        --lpf Risco-5/fpga/ecp5/pinout.lpf --textcfg ./build/out.config --package CABGA381 \
                                        --speed 6 --ignore-loops --lpf-allow-unconstrained
                                    '''
                            }
                        }

                        stage('ECPPACK') {
                            steps {
                                sh '/eda/oss-cad-suite/bin/ecppack --compress --input ./build/out.config  --bit ./build/out.bit'
                            }
                        }
                    }
                }

                stage('Gowin') {
                    steps {
                        sh 'cd Risco-5'
                        sh '/eda/gowin/IDE/bin/gw_sh fpga/tangnano20k/run.tcl'
                    }
                }
            }
        }

        stage('FPGA Flash'){
            parallel {
                stage('openFPGAloader ECP5') {
                    steps {
                        script {
                            lock('ecp5'){
                                echo 'FPGA ECP5 Broqueada'
                                sh '/eda/oss-cad-suite/bin/openFPGALoader -b colorlight-i9 ./build/out.bit'
                            }
                        }
                    }
                }

                stage('openFPGAloader Tangnano 20k') {
                    steps {
                        script {
                            lock('tangnano20k'){
                                echo 'FPGA TangNano Broqueada'
                                sh 'echo "gravando na tang nano"'
                            }
                        }
                    }
                }
            }
        }

        stage('Testes'){
            parallel {
                stage("ECP5 - Testes"){
                    steps {
                        script{
                            echo 'Rodando teste na ECP5'
                            lock('ecp5'){
                                echo 'FPGA ECP5 Broqueada'
                                sh 'echo "testando na ecp5"'
                            }
                            echo 'ECP5 liberada'
                        }
                    }
                }
                stage("TangNano - Testes"){
                    steps{
                        script{
                            echo 'Rodando teste na tang nano'
                            lock('tangnano20k'){
                                echo 'FPGA TangNano Broqueada'
                                sh 'echo "testando na tang nano"'
                            }
                            echo 'TangNano liberada'
                        }
                    }
                }
            }
        }
    }
}
