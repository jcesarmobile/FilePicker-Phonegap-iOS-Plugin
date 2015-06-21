(function(window) {
 
    var FilePicker = function() {}
  
    FilePicker.prototype = {
  
        pickFile: function(success, fail,utis) {
            cordova.exec(success, fail, "FilePicker", "pickFile", [utis]);
        }
  
    };
  
    cordova.addConstructor(function() {
                         
        window.FilePicker = new FilePicker();
                         
    });
  
})(window);