import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:yogi_project/data/dtos/reservation_request.dart';
import 'package:yogi_project/data/dtos/response_dto.dart';
import 'package:yogi_project/data/models/reservation.dart';
import 'package:yogi_project/data/repositories/reservation_repository.dart';
import 'package:yogi_project/data/store/session_store.dart';
import 'package:yogi_project/main.dart';

class ReservationListViewModel extends StateNotifier<List<Reservation>> {
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  ReservationListViewModel(mContext, this.ref) : super([]);

  Future<void> notifyAdd(ReservationSaveReqDTO reqDTO) async {
    // JWT 토큰 가져오기
    SessionStore sessionStore = ref.read(sessionProvider);
    print("예약 요청 시작");

    // 예약 정보 서버로 전송
    ResponseDTO responseDTO = await ReservationRepository()
        .fetchReservationSave(reqDTO, sessionStore.accessToken!);

    if (responseDTO.status == 200) {
      // 성공적으로 예약이 추가된 경우
      print("예약 성공: ${responseDTO.body}");
      Reservation newReservation = responseDTO.body as Reservation;

      state = [...state, newReservation];
    } else {
      // 상태 업데이트
      // 예약 실패 처리
      print("예약 실패: ${responseDTO.errorMessage ?? 'No error message provided'}");
    }
  }

  Future<void> notifyInit() async {
    // JWT 토큰 가져오기
    SessionStore sessionStore = ref.read(sessionProvider);
    // 통신하기
    print("통신 시작");
    ResponseDTO responseDTO = await ReservationRepository()
        .fetchReservationList(sessionStore.accessToken!);

    if (responseDTO.status == 200) {
      print("예약 목록 가져오기 성공:");
      print(responseDTO.body);

      // 예약 목록을 상태로 설정
      state = List<Reservation>.from(responseDTO.body);
    } else {
      print("예약 목록 가져오기 실패: ${responseDTO.errorMessage ?? 'No error message provided'}");
    }
  }
}

final reservationListProvider =
StateNotifierProvider<ReservationListViewModel, List<Reservation>>((ref) {
  return ReservationListViewModel(null, ref)..notifyInit();
});
