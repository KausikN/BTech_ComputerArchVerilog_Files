'''
Operation Functions
'''

# Imports


# Main Functions
def ExecuteOperation(opname, op1, op2, Flags=None):
    # print(Flags)
    if opname in ['ADD', 'ADDI', 'FADD']:
        return op1 + op2
    elif opname in ['ADC']:
        return op1 + op2 + Flags.CF
    elif opname in ['SUB', 'FSUB']:
        return op1 - op2
    elif opname in ['SBB']:
        return op1 - op2 - 1
    elif opname in ['MUL', 'FMUL']:
        return op1 * op2
    elif opname in ['CMP']:
        return ~op1
    elif opname in ['XOR']:
        return op1 ^ op2
    elif opname in ['NAND']:
        return ~(op1 & op2)
    elif opname in ['SHR']:
        return op1 >> op2
    elif opname in ['LHR']:
        return op1 << op2