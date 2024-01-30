import 'package:reafy_front/src/components/image_data.dart';

int calculateTotalPagesRead(List<dynamic> historyList) {
  Set<int> uniquePages = Set();

  for (var record in historyList) {
    int startPage = record['startPage'];
    int endPage = record['endPage'];

    for (int page = startPage; page <= endPage; page++) {
      uniquePages.add(page);
    }
  }

  return uniquePages.length;
}

String getProgressImage(double progress) {
  if (progress == 100) return IconsPath.progress10;
  if (progress >= 91) return IconsPath.progress9;
  if (progress >= 81) return IconsPath.progress8;
  if (progress >= 71) return IconsPath.progress7;
  if (progress >= 61) return IconsPath.progress6;
  if (progress >= 51) return IconsPath.progress5;
  if (progress >= 41) return IconsPath.progress4;
  if (progress >= 31) return IconsPath.progress3;
  if (progress >= 21) return IconsPath.progress2;
  if (progress >= 1) return IconsPath.progress1;
  return IconsPath.progress0;
}
