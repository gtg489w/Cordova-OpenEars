/*

Open Ears Cordova plugin

http://www.torchproducts.com
http://cordova.apache.org

*/

cordova.define("com.torchproducts.cordova.openears.OpenEars", function(require, exports, module) { (function() {
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
				console.log('got success', args);
				return trigger("initialize", args);
			};
			console.log('returning the exec');
			return exec(success, genericHandleError, "OpenEars", "startListening", []);
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

		OpenEars.prototype.events = {
			startedListening: function() {
				return trigger("startedListening");
			},
			stoppedListening: function() {
				return trigger("stoppedListening");
			}
		};

		return OpenEars;

	})();

	OpenEars = new OpenEars();

	module.exports = OpenEars;

}).call(this);
});
