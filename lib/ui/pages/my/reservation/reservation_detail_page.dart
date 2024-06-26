import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yogi_project/_core/constants/size.dart';
import 'package:yogi_project/_core/constants/style.dart';
import 'package:yogi_project/data/models/reservation.dart';
import 'package:yogi_project/ui/pages/my/reservation/widgets/reservation_list_model.dart';
import 'package:yogi_project/ui/pages/my/reservation/widgets/review_writing_dialog.dart';

class ReservationDetailPage extends ConsumerStatefulWidget {
  final Reservation reservations;

  const ReservationDetailPage({
    Key? key,
    required this.reservations,
  }) : super(key: key);

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends ConsumerState<ReservationDetailPage> {
  late DateTime _checkInDate;
  late DateTime _checkOutDate;
  int _numberOfNights = 1;

  @override
  void initState() {
    super.initState();
    _checkInDate = widget.reservations.checkInDate.toUtc();
    _checkOutDate = widget.reservations.checkOutDate.toUtc();
    _numberOfNights = _checkOutDate.difference(_checkInDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final reservationList = ref.watch(reservationListProvider);

    final reservation = reservationList.firstWhere(
      (res) => res.payId == widget.reservations.payId,
      orElse: () => widget.reservations,
    );

    bool isRefund = reservation.state == 'REFUND' || reservation.amount == 0;
    bool showCancelButton = !isRefund && DateTime.now().isBefore(_checkInDate);
    bool showReviewButton = !isRefund &&
        reservation.reviewId == null &&
        DateTime.now().isAfter(_checkInDate) &&
        DateTime.now().isBefore(_checkOutDate.add(Duration(days: 30)));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${reservation.stayName}',
          style: h4()
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: gap_m, right: gap_m, bottom: gap_l),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(gap_m),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(gap_s),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(gap_s),
                    child: Image.asset(
                      'assets${reservation.roomImagePath}',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: gap_m),
                  Text(
                    '${reservation.roomName}',
                    style: h4(),
                  ),
                  Text(
                    '${reservation.stayAddress}',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: gap_m),
                  Text(
                    '숙박기간 : ${_numberOfNights} 박 ${_numberOfNights + 1} 일',
                    style: h4(),
                  ),
                  SizedBox(height: gap_m),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('체크인', style: h5()),
                          SizedBox(height: gap_xs),
                          GestureDetector(
                            onTap: () => _selectDate(context, isCheckIn: true),
                            child: Container(
                              padding: EdgeInsets.all(gap_s),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(gap_s),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${formatDate(_checkInDate)}',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: gap_xs),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('체크아웃', style: h5()),
                          SizedBox(height: gap_xs),
                          GestureDetector(
                            onTap: () => _selectDate(context, isCheckIn: false),
                            child: Container(
                              padding: EdgeInsets.all(gap_s),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(gap_s),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '${formatDate(_checkOutDate)}',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: gap_xs),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: gap_m),
                  Divider(),
                  SizedBox(height: gap_m),
                  Text('예약 정보', style: h4()),
                  SizedBox(height: gap_m),
                  Text(
                    '예약자 : ${reservation.reservationName}',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: gap_xs),
                  Text(
                    '전화번호 : ${formatPhoneNumber(reservation.reservationTel)}',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: gap_xs),
                  // 예약 금액 * 일수 = 결제 금액
                  Text(
                    '결제금액 : ${NumberFormat('#,###').format(reservation.amount).toString()} 원',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: gap_xs),
                  Text(
                    '결제일자 : ${formatDate(reservation.createdAt)}',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
            if (isRefund)
              Padding(
                padding: const EdgeInsets.only(top: gap_m),
                child: Center(
                  child: Text(
                    '취소된 예약입니다',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            if (!isRefund && (showCancelButton || showReviewButton))
              Padding(
                padding: const EdgeInsets.only(top: gap_m),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (showCancelButton)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref
                                .read(reservationListProvider.notifier)
                                .payUpdate(widget.reservations.payId);
                            // 상태를 갱신하여 UI를 다시 빌드
                            setState(() {});
                          },
                          child: Text(
                            '예약 취소',
                            style: h6(mColor: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    if (showReviewButton)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showReviewWritingDialog(context),
                          child: Text(
                            '리뷰 작성',
                            style: h6(mColor: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isCheckIn}) async {
    DateTime initialDate = isCheckIn ? _checkInDate : _checkOutDate;
    DateTime firstDate = DateTime.now();
    DateTime lastDate = DateTime.now().add(Duration(days: 365));

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
        } else {
          _checkOutDate = picked;
        }

        _numberOfNights = _checkOutDate.difference(_checkInDate).inDays;
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAllMapped(RegExp(r'(\d{3})(\d{3,4})(\d{4})'),
        (Match m) => '${m[1]}-${m[2]}-${m[3]}');
  }

  void _showReviewWritingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ReviewWritingDialog();
      },
    );
  }
}
