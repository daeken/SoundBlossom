namespace SoundBlossom

class TriToneGenerator(Generator):
	Notes as List
	Durations as (single)
	
	def constructor(notes as List, duration as single):
		Notes = notes
		Durations = array(single, notes.Count)
		for i in range(notes.Count):
			Durations[i] = duration
	
	def constructor(notes as List, durations as List):
		Notes = notes
		Durations = array(single, durations.Count)
		for i in range(Durations.Length):
			Durations[i] = durations[i]
	
	def Render(channels as int, rate as int) as (single):
		total = 0
		for duration in Durations:
			total += rate * channels * duration
		data = array(single, total)
		off = 0
		pos = 0
		for i in range(Notes.Count):
			note as single = Notes[i]
			size = cast(int, rate * Durations[i])
			if note == 0:
				ramp = 0
				steps = 0.0
			else:
				ramp = cast(int, rate / note)
				steps = 2.0 / ramp
			for j in range(size):
				if note == 0:
					sample = 0.0
				else:
					sample = ((pos % (ramp*2)) - ramp) * steps
					pos += 1
					if sample > 1.0:
						sample = 2.0 - sample
					elif sample < -1.0:
						sample = -2.0 - sample
				for k in range(channels):
					data[off] = sample
					off += 1
		
		return data
