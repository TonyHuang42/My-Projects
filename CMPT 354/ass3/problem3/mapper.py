def mapper (key, val):
	s = []

	try:
		if val['Headcount Ratio Urban'] >= '0' and val['Headcount Ratio Urban'] < '10':
			s.append((('H','0'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '10' and val['Headcount Ratio Urban'] < '20':
			s.append((('H','10'), (val['Country'], float(val['Intensity of Deprivation Urban']))))
		
		elif val['Headcount Ratio Urban'] >= '20' and val['Headcount Ratio Urban'] < '30':
			s.append((('H','20'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '30' and val['Headcount Ratio Urban'] < '40':
			s.append((('H','30'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '40' and val['Headcount Ratio Urban'] < '50':
			s.append((('H','40'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '50' and val['Headcount Ratio Urban'] < '60':
			s.append((('H','50'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '60' and val['Headcount Ratio Urban'] < '70':
			s.append((('H','60'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '70' and val['Headcount Ratio Urban'] < '80':
			s.append((('H','70'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '80' and val['Headcount Ratio Urban'] < '90':
			s.append((('H','80'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

		elif val['Headcount Ratio Urban'] >= '90' and val['Headcount Ratio Urban'] <= '100':
			s.append((('H','90'), (val['Country'], float(val['Intensity of Deprivation Urban']))))

	except:
		pass

	try:
		if val['Intensity of Deprivation Urban'] >= '0' and val['Intensity of Deprivation Urban'] < '10':
			s.append((('I','0'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '10' and val['Intensity of Deprivation Urban'] < '20':
			s.append((('I','10'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '20' and val['Intensity of Deprivation Urban'] < '30':
			s.append((('I','20'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '30' and val['Intensity of Deprivation Urban'] < '40':
			s.append((('I','30'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '40' and val['Intensity of Deprivation Urban'] < '50':
			s.append((('I','40'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '50' and val['Intensity of Deprivation Urban'] < '60':
			s.append((('I','50'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '60' and val['Intensity of Deprivation Urban'] < '70':
			s.append((('I','60'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '70' and val['Intensity of Deprivation Urban'] < '80':
			s.append((('I','70'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '80' and val['Intensity of Deprivation Urban'] < '90':
			s.append((('I','80'), (val['Country'], float(val['Headcount Ratio Urban']))))

		elif val['Intensity of Deprivation Urban'] >= '90' and val['Intensity of Deprivation Urban'] <= '100':
			s.append((('I','90'), (val['Country'], float(val['Headcount Ratio Urban']))))

	except:
		pass

	return s