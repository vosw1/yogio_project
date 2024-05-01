import 'package:flutter/cupertino.dart';
import '../../_core/constants/move.dart';
import '../../ui/pages/room/room_detail_page.dart';
import '../../ui/pages/stay/stay_detail_page.dart';

class Stay {
  final String stayImgTitle; // 숙소 이미지 제목
  final String stayName; // 숙소 이름
  final String stayInfo; // 숙소 소개
  final String location; // 위치
  final String notice; // 이용공지
  final double starCount; // 별점
  final String comment; // 리뷰 내용

  Stay({
    required this.stayImgTitle,
    required this.stayName,
    required this.stayInfo,
    required this.location,
    required this.notice,
    required this.starCount,
    required this.comment,
  });

  // Getters for all properties
  String get getStayImgTitle => stayImgTitle;

  String get getStayName => stayName;

  String get getStayInfo => stayInfo;

  String get getLocation => location;

  String get getNotice => notice;

  double get getStarCount => starCount;

  String get getComment => comment;

  // Convert Stay object to JSON
  Map<String, dynamic> toJson() {
    return {
      "stayImgTitle": stayImgTitle,
      "stayName": stayName,
      "stayInfo": stayInfo,
      "location": location,
      "notice": notice,
      "starCount": starCount,
      "comment": comment,
    };
  }
}