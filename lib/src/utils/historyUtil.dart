//history page -> 초단위로 받아오는 분/시단위로 변환
String formatDuration(int durationInSeconds) {
  if (durationInSeconds < 60) {
    return '$durationInSeconds초';
  } else if (durationInSeconds < 3600) {
    int minutes = durationInSeconds ~/ 60;
    int seconds = durationInSeconds % 60;
    if (seconds == 0) {
      return '$minutes분';
    } else {
      return '$minutes분 $seconds초';
    }
  } else {
    int hours = durationInSeconds ~/ 3600;
    int minutes = (durationInSeconds % 3600) ~/ 60;
    int seconds = durationInSeconds % 60;
    if (minutes == 0 && seconds == 0) {
      return '$hours시간';
    } else if (seconds == 0) {
      return '$hours시간 $minutes분';
    } else {
      return '$hours시간 $minutes분 $seconds초';
    }
  }
}
