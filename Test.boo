import SoundBlossom
import System

generator as Generator
mixer = Mixer()
# We choose zero polys and shaders
notes, durations = Notes(0.1, 'F4-2 C5-2 F4-2 C5-2 D#5-2 r-2 D#4-2 r-2 D#4-2 G#4-2 D#4-2 G#4-2 D#4-2 G#4-2 G#4-2 G-2')
mixer.Add(SineToneGenerator(notes, durations))
mixer.Add(SawToneGenerator(notes, durations))
mixer.Add(TriToneGenerator(notes, durations))
generator = mixer
generator = PingPongFilter(generator, 0.1)

player = Player(2, 44100)
player.Play(generator)
