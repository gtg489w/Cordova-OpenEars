#import "CDVOpenEars.h"

@implementation CDVOpenEars

-(void)initialize {
    self.fliteController = [[OEFliteController alloc] init];
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    self.openEarsEventsObserver.delegate = self;
    self.slt = [[Slt alloc] init];
    
    [self.openEarsEventsObserver setDelegate:self]; // Make this class the delegate of OpenEarsObserver so we can get all of the messages about what OpenEars is doing.
    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil]; // Call this before setting any OEPocketsphinxController characteristics
    
    // This is the language model we're going to start up with. The only reason I'm making it a class property is that I reuse it a bunch of times in this example,
    // but you can pass the string contents directly to OEPocketsphinxController:startListeningWithLanguageModelAtPath:dictionaryAtPath:languageModelIsJSGF:
    
    NSArray *firstLanguageArray = @[@"BACKWARD",
                                    @"CHANGE",
                                    @"FORWARD",
                                    @"GO",
                                    @"LEFT",
                                    @"MODEL",
                                    @"RIGHT",
                                    @"TURN"];
    
    OELanguageModelGenerator *languageModelGenerator = [[OELanguageModelGenerator alloc] init];
    
    // languageModelGenerator.verboseLanguageModelGenerator = TRUE; // Uncomment me for verbose language model generator debug output.
    
    NSError *error = [languageModelGenerator generateLanguageModelFromArray:firstLanguageArray withFilesNamed:@"FirstOpenEarsDynamicLanguageModel" forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]];
    
    /*if(error) {
        NSLog(@"Dynamic language generator reported error %@", [error description]);
    } else {
        self.pathToFirstDynamicallyGeneratedLanguageModel = [languageModelGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
        self.pathToFirstDynamicallyGeneratedDictionary = [languageModelGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
    }*/
    
    
    if(error) {
        NSLog(@"Dynamic language generator reported error %@", [error description]);
    }   else {
        
        NSLog(@"\n\nApp initialized!!!!!!!!");
        
        // This is how to start the continuous listening loop of an available instance of OEPocketsphinxController. We won't do this if the language generation failed since it will be listening for a command to change over to the generated language.
        
        [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil]; // Call this once before setting properties of the OEPocketsphinxController instance.
        
        //   [OEPocketsphinxController sharedInstance].pathToTestFile = [[NSBundle mainBundle] pathForResource:@"change_model_short" ofType:@"wav"];  // This is how you could use a test WAV (mono/16-bit/16k) rather than live recognition. Don't forget to add your WAV to your app bundle.
        
//        if(![OEPocketsphinxController sharedInstance].isListening) {
//            [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:self.pathToFirstDynamicallyGeneratedLanguageModel dictionaryAtPath:self.pathToFirstDynamicallyGeneratedDictionary acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:FALSE]; // Start speech recognition if we aren't already listening.
//        }
        // [self startDisplayingLevels] is not an OpenEars method, just a very simple approach for level reading
        // that I've included with this sample app. My example implementation does make use of two OpenEars
        // methods: the pocketsphinxInputLevel method of OEPocketsphinxController and the fliteOutputLevel
        // method of fliteController.
        //
        // The example is meant to show one way that you can read those levels continuously without locking the UI,
        // by using an NSTimer, but the OpenEars level-reading methods
        // themselves do not include multithreading code since I believe that you will want to design your own
        // code approaches for level display that are tightly-integrated with your interaction design and the
        // graphics API you choose.
    }

}



-(void)startListening:(CDVInvokedUrlCommand*)command{
//    [self.pocket_sphinx_controller stopListening];
    NSLog(@"Called start listening!");
}

-(void)stopListening:(CDVInvokedUrlCommand*)command{
//    [self.pocket_sphinx_controller stopListening];
    NSLog(@"Called stop listening!");
}



/*
 *  Cleanup
 */
-(void) dealloc {
    self.openEarsEventsObserver.delegate = nil;
}

@end