'''
Execution Functions
'''

'''
1. calculate valid instructions
    -- for ALU instructions, write results into fu_results, remove that fu entry
    -- for LD/SD, write address result immediately back to ld_sd_queue
2. fetch instructions into function unit with spare space
    -- remove ALU instructions from rs
    -- don't remove ld/sd instructions
'''

# Imports
from init import fu_entry, fu_result
from operations import ExecuteOperation

# Main Functions
# Check rs and return valid instruction index
def check_valid_ins_in_rs(rs):
    if not len(rs) == 0:
        for i in range(len(rs)):
            if (rs[i].valid_1st == 1) and (rs[i].valid_2nd == 1) and (rs[i].busy == 1):
                return i
    return -1

# Check ld_sd_queue and return valid instruction index
def check_valid_ins_in_ldsd(ldsd):
    if not len(ldsd) == 0:
        for i in range(len(ldsd)):
            if (ldsd[i].valid == 1) and (ldsd[i].ready == 0):
                return i
    return -1

# Add entry into fu
def add_entry_into_fu(fu, ins_in_rs):
    fu[-1].cycle = 0
    fu[-1].op = ins_in_rs.op
    fu[-1].value1 = ins_in_rs.value_1st
    fu[-1].value2 = ins_in_rs.value_2nd
    fu[-1].dest_tag = ins_in_rs.dest_tag

# Find ROB entry by tag
def find_ROB_entry(ROB, tag):
    for index in range(len(ROB)):
        if ROB[index].ROB_tag == tag:
            break
    return index

# Functional units execution
def fu_exe(fu, fu_results, ROB, time_fu, cycle, PC, Flags):
    if not len(fu) == 0:
        for element in fu:
            element.cycle += 1
        # write starting cycle
        if fu[-1].cycle == 1:
            index = find_ROB_entry(ROB, fu[-1].dest_tag)
            ROB[index].exe.append(cycle)
        # finish cycle
        if fu[0].cycle == time_fu:
            index = find_ROB_entry(ROB, fu[0].dest_tag)
            ROB[index].exe.append(cycle)
            # calculation result
            fu_results.append(fu_result())
            fu_results[-1].dest_tag = fu[0].dest_tag

            if (fu[0].op in ['Bne']):
                fu_results.pop()
                if fu[0].value1 == fu[0].value2:
                    PC.PC += 1
                    PC.valid = 1
                else:
                    index = find_ROB_entry(ROB, fu[0].dest_tag)
                    offset = ROB[index].dest_tag
                    PC.PC = int(PC.PC + 1 + offset/4)
                    PC.valid = 1
            else:
                fu_results[-1].value = ExecuteOperation(fu[0].op, fu[0].value1, fu[0].value2, Flags)
            # remove from fu
            fu.popleft()

# ld_sd_execution
def ld_sd_execution(ld_sd_exe, time_ld_sd_exe, ld_sd_queue, ROB, cycle):
    if ld_sd_exe.busy == 1:
        # write down starting cycle
        if ld_sd_exe.cycle == 0:
            match_element = None
            for element in ld_sd_queue:
                if element.ld_sd_tag == ld_sd_exe.dest_tag:
                    match_element = element
                    break
            index = find_ROB_entry(ROB, match_element.dest_tag)
            ROB[index].exe.append(cycle)
            # execute
            ld_sd_exe.cycle += 1
        # write address back to ld_sd_queue
        if ld_sd_exe.cycle == time_ld_sd_exe:
            address = ld_sd_exe.value1 + ld_sd_exe.value2
            for element in ld_sd_queue:
                if element.ld_sd_tag == ld_sd_exe.dest_tag:
                    element.address = address
                    element.ready = 1
                    break
            # write down finish cycle
            index = find_ROB_entry(ROB, element.dest_tag)
            ROB[index].exe.append(cycle)
            ld_sd_exe.busy = 0
        else:
            ld_sd_exe.cycle += 1

# Execute Instruction
def exe(fu, fu_time,
        results_buffer,
        rs,
        ld_sd_exe, time_ld_sd_exe, ld_sd_queue,
        cycle, ROB, PC, Flags):
    # execution in fu and ld_sd address calculation
    ld_sd_execution(ld_sd_exe, time_ld_sd_exe, ld_sd_queue, ROB, cycle)
    # functional units
    for fu_key in fu.keys():
        # print(fu[fu_key])
        fu_exe(fu[fu_key], results_buffer, ROB, fu_time[fu_key], cycle, PC, Flags)

    # fetch instructions from rs and ld_sd_queue
    # from ld_sd_queue
    # check valid ins in ld_sd_queue
    index = check_valid_ins_in_ldsd(ld_sd_queue)
    # put ins into ld_sd_exe
    if (index >= 0) and (ld_sd_exe.busy == 0):
        ld_sd_exe.busy = 1
        ld_sd_exe.cycle = 0
        ld_sd_exe.value1 = ld_sd_queue[index].reg_value
        ld_sd_exe.value2 = ld_sd_queue[index].immediate
        ld_sd_exe.dest_tag = ld_sd_queue[index].ld_sd_tag
        if ROB[find_ROB_entry(ROB, ld_sd_queue[index].dest_tag)].issue[0] < cycle:
            ld_sd_execution(ld_sd_exe, time_ld_sd_exe, ld_sd_queue, ROB, cycle)

    # from rs fetch valid instruction
    for rs_key in rs.keys():
        if check_valid_ins_in_rs(rs[rs_key]) >= 0:
            index = check_valid_ins_in_rs(rs[rs_key])
            fu[rs_key].append(fu_entry())
            add_entry_into_fu(fu[rs_key], rs[rs_key][index])
            # check if it's a waiting instruction
            if ROB[find_ROB_entry(ROB, rs[rs_key][index].dest_tag)].issue[0] < cycle:
                fu_exe(fu[rs_key], results_buffer, ROB, fu_time[rs_key], cycle, PC, Flags)
            # remove ins from rs
            rs[rs_key][index].busy = 0