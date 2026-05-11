import 'package:flutter/material.dart';

class CommonSectionHeader
    extends StatelessWidget {
  final String title;

  final Color color;

  final IconData icon;

  final int count;

  final bool expanded;

  final VoidCallback onTap;

  const CommonSectionHeader({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.count,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(18),

      child: Padding(
        padding:
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),

        child: Row(
          children: [
            Icon(
              expanded
                  ? Icons
                      .keyboard_arrow_down
                  : Icons
                      .keyboard_arrow_right,

              color: Colors.grey,
            ),

            const SizedBox(width: 16),

            Container(
              padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),

              decoration: BoxDecoration(
                color: color,

                borderRadius:
                    BorderRadius.circular(
                      10,
                    ),
              ),

              child: Row(
                children: [
                  Icon(
                    icon,

                    color:
                        Colors.white,

                    size: 16,
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  Text(
                    title,

                    style:
                        const TextStyle(
                          color:
                              Colors
                                  .white,

                          fontSize: 12,

                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Text(
              count.toString(),

              style:
                  const TextStyle(
                    fontSize: 20,

                    color:
                        Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}