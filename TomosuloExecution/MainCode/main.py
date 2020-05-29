'''
Main Script to Run Other Scripts
'''

# Imports
from copy import deepcopy
import json

from collections import deque, namedtuple
from init import read_instruction, encode_instructions, decode_instructions, print_instructions, build_rs, ld_sd_entry, ld_sd_exe, ld_sd_mem, cdb, ROB_entry, PC, flags
from print_status import ps, pss
from issue import issue, check_rs_space
from exe import exe
from mem import mem
from wb import wb
from commit import commit, print_ROB

# Driver Code
# Initialise
config = json.load(open('MainCode/config.json', 'rb'))
# Read
instructions = read_instruction('MainCode/code.txt')  # Read instructions from input file
# Encode
bin_instructions = encode_instructions(instructions, config)
print("Binary Code: ")
print_instructions(bin_instructions)
print("\n")
# Decode
instructions = decode_instructions(bin_instructions, config)
print("Code: ")
print_instructions(instructions)
print("\n")


# Initialise regs, RAT, Memory
# int REG - integer register
reg = []
for i in range(config['n_registers']):
    reg.extend([0])
for key in config['register_init_values'].keys(): # Initialise values
    reg[int(key)] = config['register_init_values'][key]
rat = deepcopy(reg)

# Memory
memory = []
for i in range(2**config['n_bits_address']):
    memory.extend([0])
for key in config['memory_init_values'].keys(): # Initialise values
    memory[int(key)] = config['memory_init_values'][key]

# Intialise Reservation Stations, Functional Units
rs = {}
fu = {}
fu_time = {}
for item in config['rs_fu']:
    # Build Reservation Station
    rs[item['rs_type']] = build_rs(item['rs_size'])
    # Build Functional Unit
    fu[item['rs_type']] = deque()
    fu_time[item['rs_type']] = item['fu_time']

# Initialise Load/Store Queue
ld_sd_queue = deque()
size_ld_sd_queue = config['load_store']['queue_size']
ld_sd_exe = ld_sd_exe()
ld_sd_exe.busy = 0
time_ld_sd_exe = config['load_store']['time_exe']
ld_sd_mem = ld_sd_mem()
ld_sd_mem.busy = 0
time_ld_sd_mem = config['load_store']['time_mem']

# Initialise ROB
ROB = deque()
size_ROB = config['ROB_size']

# Initialise CDB
results_buffer = deque()
cdb = cdb()
cdb.valid = 0

# Flags
Flags = flags()
Flags.CF = 0
Flags.HALT = 0

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
while (len(ROB) > 0) or (cycle == 1):

    # ISSUE stage
    if (PC.PC < len(instructions)) and (PC.valid == 1):
        issue(cycle, PC, instructions, ROB, size_ROB,
                rs,
                ld_sd_queue, size_ld_sd_queue,
                rat,
                config, Flags)
    
    if Flags.HALT:
        for element in ROB:
            print_ROB(element, instructions)
        break

    # print("ISSUE", cycle)

    # EXE stage
    exe(fu, fu_time,
        results_buffer,
        rs,
        ld_sd_exe, time_ld_sd_exe, ld_sd_queue,
        cycle, ROB, PC, Flags)

    # print("EXE", cycle)

    # MEM stage
    mem(ld_sd_queue, ld_sd_mem, time_ld_sd_mem, results_buffer,
        memory, ROB, cycle)

    # print("MEM", cycle)

    # CDB stage
    wb(cdb, rat,
        rs,
        ld_sd_queue, ROB, cycle,
        results_buffer)

    # print("WB", cycle)

    # COMMIT stage
    commit(ROB, reg, cycle, instructions)

    # print("COMMIT", cycle)
    print(rat)

    # cycle number
    cycle += 1