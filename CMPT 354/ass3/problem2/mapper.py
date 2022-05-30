def mapper (key, val):
	s = []

	try:
		for x in val['subnational']:
			if x['MPI National'] >= '0' and x['MPI National'] < '0.1':
				s.append(('0', key))
	
			elif x['MPI National'] >= '0.1' and x['MPI National'] < '0.2':
				s.append(('0.1', key))

			elif x['MPI National'] >= '0.2' and x['MPI National'] < '0.3':
				s.append(('0.2', key))

			elif x['MPI National'] >= '0.3' and x['MPI National'] < '0.4':
				s.append(('0.3', key))

			elif x['MPI National'] >= '0.4' and x['MPI National'] < '0.5':
				s.append(('0.4', key))

			elif x['MPI National'] >= '0.5' and x['MPI National'] < '0.6':
				s.append(('0.5', key))
		
			elif x['MPI National'] >= '0.6' and x['MPI National'] < '0.7':
				s.append(('0.6', key))
	
			elif x['MPI National'] >= '0.7' and x['MPI National'] < '0.8':
				s.append(('0.7', key))
	
			elif x['MPI National'] >= '0.8' and x['MPI National'] < '0.9':
				s.append(('0.8', key))
	
			elif x['MPI National'] >= '0.9' and x['MPI National'] <= '1':
				s.append(('0.9', key))



	except:
		s.append(('-1', key))

	

	s = list(set(s))
	return s