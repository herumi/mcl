import sys, re, argparse

#RE_PROTOTYPE = re.compile(r'MCLBN_DLL_API\s\w\s\w\([^)]*\);')
RE_PROTOTYPE = re.compile(r'\w*\s(\w*)\s(\w*)\(([^)]*)\);')
def export_functions(modName, fileNames, reToAddUnderscore):
	if not reToAddUnderscore:
		reToAddUnderscore = r'(mclBn_init|setStr|getStr|[sS]erialize|setLittleEndian|setHashOf|hashAndMapTo|DecStr|HexStr|HashTo|blsSign|blsVerify|GetCurveOrder|GetFieldOrder|KeyShare|KeyRecover|blsSignatureRecover|blsInit)'
	reSpecialFunctionName = re.compile(reToAddUnderscore)
	if modName:
		print 'function define_exported_' + modName + '(mod) {'
	comma = ''
	for fileName in fileNames:
		with open(fileName, 'rb') as f:
			for line in f.readlines():
				p = RE_PROTOTYPE.search(line)
				if p:
					ret = p.group(1)
					name = p.group(2)
					arg = p.group(3)
					if modName:
						retType = 'null' if ret == 'void' else 'number'
						if arg == '' or arg == 'void':
							paramType = '[]'
						else:
							paramType = '[' + ("'number', " * len(arg.split(','))) + ']'
						if reSpecialFunctionName.search(name):
							exportName = '_' + name # to wrap function
						else:
							exportName = name
						print "{0} = mod.cwrap('{1}', '{2}', {3})".format(exportName, name, retType, paramType)
					else:
						print comma + "'_" + name + "'",
						if comma == '':
							comma = ','
	if modName:
		print '}'

def main():
	p = argparse.ArgumentParser('export_functions')
	p.add_argument('header', type=str, nargs='+', help='headers')
	p.add_argument('-js', type=str, nargs='?', help='module name')
	p.add_argument('-re', type=str, nargs='?', help='regular expression file to add underscore to function name')
	args = p.parse_args()

	reToAddUnderscore = ''
	if args.re:
		reToAddUnderscore = open(args.re).read().strip()
	export_functions(args.js, args.header, reToAddUnderscore)

if __name__ == '__main__':
    main()

