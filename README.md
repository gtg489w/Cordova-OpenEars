# Cordova-OpenEars
A Cordova plugin for the OpenEars speech recognition and speech synthesis for the iPhone





 @{
     ThisWillBeSaidOnce : @[ // This means that a valid utterance for this ruleset will obey all of the following rules in sequence in a single complete utterance:
         @{ OneOfTheseCanBeSaidOnce : @[@"HELLO COMPUTER", @"GREETINGS ROBOT"]}, // At the beginning of the utterance there is an optional statement. The optional statement can be either "HELLO COMPUTER" or "GREETINGS ROBOT" or it can be omitted.
         @{ OneOfTheseWillBeSaidOnce : @[@"DO THE FOLLOWING", @"INSTRUCTION"]}, // Next, an utterance will have exactly one of the following required statements: "DO THE FOLLOWING" or "INSTRUCTION".
         @{ OneOfTheseWillBeSaidOnce : @[@"GO", @"MOVE"]}, // Next, an utterance will have exactly one of the following required statements: "GO" or "MOVE"
         @{ThisWillBeSaidWithOptionalRepetitions : @[ // Next, an utterance will have a minimum of one statement of the following nested instructions, but can also accept multiple valid versions of the nested instructions:
             @{ OneOfTheseWillBeSaidOnce : @[@"10", @"20",@"30"]}, // Exactly one utterance of either the number "10", "20" or "30",
             @{ OneOfTheseWillBeSaidOnce : @[@"LEFT", @"RIGHT", @"FORWARD"]} // Followed by exactly one utterance of either the word "LEFT", "RIGHT", or "FORWARD".
         ]},
         @{ OneOfTheseWillBeSaidOnce : @[@"EXECUTE", @"DO IT"]}, // Next, an utterance must contain either the word "EXECUTE" or the phrase "DO IT",
         @{ ThisCanBeSaidOnce : @[@"THANK YOU"]} and there can be an optional single statement of the phrase "THANK YOU" at the end.
     ]
 };



 {
    required: true,
    commands: [{
        required: false,
        phrases: ['HELLO COMPUTER', 'GREETINGS ROBOT']
    }, {
        required: true,
        phrases: ['DO THE FOLLOWING', 'INSTRUCTION']
    }, {
        required: true,
        phrases: ['GO', 'MOVE']
    }, {
        required: true,
        repititions: true,
        commands: [{
            required: true,
            phrases: ['10', '20', '30']
        }, {
            required: true,
            phrases: ['LEFT', 'RIGHT', 'FORWARD']
        }]
    }, {
        required: true,
        phrases: ['EXECUTE', 'DO IT']
    }, {
        required: false,
        phrases['THANK YOU']
    }]
 }


