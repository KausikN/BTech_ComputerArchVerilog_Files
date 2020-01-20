# Imports

# Imports

# Util Functions
def GetFloatInput():
    return float(input("Enter Float Value: "))

def GetIEEEInput():
    ieeeform = IEEEFormat()
    ieeeform.Sign = input("Enter Sign: ")
    ieeeform.Exponent = input("Enter Exponent: ")
    ieeeform.Mantissa = input("Enter Mantissa: ")
    return ieeeform

def SplitFloat(floatval):
    spl = str(floatval).split('.')
    return [int(spl[0]), int(spl[1])]

def Int2Bin(intval):
    intval_int = int(intval)
    if (intval_int > 1):
        return str((Int2Bin(str(int(intval_int/2)))) + str(intval_int%2))
    else:
        return str(intval)

def Bin2Int(binval):
    decval = 0
    for i in range(len(str(binval))):
        if binval[-1] == '1':
            decval += int(2**i)
        binval = binval[:-1]
    return decval

def DecimalInt2Bin(decimalval, nbits=1):
    binval = ''

    nearestpower_10 = len(str(decimalval))
    #print("dec2bin", decimalval, nearestpower_10)
    for i in range(nbits):
        decimalval *= 2
        if (decimalval >= 10**nearestpower_10):
            binval = binval + '1'
            decimalval -= 10**nearestpower_10
            #print("iterif", binval, decimalval)
        else:
            binval = binval + '0'
            #print("iterelse", binval, decimalval)
    
    return binval

def Bin2DecimalInt(binv):
    decval = 0.0
    for i in range(len(binv)):
        decval += ((1/2)**(i+1)) * int(binv[0])
        binv = binv[1:]
    return decval

# IEEE Classes
class IEEEFormat:
    def __init__(self):
        self.Sign = ''
        self.Exponent = ''
        self.Mantissa = ''

class IEEEFloatingPrecision:
    Bits = {}

    # Half Precision
    # Sign - 1 Bit
    # Exponent - 5 Bits
    # Mantissa - 10 Bits
    Bits['Half'] = [1, 5, 10]

# Main Class
class IEEEConverter:
    def IntFloat2BinFloat(self, floatval, mantissaBits=10):
        # Split the float value
        splitfloat = SplitFloat(floatval)
        # Convert to Binary
        wholepart = int(Int2Bin(str(splitfloat[0])))
        mantissaBits -= len(str(wholepart))
        if mantissaBits > 0:
            decimalpart = DecimalInt2Bin(splitfloat[1], mantissaBits)
        else:
            decimalpart = DecimalInt2Bin(splitfloat[1])

        return [str(wholepart), decimalpart]

    def Float2IEEE(self, floatval, precision='Half'):
        ieeefloat = IEEEFormat()
        # Sign
        if (floatval <  0):
            ieeefloat.Sign = '1'
            floatval = -floatval
        else:
            ieeefloat.Sign = '0'

        exp_offset = 0

        # If no itself is like 0.002 - i.e. whiole part is 0, make exponent offset
        if (floatval < 1.0):
            while(floatval < 1.0):
                exp_offset += 1
                floatval *= 2

        BinFloat = self.IntFloat2BinFloat(floatval, IEEEFloatingPrecision.Bits[precision][2] + 1)
        joinedVal = BinFloat[0] + BinFloat[1]

        # Mantissa
        ieeefloat.Mantissa = joinedVal[1:] # Remove implicit 1.

        # Exponent
        expo = str(Int2Bin(str(len(BinFloat[0]) - 1 + 2**(IEEEFloatingPrecision.Bits[precision][1] - 1) - 1 - exp_offset))) # Offset
        if (len(expo) > IEEEFloatingPrecision.Bits[precision][1]):
            expo = expo[(len(expo) - IEEEFloatingPrecision.Bits[precision][1]):]
        
        ieeefloat.Exponent = expo

        return ieeefloat
    
    def IEEE2Float(self, ieeefloat, precision='Half'):
        # Sign
        Sign = 1.0
        if (ieeefloat.Sign ==  '1'):
            Sign = -1.0
        # Exponent
        exp = int(Bin2Int(str(int(ieeefloat.Exponent))) - (2**(IEEEFloatingPrecision.Bits[precision][1] - 1) - 1))
        fstr = ''
        if exp >= 0:
            fstr = ('1' + ieeefloat.Mantissa)[:exp+1] + '.' + ('1' + ieeefloat.Mantissa)[exp+1:]
        else:
            offset = '0' * int(-1*(exp) - 1)
            fstr = '0' + '.' + offset +  ('1' + ieeefloat.Mantissa)
        splitVals = fstr.split('.')
        floatval = float(Sign * Bin2Int(str(int(splitVals[0])))) + Sign * Bin2DecimalInt(splitVals[1])
        return floatval

    

e = IEEEConverter()

choice = input("Enter choice: ")

if choice in ['', 'f']:
    # Float to IEEE
    iefloat = e.Float2IEEE(GetFloatInput(), 'Half')
    print("Sign:", iefloat.Sign)
    print("Exponent:", iefloat.Exponent, Bin2Int(iefloat.Exponent))
    print("Mantissa:", iefloat.Mantissa, Bin2Int(iefloat.Mantissa))
    originalValue = e.IEEE2Float(iefloat, 'Half')
    print('OG', originalValue)

elif choice in ['d2b']:
    # Dec to Binary
    decval = input("Enter Integer Value: ")
    print("Bin: ", Int2Bin(decval))

elif choice in ['b2d']:
    # Binary to Dec
    binval = input("Enter Binary Value: ")
    print("Int: ", Bin2Int(binval))

else: 
    # IEEE to Float
    floatv = e.IEEE2Float(GetIEEEInput(), 'Half')
    print("Float Value:", floatv)
    originalIEEE = e.Float2IEEE(floatv, 'Half')
    print("Sign:", originalIEEE.Sign)
    print("Exponent:", originalIEEE.Exponent, Bin2Int(originalIEEE.Exponent))
    print("Mantissa:", originalIEEE.Mantissa, Bin2Int(originalIEEE.Mantissa))


        


     