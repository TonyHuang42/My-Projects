def mapper (key, val):
	s = []
	try:
		if val['MPI Urban'] >= '0.1' and val['MPI Rural'] >= '0.2':
			s.append((val['Country'],(val['MPI Urban'], val['MPI Rural'])))

	except:
		pass


	return s
