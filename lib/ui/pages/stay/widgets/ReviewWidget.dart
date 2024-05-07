import 'package:flutter/material.dart';
import 'package:yogi_project/_core/constants/size.dart';
import 'package:yogi_project/_core/constants/style.dart';

class ReviewWidget extends StatelessWidget {
  final double stars;
  final String comment;
  final String userName;
  final String userImgTitle;

  ReviewWidget({
    required this.stars,
    required this.comment,
    required this.userName,
    required this.userImgTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      margin: EdgeInsets.only(right: gap_m),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(gap_s),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.all(gap_s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 별점 표시
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  color: Colors.redAccent,
                  size: gap_m,
                ),
              ),
            ),
            SizedBox(height: gap_xs),
            _buildReviewUserInfo(userName, userImgTitle),
            SizedBox(height: gap_xs),
            // 코멘트 표시
            Text(
              comment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewUserInfo(String userName, String userImgTitle) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(userImgTitle),
        ),
        SizedBox(width: gap_s),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: subtitle1(),
            ),
          ],
        )
      ],
    );
  }
}

class ReviewsList extends StatelessWidget {
  final List<ReviewWidget> reviews;

  ReviewsList({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return reviews.isEmpty
        ? Center(
      child: Text('리뷰가 없습니다.'),
    )
        : SizedBox(
      height: 200, // Height of the review widget
      child: PageView.builder(
        itemCount: reviews.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return reviews[index];
        },
      ),
    );
  }
}
