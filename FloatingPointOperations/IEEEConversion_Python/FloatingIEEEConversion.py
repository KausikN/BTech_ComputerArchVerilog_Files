# Imports

# Imports

# Util Functions
def GetFloatInput():
    return float(input("Enter Float Value: "))

def SplitFloat(floatval):
    spl = str(floatval).split('.')
    return [int(spl[0]), int(spl[1])]

def Int2Bin(intval):
    if (intval > 1):
        return int((10*Int2Bin(intval/2)) + (intval%2))
    else:
        return int(intval)

def Bin2Int(binval):
    decval = 0
    for i in range(len(str(binval))):
        decval += int((2**i) * (binval%10))
        binval = int(binval/10)
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
        wholepart = Int2Bin(splitfloat[0])
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
        else:
            ieeefloat.Sign = '0'

        BinFloat = self.IntFloat2BinFloat(floatval, IEEEFloatingPrecision.Bits[precision][2] + 1)
        joinedVal = BinFloat[0] + BinFloat[1]

        # Mantissa
        ieeefloat.Mantissa = joinedVal[1:] # Remove implicit 1.

        # Exponent
        expo = str(Int2Bin(len(BinFloat[0]) - 1 + 2**(IEEEFloatingPrecision.Bits[precision][1] - 1) - 1)) # Offset
        if (len(expo) > IEEEFloatingPrecision.Bits[precision][1]):
            expo = expo[(len(expo) - IEEEFloatingPrecision.Bits[precision][1]):]
        ieeefloat.Exponent = expo

        return ieeefloat
    
    def IEEE2Float(self, ieeefloat, precision='Half'):
        exp = int(Bin2Int(int(ieeefloat.Exponent)) - (2**(IEEEFloatingPrecision.Bits[precision][1] - 1) - 1))
        fstr = ('1' + ieeefloat.Mantissa)[:exp+1] + '.' + ('1' + ieeefloat.Mantissa)[exp+1:]
        splitVals = fstr.split('.')
        return float(Bin2Int(int(splitVals[0]))) + Bin2DecimalInt(splitVals[1])

    

e = IEEEConverter()
iefloat = e.Float2IEEE(GetFloatInput(), 'Half')
print("Sign:", iefloat.Sign)
print("Exponent:", iefloat.Exponent, Bin2Int(int(iefloat.Exponent)))
print("Mantissa:", iefloat.Mantissa, Bin2Int(int(iefloat.Mantissa)))
originalValue = e.IEEE2Float(iefloat, 'Half')
print('OG', originalValue)

        


     