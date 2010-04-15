namespace SoundBlossom

class SineToneGenerator(Generator):
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
		pos = 0
		def findValue(freq as single, _pos as int):
			return Math.Sin(_pos * (1.0 / (rate / freq)) * 2 * Math.PI)
		def findSlope(freq as single) as bool:
			a = findValue(freq, pos - 1)
			b = findValue(freq, pos)
			return a > b
		
		total = 256 * channels # End padding
		for duration in Durations:
			total += rate * channels * duration
		data = array(single, total)
		off = 0
		prevNote as single
		prevNoteValue = 0.0
		for i in range(Notes.Count):
			note as single = Notes[i]
			if i != 0 and note != 0.0:
				if prevNote != 0.0:
					slope = findSlope(prevNote)
					matchVal = findValue(prevNote, pos)
					
					while slope != findSlope(note):
						pos += 1
					
					prevValue = findValue(note, pos)
					pos += 1
					while true:
						curslope = findSlope(note)
						if curslope == findSlope(note):
							val = findValue(note, pos)
							if (curslope and prevValue > matchVal and matchVal > val) or (not curslope and prevValue < matchVal and matchVal < val):
								break
							prevValue = val
						
						pos += 1
				else:
					positive = findValue(note, pos) > 0.0
					while (positive and findValue(note, pos) > 0.0) or (not positive and findValue(note, pos) < 0.0):
						pos += 1
			size = cast(int, rate * Durations[i])
			for i in range(size):
				if note == 0:
					if prevNoteValue != 0.0:
						sample = Math.Sin(pos * (1.0 / (rate / prevNote)) * 2 * Math.PI)
						if (prevValue > 0.0 and sample <= 0.0) or (prevValue < 0.0 and sample >= 0.0):
							sample = 0.0
					else:
						sample = 0.0
				else:
					sample = Math.Sin(pos * (1.0 / (rate / note)) * 2 * Math.PI)
				prevNoteValue = sample
				pos += 1
				for j in range(channels):
					data[off] = sample
					off += 1
			prevNote = note
		
		sub = 1.0 / 256
		steps = cast(int, Math.Abs(prevNoteValue / sub))
		sub = prevNoteValue / steps
		for i in range(steps):
			if prevValue > 0.0:
				prevNoteValue -= sub
			else:
				prevNoteValue += sub
			for j in range(channels):
				data[off] = prevNoteValue
				off += 1
		
		return data
