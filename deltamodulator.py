

# 1-byte subtractor block
def sub(sample, delay):
	
	integer_sum = int(sample, 8) - int(delay,8)
	binary_sum = bin(integer_sum)
	return binary_sum

def deltamod(data):
	output = ""
	delay = "00000000" # previous value
	for byte in data:
		ans = sub(byte, delay)
		if int(ans) >= int(delay):
			output += "1"
		else:
			output += "0"
		
		delay = ans

	return output







def main():
	#simulated steps
	eg1 = "00000000"
	eg2 = "10011101"
	eg3 = "10110101"
	eg4 = "01110110"
	eg5 = "10100110"
	eg6 = "10110101"
	eg7 = "10111101"
	eg8 = "01110101"
	data = [eg1, eg2, eg3, eg4, eg5, eg6, eg7, eg8] # x[n] input signal

	result = deltamod(data)

	print(result)


if __name__ == '__main__':
	main()