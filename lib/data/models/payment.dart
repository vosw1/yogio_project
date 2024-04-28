// 결제 기본 틀
import 'dart:ffi';

class Payment {
  final String roomImgTitle; // 방 이미지 제목
  final String roomName; // 방 이름
  final String location; // 위치
  final String checkInDate; // 체크인 날짜
  final String checkOutDate; // 체크아웃 날짜
  final String personCount; // 사람수
  final int price; // 가격
  final String cancellationAndRefundPolicy; // 취소 및 환불 정책

  Payment({
    required this.roomImgTitle,
    required this.roomName,
    required this.location,
    required this.checkInDate,
    required this.checkOutDate,
    required this.personCount,
    required this.price,
    required this.cancellationAndRefundPolicy,
  });


}