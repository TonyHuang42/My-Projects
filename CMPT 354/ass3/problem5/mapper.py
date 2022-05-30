def mapper (key, val):
	s = []

	try: 
		for x in val['subnational']:

			if x['Headcount Ratio Regional'] >= '0' and x['Headcount Ratio Regional'] < '10':
				s.append((('H','0'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '10' and x['Headcount Ratio Regional'] < '20':
				s.append((('H','10'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))
			
			elif x['Headcount Ratio Regional'] >= '20' and x['Headcount Ratio Regional'] < '30':
				s.append((('H','20'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '30' and x['Headcount Ratio Regional'] < '40':
				s.append((('H','30'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '40' and x['Headcount Ratio Regional'] < '50':
				s.append((('H','40'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '50' and x['Headcount Ratio Regional'] < '60':
				s.append((('H','50'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '60' and x['Headcount Ratio Regional'] < '70':
				s.append((('H','60'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '70' and x['Headcount Ratio Regional'] < '80':
				s.append((('H','70'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '80' and x['Headcount Ratio Regional'] < '90':
				s.append((('H','80'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

			elif x['Headcount Ratio Regional'] >= '90' and x['Headcount Ratio Regional'] <= '100':
				s.append((('H','90'), (x['Country'], x['Sub-national region'], float(x['Intensity of deprivation Regional']))))

	except:
		pass

	try:
		for x in val['subnational']:

			if x['Intensity of deprivation Regional'] >= '0' and x['Intensity of deprivation Regional'] < '10':
				s.append((('I','0'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '10' and x['Intensity of deprivation Regional'] < '20':
				s.append((('I','10'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '20' and x['Intensity of deprivation Regional'] < '30':
				s.append((('I','20'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '30' and x['Intensity of deprivation Regional'] < '40':
				s.append((('I','30'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '40' and x['Intensity of deprivation Regional'] < '50':
				s.append((('I','40'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '50' and x['Intensity of deprivation Regional'] < '60':
				s.append((('I','50'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '60' and x['Intensity of deprivation Regional'] < '70':
				s.append((('I','60'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '70' and x['Intensity of deprivation Regional'] < '80':
				s.append((('I','70'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '80' and x['Intensity of deprivation Regional'] < '90':
				s.append((('I','80'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

			elif x['Intensity of deprivation Regional'] >= '90' and x['Intensity of deprivation Regional'] <= '100':
				s.append((('I','90'), (x['Country'], x['Sub-national region'], float(x['Headcount Ratio Regional']))))

	except:
		pass

	return s