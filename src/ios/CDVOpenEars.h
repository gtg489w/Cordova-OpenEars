/*

Open Ears Cordova plugin

http://www.torchproducts.com
http://cordova.apache.org

*/

#import <Cordova/CDV.h>

#import <OpenEars/OEPocketsphinxController.h>
#import <OpenEars/OEFliteController.h>
#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OELogging.h>
#import <OpenEars/OEAcousticModel.h>
#import <Slt/Slt.h>

@interface CDVOpenEars : CDVPlugin<OEEventsObserverDelegate> {
}


@property (nonatomic, strong) Slt *slt;
@property (nonatomic, strong) OELanguageModelGenerator *languageModelGenerator;

@property (nonatomic, strong) OEEventsObserver *openEarsEventsObserver;
@property (nonatomic, strong) OEPocketsphinxController *pocketsphinxController;
@property (nonatomic, strong) OEFliteController *fliteController;



- (void)initialize:(CDVInvokedUrlCommand*)command;

- (void)startListening:(CDVInvokedUrlCommand*)command;
- (void)stopListening:(CDVInvokedUrlCommand*)command;
- (void)suspendRecognition:(CDVInvokedUrlCommand*)command;
- (void)resumeRecognition:(CDVInvokedUrlCommand*)command;
- (void)changeLanguageModel:(CDVInvokedUrlCommand*)command;
- (void)say:(CDVInvokedUrlCommand*)command;


@end