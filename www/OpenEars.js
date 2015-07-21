/*

Open Ears Cordova plugin

http://www.torchproducts.com
http://cordova.apache.org

*/

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

		OpenEars.prototype.initialize = function() {
			var success;
			success = function(args) {
				return trigger("initialize", args);
			};
			return exec(success, genericHandleError, "OpenEars", "initialize", []);
		};

		OpenEars.prototype.startListening = function() {
			var success;
			success = function(args) {
				return trigger("startListening", args);
			};
			return exec(success, genericHandleError, "OpenEars", "startListening", []);
		};

		OpenEars.prototype.stopListening = function() {
			var success;
			success = function(args) {
				return trigger("stopListening", args);
			};
			return exec(success, genericHandleError, "OpenEars", "stopListening", []);
		};

		OpenEars.prototype.changeLanguageModel = function(modelName, modelCSV) {
			var success;
			success = function(args) {
				return trigger("changeLanguageModel", args);
			};
			return exec(success, genericHandleError, "OpenEars", "changeLanguageModel", [modelName, modelCSV]);
		};

		OpenEars.prototype.say = function(textToSay) {
			var success;
			success = function(args) {
				return trigger("say", args);
			};
			return exec(success, genericHandleError, "OpenEars", "say", [textToSay]);
		};






		OpenEars.prototype.events = {
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
			audioRouteDidChangeToRoute: function(newRoute) {
				return trigger("audioRouteDidChangeToRoute", {
					newRoute: newRoute
				});
			},
			pocketsphinxRecognitionLoopDidStart: function() {
				return trigger("pocketsphinxRecognitionLoopDidStart");
			},
			pocketsphinxDidStartListening: function() {
				return trigger("pocketsphinxDidStartListening");
			},
			pocketsphinxDidDetectSpeech: function() {
				return trigger("pocketsphinxDidDetectSpeech");
			},
			pocketsphinxDidDetectFinishedSpeech: function() {
				return trigger("pocketsphinxDidDetectFinishedSpeech");
			},
			pocketsphinxDidReceiveHypothesis: function(hypothesis, recognitionScore, utteranceID) {
				return trigger("pocketsphinxDidReceiveHypothesis", {
					hypothesis: hypothesis,
					recognitionScore: recognitionScore,
					utteranceID: utteranceID
				});
			},
			pocketsphinxDidReceiveNBestHypothesisArray: function(hypothesisArray) {
				return trigger("pocketsphinxDidReceiveNBestHypothesisArray", {
					hypothesisArray: hypothesisArray
				});
			},
			pocketsphinxDidStopListening: function() {
				return trigger("pocketsphinxDidStopListening");
			},
			pocketsphinxDidSuspendRecognition: function() {
				return trigger("pocketsphinxDidSuspendRecognition");
			},
			pocketsphinxDidResumeRecognition: function() {
				return trigger("pocketsphinxDidResumeRecognition");
			},
			pocketsphinxDidChangeLanguageModelToFile: function(newLanguageModelPathAsString, newDictionaryPathAsString) {
				return trigger("pocketsphinxDidChangeLanguageModelToFile", {
					newLanguageModelPathAsString: newLanguageModelPathAsString,
					newDictionaryPathAsString: newDictionaryPathAsString
				});
			},
			pocketSphinxContinuousSetupDidFailWithReason: function(reasonForFailure) {
				return trigger("pocketSphinxContinuousSetupDidFailWithReason", {
					reasonForFailure: reasonForFailure
				});
			},
			pocketSphinxContinuousTeardownDidFailWithReason: function(reasonForFailure) {
				return trigger("pocketSphinxContinuousTeardownDidFailWithReason", {
					reasonForFailure: reasonForFailure
				});
			},
			pocketsphinxTestRecognitionCompleted: function() {
				return trigger("pocketsphinxTestRecognitionCompleted");
			},
			pocketsphinxFailedNoMicPermissions: function() {
				return trigger("pocketsphinxFailedNoMicPermissions");
			},
			micPermissionCheckCompleted: function(result) {
				return trigger("micPermissionCheckCompleted", {
					result: result
				});
			},
			fliteDidStartSpeaking: function() {
				return trigger("fliteDidStartSpeaking");
			},
			fliteDidFinishSpeaking: function() {
				return trigger("fliteDidFinishSpeaking");
			}
		};

		return OpenEars;

	})();

	OpenEars = new OpenEars();

	module.exports = OpenEars;

}).call(this);
