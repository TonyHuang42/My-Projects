def mapper (key, val):
	s = []

	try:
		for x in val['subnational']:
			s.append((val['Country'], (val['MPI Urban'], val['MPI Rural'], x['MPI National'])))
		
	except:
		pass

	s = list(set(s))
	return s
