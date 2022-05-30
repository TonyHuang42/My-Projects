"""
To run this script:
	python EvenOdd.py

In order to pass the autograder your function should
return a list of even numbers given any list of integers.
If you run the above script, a correct function should return:

Even numbers are [2, 4]
"""

def getEvenNumbers(numbers):
	evens = []
	"*** Add your code in here ***"
	i = 0
	while i < len(numbers):
		if (numbers[i] % 2 == 0):
			evens.append(numbers[i])
		i += 1
	return evens


if __name__ == '__main__':
	myList = [1, 2, 3, 4, 5]
	print("Even numbers are {}".format(getEvenNumbers(myList)))