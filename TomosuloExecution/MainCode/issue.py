'''
Issue Functions
'''

"""
1. put 1 instruction in ROB
2. put this instruction in RS/ld_sd_queue
3. update RAT
"""

# Imports
from collections import namedtuple, deque
from init import ld_sd_entry, ROB_entry

# Main Functions
# Find a tag for ld_sd_entry
def find_tag_new_ldsd_entry(ld_sd_queue, size_ld_sd_queue):
    existing_tag = []
    tag_pool = []
    for i in range(len(ld_sd_queue)):
        existing_tag.append(ld_sd_queue[i].ld_sd_tag)
    for i in range(size_ld_sd_queue):
        tag_pool.append('ldsd' + str(i))
    return list(set(tag_pool)-set(existing_tag))[0]

# Put ins into ROB
def put_ins_into_ROB(ROB, size_ROB, PC, cycle, ins, ldsd_tag):
    ROB.append(ROB_entry())
    # ROB_tag
    if len(ROB) == 1:
        ROB[-1].ROB_tag = 'ROB0'
    else:
        index = ROB[-2].ROB_tag[3:]
        ROB[-1].ROB_tag = 'ROB' + str((int(index)+1) % size_ROB)
    # PC
    ROB[-1].PC = PC.PC
    # dest_tag
    if ins.split(' ')[0] == 'Sd': # SD
        ROB[-1].dest_tag = ldsd_tag
    elif ins.split(' ')[0] == 'Bne': # BNE
        ROB[-1].dest_tag = int(ins.split(' ')[-1])
    else: # ALU and LD instructions
        if len(ins.split(' ')) > 1:
            ROB[-1].dest_tag = ins.split(' ')[1]
        else:
            ROB[-1].dest_tag = 'HLT'
    # issue
    ROB[-1].issue.append(cycle)

# Put ins into reservation station
def put_ins_into_rs(station, index, ins, ROB, rat):
    entry = station[index]
    entry.busy = 1
    entry.op = ins.split(' ')[0]
    # reg 1
    register = ins.split(' ')[2] # register name
    if register[0] in ['F', 'R', 'f', 'r']:
        if (type(rat[int(register[1:])]) == str):
            entry.tag_1st = rat[int(register[1:])]
            entry.valid_1st = 0
        else:
            entry.value_1st = rat[int(register[1:])]
            entry.valid_1st = 1

    # reg 2 if exists
    if len(ins.split(' ')) == 4:
        register = ins.split(' ')[3] # register name
        if register[0] in ['F', 'R', 'f', 'r']:
            if (type(rat[int(register[1:])]) == str):
                entry.tag_2nd = rat[int(register[1:])]
                entry.valid_2nd = 0
            else:
                entry.value_2nd = rat[int(register[1:])]
                entry.valid_2nd = 1
        else: # immediate number
            entry.value_2nd = int(ins.split(' ')[3])
            entry.valid_2nd = 1
    else:
        entry.value_2nd = 0
        entry.valid_2nd = 1
    # dest_tag
    entry.dest_tag = ROB[-1].ROB_tag

# Put bne into rs
def put_bne_into_rs(station, index, ins, rat, ROB):
    entry = station[index]
    entry.busy = 1
    entry.op = ins.split(' ')[0]
    # reg 1
    register = ins.split(' ')[1] # register name
    if register[0] in ['F', 'R', 'f', 'r']:
        if (type(rat[int(register[1:])]) == str):
            entry.tag_1st = rat[int(register[1:])]
            entry.valid_1st = 0
        else:
            entry.value_1st = rat[int(register[1:])]
            entry.valid_1st = 1

    # reg 2
    register = ins.split(' ')[2] # register name
    if register[0] in ['F', 'R', 'f', 'r']:
        if (type(rat[int(register[1:])]) == str):
            entry.tag_2nd = rat[int(register[1:])]
            entry.valid_2nd = 0
        else:
            entry.value_2nd = rat[int(register[1:])]
            entry.valid_2nd = 1
    # dest_tag
    entry.dest_tag = ROB[-1].ROB_tag

# Put ins into ld_sd_queue
def put_ins_into_ldsd(ldsd_tag, ld_sd_queue, ins, ROB, rat):
    ld_sd_queue.append(ld_sd_entry())
    # ld_sd_tag
    ld_sd_queue[-1].ld_sd_tag = ldsd_tag
    ld_sd_queue[-1].ready = 0
    ld_sd_queue[-1].op = ins.split(' ')[0]
    if ld_sd_queue[-1].op == 'Sd':
        register = ins.split(' ')[1] # register name
        ld_sd_queue[-1].data = rat[int(register[1:])]
        
    ld_sd_queue[-1].dest_tag = ROB[-1].ROB_tag
    # immediate and reg value
    if ins.split(' ')[-1].find('(') == -1 and ins.split(' ')[-1].find(')') == -1:
        ld_sd_queue[-1].immediate = int(ins.split(' ')[-1])
        ld_sd_queue[-1].reg_value = 0
        ld_sd_queue[-1].valid = 1
    else:
        immediate_closing_index = int(ins.split(' ')[-1].find('(') - ins.split(' ')[-1].find(')') - 1)
        ld_sd_queue[-1].immediate = int(ins.split(' ')[-1][:immediate_closing_index])
        register = ins.split(' ')[-1][-3:-1] # register name
        if (type(rat[int(register[1:])]) == str):
            ld_sd_queue[-1].reg_tag = rat[int(register[1:])]
            ld_sd_queue[-1].valid = 0
        else:
            ld_sd_queue[-1].reg_value = rat[int(register[1:])]
            ld_sd_queue[-1].valid = 1

# Check space of reservation station
def check_rs_space(station):
    index = -1
    for i in range(len(station)):
        if station[i].busy == 0:
            index = i
            return index
    return index

# Update RAT
def update_rat(ROB, rat):
    if ROB[-1].dest_tag[0] in ['F', 'R', 'f', 'r']:
        rat[int(ROB[-1].dest_tag[1:])] = ROB[-1].ROB_tag

# Find Reservation Station Type of Operation Name
def find_rstype_of_op(opname, operations):
    # print('OPNAME', opname)
    for op in operations:
        # print('     ', op['name'])
        if opname == op['name']:
            return op['rs_type']
    return ''

# Issue Instruction
def issue(cycle, PC, instructions, ROB, size_ROB,
        rs,
        ld_sd_queue, size_ld_sd_queue,
        rat,
        config, Flags):
    # fetch 1 instruction
    ins = instructions[PC.PC]
    op = ins.split(' ')[0]
    # Decode
    # Check HALT
    if op in ['HLT']:
        # put ins into ROB
        put_ins_into_ROB(ROB, size_ROB, PC, cycle, ins, '')
        # Update PC
        PC.PC = 0
        PC.valid = 0
        Flags.HALT = 1
        return
        # quit()
    # LD/SD instructions
    if op in ['Ld', 'Sd']:
        # check space
        if (len(ROB) < size_ROB) and (len(ld_sd_queue) < size_ld_sd_queue):
            # find ldsd_tag
            ldsd_tag = find_tag_new_ldsd_entry(ld_sd_queue, size_ld_sd_queue)
            # put ins into ROB
            put_ins_into_ROB(ROB, size_ROB, PC, cycle, ins, ldsd_tag)
            # put ins into ld_sd_queue
            put_ins_into_ldsd(ldsd_tag, ld_sd_queue, ins, ROB, rat)
            # update RAT
            update_rat(ROB, rat)
            # PC
            PC.PC += 1
    # Bne
    elif (op=='Bne'):
        # check space
        if (len(ROB) < size_ROB) and (check_rs_space(rs['adder']) >= 0):
            # put ins into ROB
            put_ins_into_ROB(ROB, size_ROB, PC, cycle, ins, '')
            # put ins into rs_int_adder
            index = check_rs_space(rs['adder'])
            put_bne_into_rs(rs['adder'], index, ins, rat, ROB)
            # PC
            PC.valid = 0
    # Operation instructions
    else:
        # check space
        if (len(ROB) < size_ROB) and (check_rs_space(rs[find_rstype_of_op(op, config['operations'])]) >= 0):
            # put ins into ROB
            put_ins_into_ROB(ROB, size_ROB, PC, cycle, ins, '')
            # put ins into rs
            index = check_rs_space(rs[find_rstype_of_op(op, config['operations'])])
            put_ins_into_rs(rs[find_rstype_of_op(op, config['operations'])], index, ins, ROB, rat)
            # update RAT
            update_rat(ROB, rat)
            # PC
            PC.PC += 1