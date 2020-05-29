'''
WriteBack Functions
'''

'''
1. broadcast data on cdb
2. fetch data from results queue
3. remove entry in results queue

'''

# Main Functions
# Find ROB entry by tag
def find_ROB_entry(ROB, tag):
    for index in range(len(ROB)):
        if ROB[index].ROB_tag == tag:
            break
    return index

# Broadcast
# rat_int, rat_fp, reservation stations, ld_sd_queue, ROB
def broadcast(cdb, rat,
                rs,
                ld_sd_queue, ROB, cycle):
    # dest_tag
    dest_tag = cdb.dest_tag
    index = find_ROB_entry(ROB, dest_tag)
    reg_tag = ROB[index].dest_tag
    # rat
    if reg_tag[0] in ['F', 'R', 'f', 'r']:
        rat[int(reg_tag[1:])] = cdb.value
    # rs
    for rs_key in rs.keys():
        for element in rs[rs_key]:
            if (element.tag_1st == dest_tag) and (element.valid_1st == 0):
                element.value_1st = cdb.value
                element.valid_1st = 1
            if (element.tag_2nd == dest_tag) and (element.valid_2nd == 0):
                element.value_2nd = cdb.value
                element.valid_2nd = 1
    # ld_sd_queue
    for element in ld_sd_queue:
        if (element.data == dest_tag) and (element.op == 'Sd'):
            element.data = cdb.value
        if (element.reg_tag == dest_tag) and (element.valid == 0):
            element.reg_value = cdb.value
            element.valid = 1
    # ROB
    for element in ROB:
        if element.ROB_tag == dest_tag:
            element.value = cdb.value
            element.cdb.append(cycle)

# wb Function
def wb(cdb, rat,
        rs,
        ld_sd_queue, ROB, cycle,
        results_buffer):
    # broadcast
    if cdb.valid == 1:
        broadcast(cdb, rat,
                    rs,
                    ld_sd_queue, ROB, cycle)
        cdb.valid = 0
    # fetch data from results queue
    if cdb.valid == 0:
        if len(results_buffer) > 0:
            cdb.valid = 1
            cdb.value = results_buffer[0].value
            cdb.dest_tag = results_buffer[0].dest_tag
            results_buffer.popleft()