namespace SoundBlossom

abstract class Filter(Generator):
	abstract def Render(channels as int, rate as int) as (single):
		pass
