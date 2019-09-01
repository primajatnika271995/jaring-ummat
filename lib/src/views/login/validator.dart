import 'dart:async';

mixin Validators {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains("@")) {
        sink.add(email);
      } else {
        sink.addError("Email tidak boleh kosong");
      }
    }
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 6) {
        sink.add(password);
      } else {
        sink.addError("Password tidak boleh kosong");
      }
    } 
  );

  var usernameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (username, sink) {
      if (username.length > 5) {
        sink.add(username);
      } else {
        sink.addError("Nama Lengkap harap di isi");
      }
    }
  );
  
}