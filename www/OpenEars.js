(function() {
	var OpenEars, cordova, exec;

	cordova = require("cordova");
	exec = require("cordova/exec");

	OpenEars = (function() {
		var genericHandleError, trigger;

		function OpenEars() {}

		trigger = function(evt, args) {
			return document.dispatchEvent(new CustomEvent(evt, {
				detail: args
			}));
		};

		genericHandleError = function(args) {
			return trigger("openEarsError", args);
		};

		OpenEars.prototype.startAudioSession = function() {
			var success;
			success = function(args) {
				return trigger("startAudioSession", args);
			};
			return exec(success, genericHandleError, "OpenEars", "startAudioSession", []);
		};

		OpenEars.prototype.generateLanguageModel = function(languageName, languageCSV) {
			var success;
			success = function(args) {
				return trigger("generateLanguageModel", args);
			};
			return exec(success, genericHandleError, "OpenEars", "generateLanguageModel", [languageName, languageCSV.toUpperCase()]);
		};

		OpenEars.prototype.stopListening = function() {
			var success;
			success = function(args) {
				return trigger("stopListening", args);
			};
			return exec(success, genericHandleError, "OpenEars", "stopListening", []);
		};

		OpenEars.prototype.resumeListening = function(options) {
			var success;
			success = function(args) {
				return trigger("resumeListening", args);
			};
			return exec(success, genericHandleError, "OpenEars", "resumeListening", []);
		};

		OpenEars.prototype.suspendRecognition = function() {
			var success;
			success = function(args) {
				return trigger("suspendRecognition", args);
			};
			return exec(success, genericHandleError, "OpenEars", "suspendRecognition", []);
		};

		OpenEars.prototype.resumeRecognition = function() {
			var success;
			success = function(args) {
				return trigger("resumeRecognition", args);
			};
			return exec(success, genericHandleError, "OpenEars", "resumeRecognition", []);
		};

		OpenEars.prototype.startListeningWithLanguageModelAtPath = function(languagemodel, dictionary, options) {
			var success;
			if (options == null) {
				options = null;
			}
			success = function(args) {
				return trigger("startListeningWithLanguageModelAtPath", args);
			};
			return exec(success, genericHandleError, "OpenEars", "startListeningWithLanguageModelAtPath", [languagemodel, dictionary, options]);
		};

		OpenEars.prototype.changeLanguageModelToFile = function(languagemodel, dictionary, options) {
			var success;
			if (options == null) {
				options = null;
			}
			success = function(args) {
				return trigger("changeLanguageModelToFile", args);
			};
			return exec(success, genericHandleError, "OpenEars", "changeLanguageModelToFile", [languagemodel, dictionary, options]);
		};

		OpenEars.prototype.say = function(phrase) {
			var success;
			success = function(args) {
				return trigger("say", args);
			};
			return exec(success, genericHandleError, "OpenEars", "say", [phrase]);
		};

		OpenEars.prototype.events = {
			startedListening: function() {
				return trigger("startedListening");
			},
			stoppedListening: function() {
				return trigger("stoppedListening");
			},
			detectedSpeech: function() {
				return trigger("detectedSpeech");
			},
			finishedDetectingSpeech: function() {
				return trigger("finishedDetectingSpeech");
			},
			suspendedRecognition: function() {
				return trigger("suspendedRecognition");
			},
			resumedRecognition: function() {
				return trigger("resumedRecognition");
			},
			startedCalibration: function() {
				return trigger("startedCalibration");
			},
			finishedCalibration: function() {
				return trigger("finishedCalibration");
			},
			continuousSetupDidFail: function() {
				return trigger("continuousSetupDidFail");
			},
			testRecognitionCompleted: function() {
				return trigger("testRecognitionCompleted");
			},
			receivedHypothesis: function(hypothesis, recognitionScore, utteranceID) {
				return trigger("receivedHypothesis", {
					hypothesis: hypothesis,
					recognitionScore: recognitionScore,
					utteranceID: utteranceID
				});
			},
			changedLanguageModelToFile: function(modelPath, dictionaryPath) {
				return trigger("changedLanguageModelToFile", {
					modelPath: modelPath,
					dictionaryPath: dictionaryPath
				});
			},
			startedSpeaking: function() {
				return trigger("startedSpeaking");
			},
			finishedSpeaking: function() {
				return trigger("finishedSpeaking");
			},
			audioSessionInterruptionDidBegin: function() {
				return trigger("audioSessionInterruptionDidBegin");
			},
			audioSessionInterruptionDidEnd: function() {
				return trigger("audioSessionInterruptionDidEnd");
			},
			audioInputDidBecomeUnavailable: function() {
				return trigger("audioInputDidBecomeUnavailable");
			},
			audioInputDidBecomeAvailable: function() {
				return trigger("audioInputDidBecomeAvailable");
			},
			audioRouteDidChangeToRoute: function() {
				return trigger("audioRouteDidChangeToRoute");
			}
		};

		return OpenEars;

	})();

	OpenEars = new OpenEars();

	module.exports = OpenEars;

}).call(this);