def put(L):
	print(f'L={L}')
	x=(1<<L)-1
	def diff(k):
		y = 1 << k
		d = x - (x // (y+1)) * y
		print(k,hex(d), d/y)

	for k in range(L):
		diff(k)

put(32)
put(64)