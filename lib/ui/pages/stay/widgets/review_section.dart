import 'package:flutter/material.dart';
import 'package:yogi_project/_core/constants/size.dart';
import 'package:yogi_project/data/models/review.dart';
import 'package:yogi_project/ui/pages/stay/widgets/review_popup.dart';

import 'ReviewWidget.dart';

class ReviewSection extends StatelessWidget {
  final List<Review> reviews;

  ReviewSection({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리뷰',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: gap_s),
        reviews.isEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '리뷰가 없습니다',
            style: TextStyle(fontSize: 16),
          ),
        )
            : Container(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              final starRating = review.rating / 5.0 * 5.0;
              return GestureDetector(
                onTap: () {
                  _showReviewPopup(context, review);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: gap_xx),
                    ReviewWidget(
                      stars: starRating,
                      comment: review.comment,
                      userName: review.userName,
                      userImgTitle: review.userImgTitle,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: gap_xs),
        Divider(),
        SizedBox(height: gap_s),
      ],
    );
  }

  void _showReviewPopup(BuildContext context, Review review) {
    // 단일 리뷰를 포함하는 리스트 생성
    List<Review> singleReviewList = [review];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReviewPopup(reviews: singleReviewList, initialIndex: 0);
      },
    );
  }
}