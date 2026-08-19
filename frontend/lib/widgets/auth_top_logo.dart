import 'package:flutter/material.dart';

import '../theme/auth_colors.dart';

class AuthTopLogo extends StatelessWidget {
  final bool mobile;
  final IconData? trailingIcon;

  const AuthTopLogo({super.key, this.mobile = false, this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mobile ? 58 : 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.auto_awesome,
              color: authPurple,
              size: mobile ? 17 : 21,
            ),
          ),
          Text(
            'SACRED',
            style: TextStyle(
              color: authPurple,
              fontFamily: 'serif',
              fontSize: mobile ? 30 : 40,
              letterSpacing: mobile ? 6 : 9,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (trailingIcon != null)
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                trailingIcon,
                color: authPurple,
                size: mobile ? 18 : 20,
              ),
            ),
        ],
      ),
    );
  }
}
