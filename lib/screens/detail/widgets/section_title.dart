import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/models/model_brief_user.dart';
import 'package:odm/screens/components/user_brief_info.dart';
import 'package:odm/screens/detail/widgets/section_header_20.dart';

class SectionTitle extends StatelessWidget {
  final BriefUserModel? owner;
  final String? title;
  final String? desc;
  const SectionTitle({Key? key, this.owner, this.title, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BriefUserInfo(info: owner),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
        SectionHeader20Text(
          title: title ?? "",
        ),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        Text(
          desc ?? "",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
