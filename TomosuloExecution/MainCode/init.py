'''
Initialisation Fucntions
'''

# Imports
from collections import namedtuple
import math

# Main Functions
# Define Datatypes
# Reservation Station
def rs_entry():
    rs_entry = namedtuple('rs_entry', 'busy, op, tag_1st, value_1st, valid_1st, tag_2nd, value_2nd, valid_2nd, dest_tag')
    temp = rs_entry
    return temp
# Functional Unit
def fu_entry():
    fu_entry = namedtuple('fu_entry', 'cycle, op, value1, value2, dest_tag')
    temp = fu_entry
    return temp
# Functional Result
def fu_result():
    fu_result = namedtuple('fu_result', 'value, dest_tag')
    temp = fu_result
    return temp
# ld/sd entry
def ld_sd_entry():
    ld_sd_entry = namedtuple('ld_sd_entry', 'ld_sd_tag, ready, op, address, data, dest_tag, immediate, reg_tag, reg_value, valid')
    temp = ld_sd_entry
    return temp
# ld/sd exe
def ld_sd_exe():
    ld_sd_exe = namedtuple('ld_sd_exe', 'busy, cycle, value1, value2, dest_tag')
    temp = ld_sd_exe
    return temp
# ld/sd mem
def ld_sd_mem():
    ld_sd_mem = namedtuple('ld_sd_mem', 'busy, cycle, op, data, address, dest_tag')
    temp = ld_sd_mem
    return temp
# cdb
def cdb():
    cdb = namedtuple('cdb', 'valid, value, dest_tag')
    temp = cdb
    return temp
# ROB_entry
def ROB_entry():
    ROB_entry = namedtuple('ROB_entry', 'ROB_tag, PC, value, dest_tag, issue, exe, mem, cdb, commit')
    temp = ROB_entry
    temp.issue = []
    temp.exe = []
    temp.mem = []
    temp.cdb = []
    temp.commit =[]
    return temp
# PC
def PC():
    PC = namedtuple('PC', 'PC, valid')
    temp = PC
    return temp
# Flags
def flags():
    Flags = namedtuple('Flags', 'CF, HALT')
    temp = Flags
    return temp
# Function: read instructions
def read_instruction(codefile):
    with open(codefile) as f:
            instructions = f.read().splitlines()
    return instructions
# Function: build rs
def build_rs(num):
    rs = []
    for _ in range(num):
        temp = rs_entry()
        temp.busy = 0
        rs.extend([temp])
    return rs

# Decode Instructions
def decode_instructions(binary_ins, config):
    instructions = []
    operation_names = {}
    for op in config['operations']:
        operation_names[op['bin']] = op['name']

    for bi in binary_ins:
        ins = ''
        opcode = bi[:4]
        
        # Check if load or store
        if opcode in [config['load_store']['load_bin'], config['load_store']['store_bin']]:
            # Format - Opcode 4bits, Rdst 4bits, Address 8bits
            rdst = str(int(bi[4:8], 2))
            address = str(int(bi[8:], 2))
            if opcode == config['load_store']['load_bin']:  # Load
                opcode = 'Ld'
            else:
                opcode = 'Sd'
            ins = opcode + " R" + rdst + " " + address
        elif operation_names[opcode] == 'HLT':
            ins = 'HLT'
        else:
            opcode = operation_names[opcode]
            rdst = str(int(bi[4:8], 2))
            rsrc1 = str(int(bi[8:12], 2))
            if len(bi) > 12:
                rsrc2 = str(int(bi[12:], 2))
                ins = opcode + " R" + rdst + " R" + rsrc1 + " R" + rsrc2
            else:
                ins = opcode + " R" + rdst + " R" + rsrc1
        instructions.append(ins)
    return instructions

def int2bin(val, nbits):
    val = int(val)
    binval = str(bin(val))[2:]
    if len(binval) > nbits:
        return binval[-nbits + 1:]
    else:
        n_pad = nbits - len(binval)
        pad = "0" * n_pad
        return pad + binval

def encode_instructions(instructions, config):
    bin_ins = []
    bin_names = {}
    for op in config['operations']:
        bin_names[op['name']] = op['bin']

    for ins in instructions:
        binin = ''
        ins_split = ins.split(' ')
        opcode = ins_split[0]
        
        # Check if load or store
        if opcode in ['Ld', 'Sd']:
            # Format - Opcode 4bits, Rdst 4bits, Address 8bits
            rdst_bin = int2bin(ins_split[1][1:], int(math.log(config['n_registers'], 2)))
            address_bin = int2bin(ins_split[2].split('(')[0], config['n_bits_address'])
            if opcode == 'Ld':  # Load
                opcode = config['load_store']['load_bin']
            else:
                opcode = config['load_store']['store_bin']
            binin = opcode + rdst_bin + address_bin
        elif opcode in ['HLT']:
            binin = ''
            for op in config['operations']:
                if op['name'] == 'HLT':
                    binin = op['bin'] 
        else:
            opcode = bin_names[opcode]
            rdst_bin = int2bin(ins_split[1][1:], int(math.log(config['n_registers'], 2)))
            rsrc1_bin = int2bin(ins_split[2][1:], int(math.log(config['n_registers'], 2)))
            if len(ins_split) > 3:
                rsrc2_bin = int2bin(ins_split[3][1:], int(math.log(config['n_registers'], 2)))
            else:
                rsrc2_bin = ''
            binin = opcode + rdst_bin + rsrc1_bin + rsrc2_bin
        bin_ins.append(binin)
    return bin_ins

def print_instructions(instructions):
    for ins in instructions:
        print(ins)