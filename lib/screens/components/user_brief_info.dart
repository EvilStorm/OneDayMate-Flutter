import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/controllers/model_brief_user.dart';
import 'package:odm/screens/components/member_avatar.dart';

class BriefUserInfo extends StatelessWidget {
  final BriefUserModel info;
  const BriefUserInfo({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MemberAvatar(
          imageUrl: info.pictureMe,
          size: 42,
        ),
        const SizedBox(
          width: Constants.sapceGap * 3,
        ),
        Text.rich(
          TextSpan(
              text: info.nickName ?? "unkown",
              style: Theme.of(context).textTheme.headline6),
        ),
      ],
    );
  }
}
