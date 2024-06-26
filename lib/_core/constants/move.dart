import 'package:flutter/material.dart';
import 'package:yogi_project/data/models/event_detail_content.dart';
import 'package:yogi_project/data/models/event_my_page_banner.dart';
import 'package:yogi_project/data/models/event_title_banner.dart';
import 'package:yogi_project/data/models/user.dart';
import 'package:yogi_project/data/dtos/reservation_request.dart';
import 'package:yogi_project/ui/pages/_main_holder.dart';
import 'package:yogi_project/ui/pages/auth/join/join_page.dart';
import 'package:yogi_project/ui/pages/auth/login/login_page.dart';
import 'package:yogi_project/ui/pages/home/home_page.dart';
import 'package:yogi_project/ui/pages/my/my_page.dart';
import 'package:yogi_project/ui/pages/my/pay/pay_page.dart';
import 'package:yogi_project/ui/pages/my/reservation/my_reservation_page.dart';
import 'package:yogi_project/ui/pages/scrap/scrap_list_page.dart';

// navigator로 이동하는 url 설정
class Move {
  static const String loginPage = "/users/login";
  static const String joinPage = "/users/join";
  static const String homePage = "/home";
  static const String mainHolder = "/main";
  static const String searchPage = "/search";
  static const String scrapPage = "/scrap";
  static const String myPage = "/my";
  static const String stayDetailPage = "/stay";
  static const String roomDetailPage = "/room";
  static const String myReservationPage = "/api/my-reservations";
  static const String overseasBookList = "/reservaion/overseas";
  static const String overseasStayList = "/Overseas";
  static const String saleStayList = "/sale";
  static const String hotelStayList = "/hotel";
  static const String motelStayList = "/motel";
  static const String pensionStayList = "/spension";
  static const String homeAndBillaStayList = "/homeAndBilla";
  static const String campingStayList = "/camping";
  static const String guestHouseStayList = "/guestHouse";
  static const String reservationPage = "/api/my-reservations";
  static const String paymentPage = "/pay";
  static const String eventPage = "/event";
}

final User users = User(
  id: 1,
  name: '홍길동',
  email: '123@nate.com',
  password: '1234',
  userImgTitle: 'user1.png',
  createdAt: null,
  updatedAt: null,
);

final List<EventTitleBannerData> eventTitleBannerDataList = [
  EventTitleBannerData(
    imageTitle: 'event/event_title/eventTitle1.png',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle1.png',
  ),
  EventTitleBannerData(
    imageTitle: 'event/event_title/eventTitle2.png',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle2.png',
  ),
  EventTitleBannerData(
    imageTitle: 'event/event_title/eventTitle3.png',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle3.png',
  ),
  EventTitleBannerData(
    imageTitle: 'event/event_title/eventTitle4.png',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle4.png',
  ),
];

final List<EventMyPageBannerData> eventMyPageBanners = [
  EventMyPageBannerData(
    imageTitle: '신규 회원 할인 이벤트',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle1.png',
    deadLine: ' 신규 회원 가입시',
  ),
  EventMyPageBannerData(
    imageTitle: '여어떻노 GOOD REVIEWER 이벤트',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle2.png',
    deadLine: ' 24/12/31 까지 ',
  ),
  EventMyPageBannerData(
    imageTitle: '가정의 달 할인 이벤트',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle3.png',
    deadLine: ' 24/5/31 까지 ',
  ),
  EventMyPageBannerData(
    imageTitle: '슈퍼위크 이벤트',
    bannerTitle: '',
    imagePath: 'assets/images/event/event_title/eventTitle4.png',
    deadLine: ' 24/5/20 부터 ~ 24/5/26 까지 ',
  ),
];

final List<EventDetailContent> eventContentBanners = [
  EventDetailContent(
    imageTitle: '신규 회원 할인 이벤트',
    eventImagePath: 'assets/images/event/event_content/event1.png',
  ),
  EventDetailContent(
    imageTitle: '여어떻노 GOOD REVIEWER 이벤트',
    eventImagePath: 'assets/images/event/event_content/event2.png',
  ),
  EventDetailContent(
    imageTitle: '가정의 달 할인 이벤트',
    eventImagePath: 'assets/images/event/event_content/event3.png',
  ),
  EventDetailContent(
    imageTitle: '슈퍼위크 이벤트',
    eventImagePath: 'assets/images/event/event_content/event4.png',
  ),
];

// URL에 해당 페이지 연결
Map<String, Widget Function(BuildContext)> getRouters() {
  return {
    Move.loginPage: (context) => const LoginPage(),
    // 로그인 페이지
    Move.joinPage: (context) => JoinPage(),
    // 회원가입 페이지
    Move.homePage: (context) => HomePage(),
    // 홈 페이지
    Move.mainHolder: (context) => MainHolder(),
    // 홈 페이지
    // Move.searchPage: (context) => SearchPage(),
    // 검색 페이지
    Move.scrapPage: (context) => ScrapListPage(),
    // 내 주변 페이지
    Move.myPage: (context) => MyPage(
      users: users,
    ),
    // 마이 페이지
    // Move.stayDetailPage: (context) =>
    //     StayDetailPage(stays: stays, rooms: rooms),
    // 기업(숙서) 페이지
    // Move.roomDetailPage: (context) => RoomDetailPage(rooms: rooms,),
    // // 룸 상세보기 페이지

    // Move.reservationPage: (context) => ReservationPage(rooms: rooms),
    // 예약 페이지
    // 임시로 유효한 ReservationSaveReqDTO 인스턴스를 전달
    // Move.paymentPage: (context) => PayPage(
    //   reservations: ReservationSaveReqDTO(
    //     roomId: 1,
    //     roomName: '',
    //     stayAdress: '',
    //     checkInDate: DateTime.parse('2014-05-12'),
    //     checkOutDate: DateTime.parse('2014-05-12'),
    //     reservedDates: '',
    //     price: 100000,
    //     reservationName: "Test Name",
    //     reservationTel: "010-1234-5678",
    //     roomImgTitle: '', amount: 100000, amountToPay: 100000,
    //   ), reservationId: null,
    // ),
    // 국내 숙소 예약확인 페이지
    // Move.overseasStayList: (context) => OverseasStayList(),
    // 해외 숙소 페이지
    // Move.saleStayList: (context) => SaleStayList(),
    // 특가 숙소 페이지
    // Move.hotelStayList: (context) => const HotelStayList(),
    // 호텔 숙소 페이지
    // Move.motelStayList: (context) => const MotelStayList(),
    // 모텔 숙소 페이지
    // Move.pensionStayList: (context) => const PensionStayList(),
    // 펜션 숙소 페이지
    // Move.homeAndBillaStayList: (context) => const HomeAndBillaStayList(),
    // 홈&빌라 숙소 페이지
    // Move.campingStayList: (context) => const CampingStayList(),
    // 캠핑 숙소 리스트
    // Move.guestHouseStayList: (context) => const GuestHouseStayList(),
    // 게하 숙소 페이지),
  };
}
