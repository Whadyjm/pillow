import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../provider/button_provider.dart';
import '../style/text_style.dart';
import 'analysis_style_tag.dart';
import 'like_button.dart';

class FavoriteDreamCard extends StatelessWidget {
  const FavoriteDreamCard({super.key, required this.btnProvider, required this.dream});

  final ButtonProvider btnProvider;
  final QueryDocumentSnapshot<Object?> dream;

  @override
  Widget build(BuildContext context) {
    final analysisStyle = dream['analysisStyle'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                btnProvider.isButtonEnabled
                    ? Colors.black45
                    : Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(2, 1),
          ),
        ],
      ),
      height: 150,
      width: 200,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        dream['title'],
                        style: AppTextStyle.subtitleStyle(
                          Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    dream['text'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500,
                      foreground:
                          Paint()
                            ..shader = LinearGradient(
                              colors: [
                                Colors.transparent.withAlpha(200),
                                Colors.transparent.withAlpha(150),
                                Colors.transparent.withAlpha(50),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(Rect.fromLTWH(0, 0, 200, 100)),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: -80,
            child: Row(
              children: [
                AnalysisStyleTag(analysisStyle: analysisStyle,),
                const SizedBox(width: 20),
                LikeButton(isLiked: dream['isLiked'], dreamId: dream['dreamId'],),
                const SizedBox(width: 20),
                Chip(
                  label: Text(
                    dream['classification'],
                    style: RobotoTextStyle.smallTextStyle(Colors.white),
                  ),
                  backgroundColor:
                      dream['classification'] == 'Pesadilla'
                          ? Colors.purple.shade600
                          : Colors.purple.shade300,
                  avatar: Icon(
                    dream['classification'] == 'Pesadilla'
                        ? Iconsax.emoji_sad
                        : Iconsax.happyemoji,
                    color: Colors.white,
                    size: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
