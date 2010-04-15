namespace SoundBlossom

class LowPassFilter(Filter):
	Source as Generator
	Interval as single
	Constant as single
	
	def constructor(source as Generator, interval as single, constant as single):
		Source = source
		Interval = interval
		Constant = constant
	
	def Render(channels as int, rate as int) as (single):
		data = Source.Render(channels, rate)
		
		a = Interval / (Constant + Interval)
		
		for i in range(1, data.Length):
			data[i] = a * data[i] + (1 - a) * data[i - channels]
		
		return data

class HighPassFilter(Filter):
	Source as Generator
	Interval as single
	Constant as single
	
	def constructor(source as Generator, interval as single, constant as single):
		Source = source
		Interval = interval
		Constant = constant
	
	def Render(channels as int, rate as int) as (single):
		data = Source.Render(channels, rate)
		
		a = Interval / (Constant + Interval)
		
		out = array(single, data.Length)
		for i in range(1, data.Length):
			out[i] = a * (out[i-1] + data[i] - data[i - 1])
		
		return data
