import sys, re

#RE_PROTOTYPE = re.compile(r'MCLBN_DLL_API\s\w\s\w\([^)]*\);')
RE_PROTOTYPE = re.compile(r'\w*\s(\w*)\s(\w*)\(([^)]*)\);')
RE_SPECIAL_FUNCTION_NAME = re.compile(r'(setStr|getStr|[sS]erialize|setLittleEndian|setHashOf|hashAndMapTo|DecStr|HexStr|HashTo|blsSign|blsVerify|GetCurveOrder|GetFieldOrder|KeyShare|KeyRecover|blsSignatureRecover)')
def export_functions(modName, fileNames):
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
						if RE_SPECIAL_FUNCTION_NAME.search(name):
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
	args = len(sys.argv)
	modName = ''
	if args <= 1:
		print 'export_functions [-js <modName>] header+'
		sys.exit(1)
	pos = 1
	if args >= 3 and sys.argv[1] == '-js':
		modName = sys.argv[2]
		pos = 3
	export_functions(modName, sys.argv[pos:])

if __name__ == '__main__':
    main()

			
