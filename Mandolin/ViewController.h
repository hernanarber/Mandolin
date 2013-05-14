//
//  ViewController.h
//  Mandolin
//
//  Created by Ariel on 03/11/2012.
//
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#include "Stk.h"
#include "Mandolin.h"

using namespace stk;
struct AudioData{
	Mandolin *myMandolin;
};

@interface ViewController : UIViewController{

    struct AudioData audioData;
}

-(IBAction)pluckMyMandolin;


@end
