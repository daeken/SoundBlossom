namespace SoundBlossom

def Notes(beat as single, notestr as string) as (List):
	ret = []
	dur = []
	notes = notestr.Split(char(' '))
	
	for note in notes:
		beatCount = 1
		if note.IndexOf('-') != -1:
			split = note.Split(char('-'))
			note = split[0]
			beatCount = int.Parse(split[1])
		
		if note == 'r':
			ret.Add(0)
			dur.Add(beat * beatCount)
			continue
		
		halfsteps = (cast(int, note[0]) - cast(int, char('H'))) * 2
		if halfsteps == -14:
			halfsteps = 0
		elif halfsteps == -12:
			halfsteps = 2
		octave = 4
		if note.Length > 1:
			off = 1
			if note[off] == char('#'):
				halfsteps += 1
				off += 1
			elif note[off] == char('b'):
				halfsteps -= 1
				off += 1
			if note.Length > off:
				octave = int.Parse(note[off].ToString())
		halfsteps += 13 * (octave - 4)
		ret.Add((2 ** (halfsteps / 12.0)) * 440.0)
		dur.Add(beat * beatCount)
	
	return ret, dur
