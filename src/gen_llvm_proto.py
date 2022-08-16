N32tbl = [6, 7, 8, 12, 16]
N64tbl = [3, 4, 6, 8]

def gen_get_ptr(t):
	name = t[0]
	retType = t[1]
	ret = t[2]
	args = t[3]
	print(f'static inline {retType} get_llvm_{name}(size_t n)')
	print('{')
	print('#ifdef MCL_USE_LLVM')
	print('	switch (n) {')
	print('	default: return 0;')
	print('#if MCL_SIZEOF_UNIT == 4')
	for i in N32tbl:
		print(f'	case {i}: return mcl_{name}{i}L;')
	print('#else')
	for i in N64tbl:
		print(f'	case {i}: return mcl_{name}{i}L;')
	print('#endif')
	print('	}')
	print('''#else
	(void)n;
	return 0;
#endif
}''')

def gen_proto(t):
	name = t[0]
	retType = t[1]
	ret = t[2]
	args = t[3]
	for i in set(N32tbl+N64tbl):
		print(f'{ret} mcl_{name}{i}L({args});')

def gen_sqr_mont_impl(suf, n):
	print(f'static inline void mcl_fp_sqrMont{suf}{n}L(Unit *z, const Unit *x, const Unit *p) {{ return mcl_fp_mont{suf}{n}L(z, x, x, p); }}')

def gen_sqr_mont(suf):
	print('#ifdef MCL_USE_LLVM')
	print('#if MCL_SIZEOF_UNIT == 4')
	for i in N32tbl:
		gen_sqr_mont_impl(suf, i)
	print('#else')
	for i in N64tbl:
		gen_sqr_mont_impl(suf, i)
	print('#endif')
	print('#endif')

void3u = 'Unit*, const Unit*, const Unit*'
void4u = 'Unit*, const Unit*, const Unit*, const Unit*'

void3uType = 'bint::void_ppp'
void4uType = 'bint::void_pppp'
tbl = [
	('fp_add', void4uType, 'void', void4u),
	('fp_sub', void4uType, 'void', void4u),
	('fp_addNF', void4uType, 'void', void4u),
	('fp_subNF', void4uType, 'void', void4u),
	('fp_mont', void4uType, 'void', void4u),
	('fp_montNF', void4uType, 'void', void4u),
	('fp_montRed', void3uType, 'void', void3u),
	('fp_montRedNF', void3uType, 'void', void3u),
	('fpDbl_add', void4uType, 'void', void4u),
	('fpDbl_sub', void4uType, 'void', void4u),
]

print('namespace mcl { namespace fp {')

print('extern "C" {')
for t in tbl:
	gen_proto(t)
print('void mcl_fp_mulNIST_P192L(Unit *, const Unit *, const Unit *, const Unit *);')
print('void mcl_fp_sqr_NIST_P192L(Unit *, const Unit *, const Unit *);')
print('void mcl_fpDbl_mod_NIST_P192L(Unit *, const Unit *, const Unit *);')
print('void mcl_fpDbl_mod_NIST_P521L(Unit *, const Unit *, const Unit *);')
print('}')

gen_sqr_mont('')
gen_sqr_mont('NF')

tbl.append(('fp_sqrMont', void3uType, 'void', void3u))
tbl.append(('fp_sqrMontNF', void3uType, 'void', void3u))

for t in tbl:
	gen_get_ptr(t)

print('}}')

