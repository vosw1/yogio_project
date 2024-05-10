import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yogi_project/_core/constants/move.dart';
import 'package:yogi_project/_core/constants/size.dart';
import 'package:yogi_project/data/models/event_my_page_banner.dart';
import 'package:yogi_project/data/models/reservation.dart';
import 'package:yogi_project/data/models/user.dart';
import 'package:yogi_project/ui/pages/my/reservation/reservation_detail_page.dart';
import 'package:yogi_project/ui/pages/my/reservation/widgets/reservation_list_model.dart';

class MyReservationPage extends ConsumerWidget {
  final User users;
  final List<EventMyPageBannerData> eventMyPageBanners;

  MyReservationPage({
    required this.users,
    required this.eventMyPageBanners,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ReservationListModel? model = ref.watch(reservationListProvider);
    if (model == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('예약내역'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: gap_m),
          child: ListView.builder(
            itemCount: model.reservation.length,
            itemBuilder: (context, index) {
              final Reservation reservation = model.reservation[index];
              return buildListItem(context, reservation);
            },
          ),
        ),
      );
    }
  }

  Widget buildListItem(BuildContext context, Reservation reservation) {
    return Padding(
      padding: const EdgeInsets.only(top: gap_m, left: gap_m, right: gap_m),
      child: Row(
        children: [
          SizedBox(height: gap_xs),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationDetailPage(
                      rooms: rooms,
                      pays: pays,
                      reservations: reservations,
                    ),
                  ),
                );
              },
              child: Container(
                height: 120, // 사진의 높이
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("camping/camping1.png"), // 이미지 경로
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}