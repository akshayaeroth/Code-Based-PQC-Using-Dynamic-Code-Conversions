import sage
from sage.all import *
import numpy as np
from sage.crypto.util import ascii_to_bin
from sage.crypto.util import bin_to_ascii
from sage.crypto.util import ascii_integer

#BCH Code generation
C = codes.BCHCode(GF(2), 15, 7, offset=1)
C = codes.BCHCode(GF(2), 15, 7, offset=1)


#Grs code generation
RS = C.bch_to_grs()

D = codes.decoders.BCHUnderlyingGRSDecoder(C)

#Generator matrix Generation
RS.generator_matrix()
e=RS.dimension()
print("Dimension : ",e)

#Taking input from User
inp = input("Enter any string : ")
print(inp)

#Binary conversion
bin = BinaryStrings()
B = ascii_to_bin(inp);
print("Converted to Binary : ",B)
list1=[int(i) for i in str(B)]
print(list1)
len=len(list1)
print("Length : ",len)
#Padding
if len % e==0:
    print("Padding not needed")
    x=B
else:
    pad= '0'
    p = len % e
    l=len+(e-p)
    x = str(B).ljust(l, pad)
    print("String After Padding : ",x)
length=((x).join(x)).count(x) + 1
print("Length After Padding : ",length)
plist=[int(i) for i in str(x)]
print(plist)
#splitting
n=length/e
print("No.of Splits : ",n)
splits = np.array_split(plist,n)
list2=[]
for i in splits:
    print("Split",i)
splits = np.array_split(plist,n)
list2=[]
#Encryption
for i in splits:
    print("Word",i)
    word = vector(GF(2),(i))
    E = codes.encoders.LinearCodeGeneratorMatrixEncoder(RS)
    A=E.encode(word)
    list2.append(A)
    print("Encoded",A)
print("List after Encoding : ",list2)
list3=[]
#Decryption
for i in list2:
    print("Encoded word",i)
    word = vector(GF(16), ((i)))
    DE =D.grs_decoder()
    G=DE.decode_to_message(word)
    list3.append(G)
    print("Decoded",G)
print("List after Decoding : ",list3)
for x in list3:
    print("splits",x)
strg=[]
for x in list3:
    for y in x:
        strg.append(y)
        print(y)
binr = ''.join(str(e) for e in strg)
print("Binary : ",binr)
bl=((binr).join(binr)).count(binr) + 1
print("length: ",bl)
z=bl-len
if z==0:
    val=binr
else:
    val=binr[:-z]
print("After Removing Padding: ",val)
word=bin_to_ascii(val)

print("Original msg : ",word)
