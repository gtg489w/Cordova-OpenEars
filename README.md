# Cordova-OpenEars
A Cordova plugin for the OpenEars speech recognition and speech synthesis for the iPhone http://www.politepix.com/openears/

## Getting Started
I assume you have some Cordova experience or have at least read up on the documentation. To add this plugin, run the following command:

	cordova plugin add https://github.com/gtg489w/Cordova-OpenEars

To initialize the OpenEars plugin:
	openEars = window.OpenEars;
	openEars.initialize();

Update your dictionary:
	openEars.changeLanguageModel('MyDictionary', 'HELLO,GOODBYE');

Start listening
	openEars.startListening();

Subscribe to events (e.g., a hypothesis based on your dictionary)
	document.addEventListener("pocketsphinxDidReceiveHypothesis", function(e) {
		log('Hypothesis: ' + e.detail.hypothesis + ' (' + e.detail.recognitionScore + ')');
	}, false);

And say something back
	openEars.say('Hello my good friend');

For more examples, take a look at the sample project https://github.com/gtg489w/Cordova-OpenEarsSample

## Thanks
Thank you to @karljacuncha for producing the OpenEars 1.0 Cordova plugin. His project can be found at: https://github.com/karljacuncha/OpenEarsPlugin