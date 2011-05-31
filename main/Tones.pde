class Tones {
  ArrayList<Tone> tones;
  int duration = 10;
  
  AudioOutput out;
  
  Tones(AudioOutput _out)
  {
    tones = new ArrayList<Tone>();
    out = _out;
  }
  
  void addTone(float freq)
  {
    Tone temp = new Tone(freq,duration);
    tones.add(temp);
    out.addSignal(temp.getSignal());
  }
  
  float addTone(MRect rect)
  {
    float freq = baseFreq*pow(2,(octaves*((height - rect.center.y)/height)));
    addTone(freq);
    return scoreForFrequency(freq,song_key,allowable);
  }
  
  void removeDeadTones()
  {
    for(int i = 0; i < tones.size(); ++i)
    {
      Tone temp = tones.get(i);
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
