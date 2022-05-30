def reducer (key, list_of_vals):
	total = 0.0
	for x in list_of_vals:
		total += x[1]
	return [(key, total/len(list_of_vals))]