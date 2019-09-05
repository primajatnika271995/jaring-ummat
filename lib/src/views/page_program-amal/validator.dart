import 'dart:async';

mixin Validators {
  var titleValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (title, sink) {
      if (title.length > 6) {
        sink.add(title);
      } else {
        sink.addError("Title tidak boleh kosong");
      }
    } 
  );

  var categoryValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (category, sink) {
      if (category.length > 3) {
        sink.add(category);
      } else {
        sink.addError("Kategory tidak boleh kosong");
      }
    } 
  );

  var descriptionValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (description, sink) {
      if (description.length > 10) {
        sink.add(description);
      } else {
        sink.addError("Descripsi minimal 10 karakter");
      }
    } 
  );

  var targetDonasiValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (target, sink) {
      if (target.isNotEmpty) {
        sink.add(target);
      } else {
        sink.addError("Target Donasi tidak boleh kosong");
      }
    } 
  );
  
}