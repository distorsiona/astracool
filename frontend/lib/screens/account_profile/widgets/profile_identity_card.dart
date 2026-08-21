import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class ProfileIdentityCard extends StatelessWidget {
  final Color accentColor;

  final String initials;
  final String displayName;
  final String memberSince;

  final VoidCallback onEdit;

  const ProfileIdentityCard({
    super.key,
    required this.accentColor,
    required this.initials,
    required this.displayName,
    required this.memberSince,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 82,
            height: 82,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accentColor.withAlpha(230),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(18),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'serif',
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF2B242A),
                      fontFamily: 'serif',
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    AppLocalizations.of(context)!
                        .memberSinceWithDate(memberSince),
                    style: const TextStyle(
                      color: Color(0xFF817780),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accentColor.withAlpha(45),
                ),
              ),
              child: Icon(
                Icons.edit_outlined,
                color: accentColor,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white.withAlpha(225),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(
      color: const Color(0xFFE5E0DC),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(8),
        blurRadius: 22,
        offset: const Offset(0, 8),
      ),
    ],
  );
}