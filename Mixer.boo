namespace SoundBlossom

class Mixer(Generator):
	Streams as List
	
	def constructor():
		Streams = []
	
	def Add(stream as Generator):
		Streams.Add(stream)
	
	def Render(channels as int, rate as int) as (single):
		sdata = []
		size = 0
		for i in range(Streams.Count):
			subdata = cast(Generator, Streams[i]).Render(channels, rate)
			sdata.Add(subdata)
			if subdata.Length > size:
				size = subdata.Length
		
		data = array(single, size)
		print data.Length
		for i in range(data.Length):
			count = 0
			value as double = 0.0
			for subdata as (single) in sdata:
				if subdata.Length > i:
					count += 1
					value += subdata[i]
			if count != 0:
				data[i] = cast(single, value / count)
		return data
