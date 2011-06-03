// takes frequency in hz,
// converts to half step value
// relative to any octave
float freqToHalfStep(float f, float song_key) {
  return 12*log2(f/halfStepToFreq(song_key));
}

float log2(float num) {
  return (float)(Math.log(num)/Math.log(2));
}

// returns frequency of num half_steps above base frequency
float halfStepToFreq(float half_steps) {
  return (float)(440*(Math.pow(2, (half_steps/12)))); // using A-440 as base freq
}  

// takes key of BLUES song,
// returns allowable half step intervals
Vector<Double> allowedStepsForBlues(float k) { 
  Vector<Double> steps = new Vector<Double>();
  steps.addElement((double)0);
  steps.addElement((double)3);
  steps.addElement((double)6);
  steps.addElement((double)9);
  steps.addElement((double)13);
  return steps;
}

double normalizeScore(double raw_score, Vector<Double>allowable_steps){
  // get the max difference between allowable steps
  Vector<Double> diffs = new Vector<Double>();
  for(int i=0; i<allowable_steps.size()-1; ++i){
     diffs.addElement((allowable_steps.elementAt(i+1)-allowable_steps.elementAt(i))/2);
  }
  double max_val = Collections.max(diffs);
  return raw_score/max_val;
}

// returns a 0-6 score for a user's selected frequency
float scoreForFrequency(float user_freq, float song_key, Vector<Double> allowable_steps) {
  // find the user's half-step value
  float half_step = freqToHalfStep(user_freq, song_key)%13;

  Vector<Double> errors = new Vector<Double>();
  for (int i=0; i<allowable_steps.size(); ++i) {
    errors.addElement(Math.abs(half_step) - Math.abs(allowable_steps.elementAt(i))%13);
  }
  
  // find min
  int min_index=0;
  double min_error=6;
  for (int j=0; j<errors.size();++j){
    if(Math.abs(errors.elementAt(j))<Math.abs(min_error)){
      min_error = (double)errors.elementAt(j);
      min_index=j; 
    }
  }

  // return score for value with min error
  // (e.g., value that is closest to the 
  // an allowable value of half steps)
  return (float)((double)errors.elementAt(min_index));
}
