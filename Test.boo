import SoundBlossom
import System

generator as Generator
mixer = Mixer()
# We choose zero polys and shaders
notes, durations = Notes(0.1, 'F4-2 C5-2 F4-2 C5-2 D#5-2 r-2 D#4-2 r-2 D#4-2 G#4-2 D#4-2 G#4-2 D#4-2 G#4-1 G#4-1 G4-3')
#mixer.Add(SineToneGenerator(notes, durations))
mixer.Add(SawToneGenerator(notes, durations))
#mixer.Add(TriToneGenerator(notes, durations))

#notes, durations = Notes(2.0, 'C2 C3 C4 C5 C6 C7')
#mixer.Add(SineToneGenerator(notes, durations))
#notes, durations = Notes(1.5, 'E2 E3 E4 E5 E6 E7 E5 E6')
#mixer.Add(SineToneGenerator(notes, durations))
#notes, durations = Notes(1.0, 'G2 G3 G4 G5 G6 G7 G2 G3 G4 G5 G6 G7')
#mixer.Add(SineToneGenerator(notes, durations))

generator = mixer
#generator = PingPongFilter(generator, 0.1)
#generator = ReverbFilter(generator, 0.75)
generator = HighPassFilter(generator, 0.5, 1.0)

player = Player(2, 44100)
player.Play(generator)
