def reducer (key, list_of_val):
	return [(key, max(list_of_val, key = lambda list_of_val: list_of_val[1]))]