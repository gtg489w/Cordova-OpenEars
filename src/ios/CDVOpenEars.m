#import "CDVOpenEars.h"

@implementation CDVOpenEars

-(void)initialize:(CDVInvokedUrlCommand*)command{
    NSLog(@"OpenEars initialize called");
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
    
    if(error) {
        NSLog(@"Dynamic language generator reported error %@", [error description]);
    }   else {
        
        NSLog(@"\n\nApp initialized!!!!!!!!");
        
        // This is how to start the continuous listening loop of an available instance of OEPocketsphinxController. We won't do this if the language generation failed since it will be listening for a command to change over to the generated language.
        [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil]; // Call this once before setting properties of the OEPocketsphinxController instance.
    }

}



-(void)startListening:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called start listening");

    NSArray *firstLanguageArray = @[@"BACKWARD",
                                    @"CHANGE",
                                    @"FORWARD",
                                    @"GO",
                                    @"LEFT",
                                    @"MODEL",
                                    @"RIGHT",
                                    @"TURN"];
    OELanguageModelGenerator *languageModelGenerator = [[OELanguageModelGenerator alloc] init]; 

    NSError *error = [languageModelGenerator generateLanguageModelFromArray:firstLanguageArray withFilesNamed:@"FirstOpenEarsDynamicLanguageModel" forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"]]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" in order to create a language model for Spanish recognition instead of English.
    
    if(error) {
        NSLog(@"Dynamic language generator reported error %@", [error description]);    
    } else {
        self.pathToFirstDynamicallyGeneratedLanguageModel = [languageModelGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
        self.pathToFirstDynamicallyGeneratedDictionary = [languageModelGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"FirstOpenEarsDynamicLanguageModel"];
    }
    
    if(![OEPocketsphinxController sharedInstance].isListening) {
        [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:self.pathToFirstDynamicallyGeneratedLanguageModel dictionaryAtPath:self.pathToFirstDynamicallyGeneratedDictionary acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:FALSE]; // Start speech recognition if we aren't already listening.
    }
}

-(void)stopListening:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called stop listening");
    if([OEPocketsphinxController sharedInstance].isListening) { // Stop if we are currently listening.
        NSError *error = nil;
        error = [[OEPocketsphinxController sharedInstance] stopListening];
        if(error)NSLog(@"Error stopping listening in stopButtonAction: %@", error);
    }
}

- (void)suspendRecognition:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called suspend recognition");
    [[OEPocketsphinxController sharedInstance] suspendRecognition];
}

- (void)resumeRecognition:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called resume recognition");
    [[OEPocketsphinxController sharedInstance] resumeRecognition];
}

- (void)changeLanguageModelToFile:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called change language model to file");
}

- (void)say:(CDVInvokedUrlCommand*)command{
    NSLog(@"Called say");
}




/*
 *  Events
 */
- (void) audioSessionInterruptionDidBegin {
    NSLog(@"Pocketsphinx audio session interruption");
    [self.commandDelegate evalJs:@"OpenEars.events.audioSessionInterruptionDidBegin()"];
}

- (void) audioSessionInterruptionDidEnd {
    NSLog(@"Pocketsphinx audio session interruption ended");
    [self.commandDelegate evalJs:@"OpenEars.events.audioSessionInterruptionDidEnd()"];
}

- (void) audioInputDidBecomeUnavailable {
    NSLog(@"Pocketsphinx audio input became unavailable");
    [self.commandDelegate evalJs:@"OpenEars.events.audioInputDidBecomeUnavailable()"];
}

- (void) audioInputDidBecomeAvailable {
    NSLog(@"Pocketsphinx audio input became available");
    [self.commandDelegate evalJs:@"OpenEars.events.audioInputDidBecomeAvailable()"];
}

- (void) audioRouteDidChangeToRoute:(NSString *)newRoute {
    NSLog(@"Pocketsphinx audio route changed and is now %@", newRoute);
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.audioRouteDidChangeToRoute(\"%@\");",newRoute];
    [self.commandDelegate evalJs:jsString];
}

- (void) pocketsphinxRecognitionLoopDidStart {
    NSLog(@"Pocketsphinx started recognition loop");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxRecognitionLoopDidStart()"];
}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx started listening");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidStartListening()"];
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx speech detected");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidDetectSpeech()"];
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    NSLog(@"Pocketsphinx detected finished speech");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidDetectFinishedSpeech()"];
}

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"Pocketsphinx received a hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.pocketsphinxDidReceiveHypothesis(\"%@\",%@,%@);",hypothesis,recognitionScore,utteranceID];
    [self.commandDelegate evalJs:jsString];
}

- (void) pocketsphinxDidReceiveNBestHypothesisArray {
    NSLog(@"Pocketsphinx received best hypothesis array");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidReceiveNBestHypothesisArray()"];
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx stopped listening");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidStopListening()"];
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx suspended recognition");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidSuspendRecognition()"];
}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx resumed recognition");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxDidResumeRecognition()"];
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    NSLog(@"Pocketsphinx changed language model to file: %@ and dictionary %@", newLanguageModelPathAsString, newDictionaryPathAsString);
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.pocketsphinxDidChangeLanguageModelToFile(\"%@\",\"%@\");",newLanguageModelPathAsString,newDictionaryPathAsString];
    [self.commandDelegate evalJs:jsString];
}

- (void) pocketSphinxContinuousSetupDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Pocketsphinx continuous setup failed because %@", reasonForFailure);
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.pocketSphinxContinuousSetupDidFailWithReason(\"%@\");",reasonForFailure];
    [self.commandDelegate evalJs:jsString];
}

- (void) pocketSphinxContinuousTeardownDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Pocketsphinx continuous teardown failed because %@", reasonForFailure);
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.pocketSphinxContinuousTeardownDidFailWithReason(\"%@\");",reasonForFailure];
    [self.commandDelegate evalJs:jsString];
}

- (void) pocketsphinxTestRecognitionCompleted {
    NSLog(@"Pocketsphinx test recognition completed");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxTestRecognitionCompleted()"];
}

- (void) pocketsphinxFailedNoMicPermissions {
    NSLog(@"Pocketsphinx doesnt have mic permissions");
    [self.commandDelegate evalJs:@"OpenEars.events.pocketsphinxFailedNoMicPermissions()"];
}

- (void) micPermissionCheckCompleted:(BOOL)result {
    if(result) {
        NSLog(@"Pocketsphinx completed mic check 1, 2, mic check 1, 2 with a result of true");
    } else {
        NSLog(@"Pocketsphinx completed mic check 1, 2, mic check 1, 2 with a result of false");
    }
    NSString* jsString = [[NSString alloc] initWithFormat:@"OpenEars.events.micPermissionCheckCompleted(%@,%@);",result];
    [self.commandDelegate evalJs:jsString];
}

- (void) fliteDidStartSpeaking {
    NSLog(@"Pocketsphinx speaking started");
    [self.commandDelegate evalJs:@"OpenEars.events.fliteDidStartSpeaking()"];
}

- (void) fliteDidFinishSpeaking {
    NSLog(@"Pocketsphinx speaking finished");
    [self.commandDelegate evalJs:@"OpenEars.events.fliteDidFinishSpeaking()"];
}



/*
 *  Cleanup
 */
-(void) dealloc {
    self.openEarsEventsObserver.delegate = nil;
}

@end