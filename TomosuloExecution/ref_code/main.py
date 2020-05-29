'''
Main Script to Run Other Scripts
'''

# Imports
from copy import deepcopy
from collections import deque, namedtuple
from init import read_instruction, build_rs, ld_sd_entry, ld_sd_exe, ld_sd_mem, cdb, ROB_entry, PC
from print_status import ps, pss
from issue import issue, check_rs_space
from exe import exe
from mem import mem
from wb import wb
from commit import commit

# Driver Code
# Initialise
instructions = read_instruction('code/code.in')  # Read instructions from input file

# Initialise regs, RAT, Memory
# int REG - integer register
reg_int = []
for i in range(32):
    reg_int.extend([0])
reg_int[1] = 12
reg_int[2] = 32
rat_int = deepcopy(reg_int)

# fp REG - floating point register
reg_fp = []
for i in range(32):
    reg_fp.extend([0])
reg_fp[20] = 3.0
rat_fp = deepcopy(reg_fp)

# Memory
memory = []
for i in range(256):
    memory.extend([0])
memory[4] = 3.0
memory[8] = 2.0
memory[12] = 1.0
memory[24] = 6.0
memory[28] = 5.0
memory[32] = 4.0

# Intialise Reservation Stations
# integer adder rs
size_rs_int_adder = 4
rs_int_adder = build_rs(size_rs_int_adder)
# fp adder rs
size_rs_fp_adder = 3
rs_fp_adder = build_rs(size_rs_fp_adder)
# fp multiplier rs
size_rs_fp_multi = 2
rs_fp_multi = build_rs(size_rs_fp_multi)

# Initialise Function Unit
# cycles in int adder
fu_int_adder = deque()
time_fu_int_adder = 1
# cycles in fp adder
fu_fp_adder = deque()
time_fu_fp_adder = 4
# cycles in fp multiplier
fu_fp_multi = deque()
time_fu_fp_multi = 15

# Initialise Load/Store Queue
ld_sd_queue = deque()
size_ld_sd_queue = 5
ld_sd_exe = ld_sd_exe()
ld_sd_exe.busy = 0
time_ld_sd_exe = 1
ld_sd_mem = ld_sd_mem()
ld_sd_mem.busy = 0
time_ld_sd_mem = 5

# Initialise ROB
ROB = deque()
size_ROB = 64

# Initialise CDB
results_buffer = deque()
cdb = cdb()
cdb.valid = 0

# Issue first instruction
# Instruction Pointer
PC = PC()
PC.PC = 0
PC.valid = 1
cycle = 1

# Print Title
item = ''.ljust(30)
item += 'ISSUE'.ljust(15)
item += 'EXE'.ljust(15)
item += 'MEM'.ljust(15)
item += 'WB'.ljust(15)
item += 'COMMIT'.ljust(15)
print (item)

# Main Code
while (len(ROB)>0)|(cycle==1):
    
    # ISSUE stage
    if (PC.PC<len(instructions))&(PC.valid==1):
        issue(cycle, PC, instructions, ROB, size_ROB,
                rs_int_adder,
                rs_fp_adder,
                rs_fp_multi,
                ld_sd_queue, size_ld_sd_queue,
                rat_int, rat_fp)

    # EXE stage
    exe(fu_int_adder, time_fu_int_adder,
        fu_fp_adder, time_fu_fp_adder,
        fu_fp_multi, time_fu_fp_multi, results_buffer,
        rs_int_adder, rs_fp_adder, rs_fp_multi,
        ld_sd_exe, time_ld_sd_exe, ld_sd_queue,
        cycle, ROB, PC)

    # MEM stage
    mem(ld_sd_queue, ld_sd_mem, time_ld_sd_mem, results_buffer,
        memory, ROB, cycle)

    # CDB stage
    wb(cdb, rat_int, rat_fp,
        rs_int_adder, rs_fp_adder, rs_fp_multi,
        ld_sd_queue, ROB, cycle,
        results_buffer)

    # COMMIT stage
    commit(ROB, reg_int, reg_fp, cycle, instructions)

    # cycle number
    cycle +=1