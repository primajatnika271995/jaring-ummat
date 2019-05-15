import 'dart:async';
import 'package:http/http.dart' as http;
import '../config/urls.dart';

class UserStoryApi {
  static Future getUserStory() {
    var url = USER_STORY_LIST;
    return http.get(url);
  }
}
