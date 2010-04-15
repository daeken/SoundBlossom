namespace SoundBlossom

abstract class Generator:
	abstract def Render(channels as int, rate as int) as (single):
		pass
