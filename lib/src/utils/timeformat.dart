class TimeUtils {
  static String formatDuration(int seconds) {
    var duration = Duration(seconds: seconds);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int remainingSeconds = duration.inSeconds.remainder(60);
    String timeString = '';
    if (hours > 0) {
      timeString += hours.toString();
      if (hours < 10) {
        timeString = '0$timeString'; // 시간이 1자리일 때 앞에 0을 붙임
      }
      timeString += ':';
    }
    timeString += minutes.toString().padLeft(2, '0'); // 두 자리수로 표시된 분
    timeString += ':';
    timeString += remainingSeconds.toString().padLeft(2, '0'); // 두 자리수로 표시된 초
    return timeString; // 시:분:초 형식으로 반환
  }
}
