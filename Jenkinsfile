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
                sh 'rm -f Risco-5/software/memory/generic.hex'
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
                                        read_verilog Risco-5/debug/reset.v; \
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
                                        --speed 6 --lpf-allow-unconstrained
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
                        sh 'rm -rf Risco-5/impl/pnr'
                        sh 'mkdir -p Risco-5/impl/pnr'
                        sh 'cd Risco-5/fpga/tangnano20k/ && /eda/gowin/IDE/bin/gw_sh run.tcl'
                    }
                }

                stage('Vivado') {
                    steps {
                        sh 'cd Risco-5/fpga/nexys4_ddr && mkdir build && /eda/vivado/Vivado/2023.2/bin/vivado -mode batch -nolog -nojournal -source run.tcl'
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

                stage('openFPGAloader Nexys 4 DDR') {
                    steps {
                        script {
                            lock('nexys4'){
                                echo 'FPGA Nexys 4 Broqueada'
                                sh 'cd Risco-5/fpga/nexys4_ddr && /eda/oss-cad-suite/bin/openFPGALoader -b nexys_a7_100 ./build/out.bit'
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

                stage("Nexys 4 - Testes"){
                    steps{
                        script{
                            echo 'Rodando teste na Nexys 4'
                            lock('nexys4'){
                                echo 'FPGA Nexys 4 Broqueada'
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
