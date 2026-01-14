# Makefile for QuestaSim simulation control
# ==========================================
# Variables:
#   GUI=1/0      : Enable/disable GUI mode (default: 1)
#   COVERAGE=1/0 : Enable/disable coverage collection (default: 1)
#
# Examples:
#   make                           - Run with GUI and coverage
#   make GUI=0                     - Run in batch mode (no GUI)
#   make COVERAGE=0                - Run without coverage
#   make GUI=0 COVERAGE=0          - Run in batch mode without coverage
#   make clean                     - Clean all simulation artifacts
#   make cleanall                  - Force clean with elevated permissions

# Default settings
GUI ?= 1
COVERAGE ?= 1

# File names
DO_FILE = runsim.do
TEMP_DO_FILE = runsim_temp.do

# Default target
.PHONY: all run clean cleanall force-clean help

all: run

run:
	@echo "=========================================="
	@echo "Preparing QuestaSim simulation..."
	@echo "GUI mode: $(GUI)"
	@echo "Coverage: $(COVERAGE)"
	@echo "=========================================="
	@cp $(DO_FILE) $(TEMP_DO_FILE)
ifeq ($(GUI),0)
	@echo "→ Disabling GUI commands..."
	@sed -i '/^add wave/s/^/# /' $(TEMP_DO_FILE)
	@sed -i '/^\.vcop Action toggleleafnames/s/^/# /' $(TEMP_DO_FILE)
	@sed -i '/^wave zoom range/s/^/# /' $(TEMP_DO_FILE)
endif
ifeq ($(COVERAGE),0)
	@echo "→ Disabling coverage commands..."
	@sed -i '/^coverage save/s/^/# /' $(TEMP_DO_FILE)
	@sed -i '/^coverage report/s/^/# /' $(TEMP_DO_FILE)
	@sed -i '/^quit -sim/s/^/# /' $(TEMP_DO_FILE)
	@sed -i '/^vcover report/s/^/# /' $(TEMP_DO_FILE)
endif
	@echo "→ Starting simulation..."
	@echo "=========================================="
ifeq ($(GUI),0)
	vsim -c -do $(TEMP_DO_FILE)
else
	vsim -do $(TEMP_DO_FILE)
endif

clean:
	@echo "=========================================="
	@echo "Cleaning simulation artifacts..."
	@echo "=========================================="
	@echo "→ Killing any running vsim processes..."
	@pkill -9 vsim 2>/dev/null || true
	@sleep 0.5
	@echo "→ Attempting to remove work directory..."
	@if [ -d "work/_dpi" ]; then \
		echo "  → Removing DPI files with elevated permissions..."; \
		sudo rm -rf work/_dpi 2>/dev/null || \
		chmod -R 777 work/_dpi 2>/dev/null && rm -rf work/_dpi 2>/dev/null || \
		find work/_dpi -type f -exec sudo rm -f {} \; 2>/dev/null || true; \
	fi
	@sudo rm -rf work/ 2>/dev/null || chmod -R 777 work/ && rm -rf work/ || true
	@[ ! -d "work" ] && echo "  ✓ Removed work/" || echo "  ⚠ Warning: Could not fully remove work/"
	@rm -f simulation.log && echo "→ Removed simulation.log" || true
	@rm -f tr_db.log && echo "→ Removed tr_db.log" || true
	@rm -f transcript && echo "→ Removed transcript" || true
	@rm -f vsim.wlf && echo "→ Removed vsim.wlf" || true
	@rm -f vsim_stacktrace.vstf && echo "→ Removed vsim_stacktrace.vstf" || true
	@rm -f certe_dump.xml && echo "→ Removed certe_dump.xml" || true
	@rm -f $(TEMP_DO_FILE) && echo "→ Removed $(TEMP_DO_FILE)" || true
	@rm -f *.ucdb && echo "→ Removed *.ucdb files" || true
	@rm -f *cover_report.txt && echo "→ Removed coverage reports" || true
	@rm -f coverage_rpt.txt && echo "→ Removed coverage_rpt.txt" || true
	@echo "=========================================="
	@echo "Clean complete!"
	@echo "=========================================="

cleanall: force-clean

force-clean:
	@echo "=========================================="
	@echo "FORCE CLEANING (with elevated permissions)"
	@echo "=========================================="
	@echo "→ Killing all vsim processes..."
	@sudo pkill -9 vsim 2>/dev/null || pkill -9 vsim 2>/dev/null || true
	@sleep 1
	@echo "→ Forcefully removing all locked files..."
	@if [ -d "work" ]; then \
		echo "  → Changing permissions..."; \
		sudo chmod -R 777 work/ 2>/dev/null || true; \
		echo "  → Removing work/..."; \
		sudo rm -rf work/ 2>/dev/null || true; \
	fi
	@sudo rm -rf work/ 2>/dev/null || true
	@sudo rm -f simulation.log tr_db.log transcript vsim.wlf vsim_stacktrace.vstf 2>/dev/null || true
	@sudo rm -f certe_dump.xml $(TEMP_DO_FILE) *.ucdb *cover_report.txt coverage_rpt.txt 2>/dev/null || true
	@rm -f simulation.log tr_db.log transcript vsim.wlf vsim_stacktrace.vstf 2>/dev/null || true
	@rm -f certe_dump.xml $(TEMP_DO_FILE) *.ucdb *cover_report.txt coverage_rpt.txt 2>/dev/null || true
	@[ ! -d "work" ] && echo "  ✓ Successfully removed all files" || echo "  ⚠ Some files may still be locked"
	@echo "=========================================="
	@echo "Force clean complete!"
	@echo "=========================================="

help:
	@echo "=========================================="
	@echo "QuestaSim Simulation Makefile"
	@echo "=========================================="
	@echo ""
	@echo "TARGETS:"
	@echo "  make [run]       - Run simulation (default target)"
	@echo "  make clean       - Remove all simulation artifacts"
	@echo "                     (tries sudo for DPI files)"
	@echo "  make cleanall    - Alias for force-clean"
	@echo "  make force-clean - Force remove ALL files with sudo"
	@echo "                     (use if clean fails)"
	@echo "  make help        - Display this help message"
	@echo ""
	@echo "VARIABLES:"
	@echo "  GUI=1/0          - Enable (1) or disable (0) GUI mode"
	@echo "                     Default: 1 (GUI enabled)"
	@echo "                     When disabled: wave commands are commented out"
	@echo "                                   and vsim runs with -c flag"
	@echo ""
	@echo "  COVERAGE=1/0     - Enable (1) or disable (0) coverage collection"
	@echo "                     Default: 1 (Coverage enabled)"
	@echo "                     When disabled: coverage commands are commented out"
	@echo ""
	@echo "USAGE EXAMPLES:"
	@echo "  make                          # GUI + Coverage (defaults)"
	@echo "  make GUI=0                    # Batch mode + Coverage"
	@echo "  make COVERAGE=0               # GUI mode without Coverage"
	@echo "  make GUI=0 COVERAGE=0         # Batch mode without Coverage"
	@echo "  make run GUI=1 COVERAGE=1     # Explicit: GUI + Coverage"
	@echo ""
	@echo "CLEANING:"
	@echo "  make clean                    # Remove files (with DPI handling)"
	@echo "  make cleanall                 # Force remove with sudo"
	@echo ""
	@echo "NOTE: DPI files may require elevated permissions."
	@echo "      If 'make clean' fails, run 'make cleanall'"
	@echo ""
	@echo "=========================================="