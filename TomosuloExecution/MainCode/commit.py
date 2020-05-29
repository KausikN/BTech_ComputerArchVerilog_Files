'''
Commit Functions
'''

'''
1. commit ROB_buffer
2. fetch header into ROB_buffer
'''

# Main Functions
# Print ROB entry
def print_ROB(entry, instructions):
    item = instructions[entry.PC].ljust(30)
    item += str(entry.issue).ljust(15)
    item += str(entry.exe).ljust(15)
    item += str(entry.mem).ljust(15)
    item += str(entry.cdb).ljust(15)
    item += str(entry.commit)
    print(item)

# Modify architectual reg
def modify_arch_reg(entry, reg):
    if entry.dest_tag[0] in ['F', 'R', 'f', 'r']:
        reg[int(entry.dest_tag[1:])] = entry.value

# Commit Instruction
def commit(ROB, reg, cycle, instructions):
    if len(ROB) > 0:
        if instructions[ROB[0].PC].split(' ')[0] == 'Bne':
            if not len(ROB[0].exe) == 0:
                entry = ROB.popleft()
                print_ROB(entry, instructions)
        else:#if (len(ROB) > 0):# and (not instructions[ROB[0].PC].split(' ')[0] == 'Bne'):
            if not len(ROB[0].cdb) == 0: # broadcasted instructions
                ROB[0].commit.append(cycle+1)
                entry = ROB.popleft()
                modify_arch_reg(entry, reg)
                print_ROB(entry, instructions)
            elif not len(ROB[0].commit) == 0: # Sd
                entry = ROB.popleft()
                print_ROB(entry, instructions)
                if len(ROB) > 0:
                    if not len(ROB[0].cdb) == 0: # broadcasted instructions
                        ROB[0].commit.append(cycle+1)
                        entry = ROB.popleft()
                        modify_arch_reg(entry, reg)
                        print_ROB(entry, instructions)