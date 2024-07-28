// 독서 기록 저장
class CreateUserBookHistoryDto {
  int? bookshelfBookId;
  int? startPage;
  int? endPage;
  int duration;
  int remainedTimer;

  CreateUserBookHistoryDto(
      {required this.bookshelfBookId,
      required this.startPage,
      required this.endPage,
      required this.duration,
      required this.remainedTimer});

  Map<String, dynamic> toJson() {
    return {
      'bookshelfBookId': bookshelfBookId,
      'startPage': startPage,
      'endPage': endPage,
      'duration': duration,
      'remainedTimer': remainedTimer,
    };
  }
}
