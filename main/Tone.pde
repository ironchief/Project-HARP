class Tone {

  float freq;
  int frames;
  SineWave signal;
  int sample = 44100;
  float amp;
  
  void live()
  {
    frames--;
  }
  
  boolean isDead()
  {
    return frames < 0;
  }
  
  Tone(float _freq, int _duration)
  {
    frames = _duration;
    freq = _freq;
    float maxFreq = baseFreq * pow(2,octaves);
    amp = 1.4*((maxFreq-freq)/maxFreq)+.7;
    signal = new SineWave(_freq, amp, sample);
  }
  
  SineWave getSignal()
  {
    return signal;
  }  

}
