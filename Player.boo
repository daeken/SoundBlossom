namespace SoundBlossom

import System
import System.IO
import System.Media

class Player:
	Channels as int
	Rate as int
	
	def constructor(channels as int, rate as int):
		Channels = channels
		Rate = rate
	
	def Play(generator as Generator):
		data = generator.Render(Channels, Rate)
		
		ms = MemoryStream()
		bw = BinaryWriter(ms)
		
		bw.Write(0x46464952)
		bw.Write(36 + (data.Length * 4))
		bw.Write(0x45564157)
		
		bw.Write(0x20746D66)
		bw.Write(16)
		bw.Write(cast(short, 3))
		bw.Write(cast(short, Channels))
		bw.Write(Rate)
		bw.Write(Channels * Rate * 4)
		bw.Write(cast(short, Channels * 4))
		bw.Write(cast(short, 32))
		
		bw.Write(0x61746164)
		bw.Write(data.Length * 4)
		for sample in data:
			bw.Write(cast(single, sample))
		
		pdata = ms.ToArray()
		bw.Close()
		ms.Close()
		
		File.OpenWrite('test.wav').Write(pdata, 0, pdata.Length)
		
		ms = MemoryStream(pdata)
		player = SoundPlayer(ms)
		player.PlaySync()
