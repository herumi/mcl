p=21888242871839275222246405745257275088696311157297823662689037894645226208583

print("over 253 bit")
for i in range (10):
	print(i, (p * i) >> 253)

def maxarg(x):
	return x // p

print("maxarg")
for i in range(16):
	print(i, maxarg(i << 253))

