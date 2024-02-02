pipeline {
    agent any

    stages {
        stage('git_clone') {
            steps {
                sh 'rm -Rf Risco-5/ build/'
                sh 'git clone https://github.com/JN513/Risco-5'
                sh 'cd Risco-5'
            }
        }
        stage('Yosys') {
            steps {
                sh 'mkdir -p build'
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
                        --speed 6 --ignore-loops 
                    '''
            }
        }
        stage('ECPPACK') {
            steps {
                sh '/eda/oss-cad-suite/bin/ecppack --compress --input ./build/out.config  --bit ./build/out.bit'
            }
        }
        stage('openFPGAloader') {
            steps {
                sh '/eda/oss-cad-suite/bin/openFPGALoader -b colorlight-i9 ./build/out.bit'
            }
        }
    }
}
