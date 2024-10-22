PROJECT_NAME = cyclone10_gx
OUTPUT_DIR = build
TOP_FILE = main.v

#all: blink.v
#	quartus_syn blink
#	quartus_fit blink
#	quartus_asm blink

all: ./$(OUTPUT_DIR)/$(PROJECT_NAME).sof

./$(OUTPUT_DIR)/$(PROJECT_NAME).sof: ./$(OUTPUT_DIR)/$(PROJECT_NAME).fit.finalize.rpt
	$(QUARTUS_PATH)quartus_asm $(PROJECT_NAME)

./$(OUTPUT_DIR)/$(PROJECT_NAME).fit.finalize.rpt: ./$(OUTPUT_DIR)/$(PROJECT_NAME).syn.rpt
	$(QUARTUS_PATH)quartus_fit $(PROJECT_NAME)

./$(OUTPUT_DIR)/$(PROJECT_NAME).syn.rpt: $(PROJECT_NAME).qsf $(TOP_FILE)
	$(QUARTUS_PATH)quartus_syn $(PROJECT_NAME)

load:
	$(QUARTUS_PATH)quartus_pgm -a -o "p;$(OUTPUT_DIR)/$(PROJECT_NAME).sof"

#flash:
#	quartus_pgm -a -o "p;build/blink.sof"


clean:
	rm -rf $(OUTPUT_DIR)

run_all: all load