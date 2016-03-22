(function(window) {
 
    var FilePicker = function() {};
  
    FilePicker.prototype = {
  
        isAvailable: function(success) {
            cordova.exec(success, null, "FilePicker", "isAvailable", []);
        },
  
        pickFile: function(success, fail,utis, options) {
            cordova.exec(success, fail, "FilePicker", "pickFile", [utis, options]);
        }

    };
  
    cordova.addConstructor(function() {
                         
        window.FilePicker = new FilePicker();
                         
    });
  
})(window);
