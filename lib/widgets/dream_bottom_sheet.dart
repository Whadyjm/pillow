import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pillow/style/text_style.dart';
import 'package:pillow/widgets/custom_button.dart';

import '../provider/button_provider.dart';

class DreamBottomSheet extends StatefulWidget {
  const DreamBottomSheet({
    super.key,
    required this.btnProvider,
    required this.dream,
  });

  final ButtonProvider btnProvider;
  final QueryDocumentSnapshot<Object?> dream;

  @override
  State<DreamBottomSheet> createState() => _DreamBottomSheetState();
}

class _DreamBottomSheetState extends State<DreamBottomSheet> {
  double currentRating = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentRating = widget.dream['rating']?.toDouble() ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              widget.btnProvider.isButtonEnabled
                  ? Colors.grey.shade900
                  : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Iconsax.arrow_left_2_copy,
                      color:
                          widget.btnProvider.isButtonEnabled
                              ? Colors.white70
                              : null,
                    ),
                  ),
                  Text(
                    widget.dream['title'],
                    style: AppTextStyle.subtitleStyle(
                      widget.btnProvider.isButtonEnabled
                          ? Colors.white
                          : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const Divider(),
              SingleChildScrollView(
                child: Text(
                  widget.dream['text'],
                  style: TextStyle(
                    color:
                        widget.btnProvider.isButtonEnabled
                            ? Colors.white
                            : Colors.grey.shade800,
                    fontFamily: 'roboto',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height - 300),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: MediaQuery.sizeOf(context).width - 32,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          isLoading = false;
                        });
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          backgroundColor:
                              widget.btnProvider.isButtonEnabled
                                  ? Colors.grey.shade900
                                  : Colors.white,
                          builder: (BuildContext context) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Análisis del sueño',
                                        style: AppTextStyle.subtitleStyle(
                                          widget.btnProvider.isButtonEnabled
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    SingleChildScrollView(
                                      child: Text(
                                        widget.dream['analysis'],
                                        style: TextStyle(
                                          color:
                                              widget.btnProvider.isButtonEnabled
                                                  ? Colors.white
                                                  : Colors.grey.shade800,
                                          fontFamily: 'roboto',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.purple.shade400,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Cerrar',
                                            style:
                                                RobotoTextStyle.smallTextStyle(
                                                  Colors.white,
                                                ),
                                          ),
                                        ),
                                        RatingBar(
                                          size: 32,
                                          filledIcon: Icons.star_rounded,
                                          emptyIcon: Icons.star_border_rounded,
                                          onRatingChanged: (value) async {
                                            setState(() {
                                              currentRating = value;
                                            });
                                            try {
                                              FirebaseFirestore firestore =
                                                  FirebaseFirestore.instance;
                                              FirebaseAuth auth =
                                                  FirebaseAuth.instance;

                                              await firestore
                                                  .collection('users')
                                                  .doc(auth.currentUser?.uid)
                                                  .collection('dreams')
                                                  .doc(widget.dream.id)
                                                  .update({'rating': value});
                                            } catch (e) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Error updating rating.',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          initialRating: currentRating,
                                          maxRating: 5,
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade400,
                              Colors.purple.shade600,
                              Colors.indigo.shade400,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child:
                              isLoading
                                  ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Ver análisis',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Icon(
                                        Iconsax.magic_star,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
