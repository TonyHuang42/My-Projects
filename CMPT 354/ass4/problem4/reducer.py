def reducer (key, list_of_vals):
	sum_urban = 0
	sum_rural = 0

	for x in list_of_vals:
		sum_urban += x[1]
		sum_rural += x[2]

	return [(key, (sum_urban/len(list_of_vals), sum_rural/len(list_of_vals)))]