# Iniciando com o Risco-5

## Testes / Simulação

O diretório "testes" contém alguns testes para os módulos do projeto. Esses testes foram desenvolvidos para serem utilizados com o [Iverilog](https://steveicarus.github.io/iverilog/). Para executar os testes, basta utilizar o Iverilog e o VVP, como mostrado no exemplo abaixo:

```bash
iverilog -o build/core_test.o -s core_tb src/core/* src/peripheral/memory.v tests/core_test.v
vvp build/core_test.o
```

Para facilitar a execução dos testes, é possível utilizar o script "run_test" disponível na raiz do projeto. Ao executar esse script, ele solicitará o nome do teste e o nome de um dos arquivos de teste em assembly disponíveis no diretório "software/code/". Como resultado, será gerado um arquivo "soc.vcd" em "build/" que pode ser analisado através do GTKWave.

### Requisitos:

- Iverilog
- GTKWave

Essas dependências podem ser obtidas através do [oss cad suite](https://github.com/YosysHQ/oss-cad-suite-build) ou podem ser instaladas manualmente de forma individual.

## FPGA

O projeto oferece suporte a testes em algumas FPGAs, listadas abaixo:

- Colorlight i9 - ECP5 45F
- Digilent Arty A7 100t
- Digilent Nexys 4 DDR
- Tangnano 20k
- AMD/Xilinx VC709 Connectivity Kit

Os exemplos estão disponíveis no diretório "FPGA". Para as FPGAs Sipeed (Tangnano 9k e 20k), os exemplos foram desenvolvidos utilizando a IDE Gowin. Para as FPGAs Lattice/ColorLight, os exemplos foram desenvolvidos utilizando o Yosys + NextPNR e podem ser sintetizados e programados utilizando o makefile disponível nos diretórios. Para as FPGAs Xilinx, foi utilizado o Vivado, e os exemplos podem ser utilizados também utilizando o makefile disponível no diretório.

### Requisitos

- AMD/Xilinx:
    Vivado
    openFPGALoader
- Lattice/Colorlight:
    Yosys
    Nextpnr-ECP5
    ecppack
    openFPGALoader
- Gowin/Sipeed:
    Gowin EDA
    openFPGALoader

- Geral:
    Pyserial ou VSCode Serial ou Minicom ou outro software capaz de utilizar serial

### Executando o Teste na FPGA

Acesse o diretório "fpga/???" com "???" sendo o nome da FPGA a ser utilizada, e execute o comando "make". Com isso, a síntese do projeto será realizada. Para carregar o bitstream para a placa, utilize "make flash". Caso queira executar tudo de uma vez, use "make run_all".

#### Feedback da FPGA

Se tudo ocorrer bem, os LEDs da FPGA começarão a piscar em um ritmo de contagem, e na serial começará a ser enviado um caractere ASCII. A serial opera com um baudrate padrão de 115200 bps.