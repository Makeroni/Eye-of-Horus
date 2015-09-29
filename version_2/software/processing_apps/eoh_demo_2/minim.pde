// import everything necessary to make sound.
import ddf.minim.*;
import ddf.minim.ugens.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;

Oscil      wave;
// keep track of the current Frequency so we can display it
Frequency  currentFreq;

void minim_setup()
{
  // initialize the minim and out objects
  minim = new Minim(this);
  out   = minim.getLineOut();

  currentFreq = Frequency.ofPitch( "A4" );
  wave = new Oscil( currentFreq, 0.6f, Waves.SINE );
  
  wave.patch( out );
}

void change_frequency(int freq )
{
  //currentFreq = Frequency.ofPitch( "E6" );
  
  // note that there are two other static methods for constructing Frequency objects
  currentFreq = Frequency.ofHertz( freq );
  // currentFreq = Frequency.ofMidiNote( 69 ); 
  
  wave.setFrequency( currentFreq );
}


