namespace SoundBlossom

class PingPongFilter(Filter):
	Source as Generator
	Speed as single
	
	def constructor(source as Generator, speed as single):
		Source = source
		Speed = speed
	
	def Render(channels as int, rate as int) as (single):
		data = Source.Render(channels, rate)
		if channels != 2:
			return data
		
		pan = 0.0
		off = 1.0 / (Speed * rate)
		for i in range(0, data.Length, 2):
			data[i] *= 1.0 - pan
			data[i+1] *= pan
			
			pan += off
			if pan >= 1.0 or pan <= -1.0:
				off = -off
		
		return data
