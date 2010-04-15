namespace SoundBlossom

class ReverbFilter(Filter):
	Source as Generator
	Decay as single
	
	def constructor(source as Generator, decay as single):
		Source = source
		Decay = decay
	
	def Render(channels as int, rate as int) as (single):
		data = Source.Render(channels, rate)
		
		accum = 0.0
		for i in range(data.Length):
			accum *= Decay
			if data[i] > 0.0:
				data[i] += accum
				accum = (accum + data[i]) / 2.0
			else:
				data[i] -= accum
				accum = (accum - data[i]) / 2.0
		print '...'
		
		return data
