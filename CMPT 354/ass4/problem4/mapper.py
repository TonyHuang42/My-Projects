def mapper (key, val):
	s = []
	
	try:
		for x in val['subnational']:
			s.append((x['World region'], (x['Country'], float(val['MPI Urban']), float(val['MPI Rural']))))

	except:
		pass


	s = list(set(s))
	return s
