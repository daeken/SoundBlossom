namespace SoundBlossom

import System

class WhiteNoiseGenerator(Generator):
	Rng as Random
	Duration as single
	
	def constructor(duration as single):
		Rng = Random()
		Duration = duration
	
	def constructor(duration as single, seed as int):
		Rng = Random(seed)
		Duration = duration
	
	def Render(channels as int, rate as int) as (single):
		data = array(single, cast(int, rate * Duration * channels))
		for i in range(data.Length):
			data[i] = (Rng.NextDouble() - 0.5) * 2.0
		return data
