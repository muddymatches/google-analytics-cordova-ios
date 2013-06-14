if (!window.GA) {
	window.GA = {
		trackerWithTrackingId: function(id, successCallback, errorCallback) {
			cordova.exec(successCallback, errorCallback, "GoogleAnalyticsPlugin", "trackerWithTrackingId", [id]);
		},
		trackView: function(pageUri, successCallback, errorCallback) {
			cordova.exec(successCallback, errorCallback, "GoogleAnalyticsPlugin", "trackView", [pageUri]);
		},
		trackEventWithCategory: function(category,action,label,value, successCallback, errorCallback) {
			var options = {category:category,
				action:action,
				label:label,
				value:value};
			cordova.exec(successCallback, errorCallback, "GoogleAnalyticsPlugin", "trackEventWithCategory", [options]);
		},
		hitDispatched: function(hitString) {
			//console.log("hitDispatched :: " + hitString);
		},
		trackerDispatchDidComplete: function(count) {
			//console.log("trackerDispatchDidComplete :: " + count);
		}
	}
}