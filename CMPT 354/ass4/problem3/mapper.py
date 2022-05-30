def mapper (key, val):
	s = []
	try:
		for x in val['subnational']:
			s.append((x['World region'], (x['Country'], float(x['MPI National']))))

	except:
		pass

	s = list(set(s))
	return s
