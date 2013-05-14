//
//  ViewController.m
//  Mandolin
//
//  Created by Ariel on 03/11/2012.
//
//

#import "ViewController.h"
#import "mo_audio.h"


#define SRATE 44100
#define FRAMESIZE 128
#define NUMCHANNELS 2

void audioCallback( Float32 * buffer, UInt32 framesize, void* userData )
{
    AudioData * data = (AudioData*) userData;
    
    for(int i=0; i<framesize; i++)
    {
        SAMPLE out = data->myMandolin->tick();
        
        buffer[2*i] = buffer[2*i+1] = out;
        
    }
}


@interface ViewController ()

@property IBOutlet UIButton *myButton;
@property IBOutlet UILabel *myLabel;
@property IBOutlet UISlider *mySlider;

@end

@implementation ViewController


-(IBAction)sliderChanged {
    audioData.myMandolin->setFrequency(_mySlider.value);
}

-(IBAction)pluckMyMandolin{
    audioData.myMandolin->pluck(1);
    NSLog(@"plucked mandolin! last sample: %f", audioData.myMandolin->lastOut());
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initialise our audio objects:
    audioData.myMandolin = new Mandolin(400);
    
    
    // init audio
    NSLog(@"Initializing Audio");
    
    // init the MoAudio layer
    bool result = MoAudio::init(SRATE, FRAMESIZE, NUMCHANNELS);
    
    if (!result)
    {
        NSLog(@"cannot initialize real-time audio!");
        return;
    }
    
    // start the audio layer, registering a callback method
    result = MoAudio::start( audioCallback, &audioData);
    if (!result)
    {
        NSLog(@"cannot start real-time audio!");
        return;
    }
    
    
    
    //make slider prettier
    [_mySlider setThumbImage:[UIImage imageNamed:@"slider_pressed.png"] forState:UIControlStateNormal];
    [_mySlider setMaximumTrackTintColor:[UIColor blackColor]];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
