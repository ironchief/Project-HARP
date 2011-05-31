class Tones {
  ArrayList tones;
  int duration = 10;
  
  AudioOutput out;

  int octaves = 3;
  int baseFreq = 220;
  
  Tones(AudioOutput _out)
  {
    tones = new ArrayList();
    out = _out;
  }
  
  void addTone(float freq)
  {
    Tone temp = new Tone(freq,duration);
    tones.add(temp);
    out.addSignal(temp.getSignal());
  }
  
  void addTone(MRect rect)
  {
    float freq = baseFreq*pow(2,(octaves*((height - rect.center.y)/height)));
    addTone(freq);
  }
  
  void removeDeadTones()
  {
    for(int i = 0; i < tones.size(); ++i)
    {
      Tone temp = (Tone)tones.get(i);
      temp.live();
      if(temp.isDead())
      {
        removeTone(temp);
        tones.remove(i);
      }
    }
  }
  
  void removeTone(Tone tone)
  {
    out.removeSignal(tone.getSignal());
    
  }
  
}
