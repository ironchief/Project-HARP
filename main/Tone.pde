class Tone {

  float freq;
  int frames;
  SineWave signal;
  float amp = .7;
  int sample = 44100;
  
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
    signal = new SineWave(_freq, amp, sample);
  }
  
  SineWave getSignal()
  {
    return signal;
  }  

}
