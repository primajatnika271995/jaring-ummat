import 'package:timeago/timeago.dart' as timeago;

class TimeAgoService {
  timeAgoFormatting(var time) {
    final timeAgoFormatted =
    new DateTime.fromMicrosecondsSinceEpoch(time * 1000);

    // Add a new locale messages
    timeago.setLocaleMessages('id', timeago.IdMessages());
    var timeFormated = timeago.format(timeAgoFormatted, locale: 'id');
    return timeFormated;
  }
}
