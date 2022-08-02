import 'package:flutter/material.dart';
import 'package:odm/constants/constants.dart';
import 'package:odm/screens/components/about_date.dart';

class MatingTimeSection extends StatelessWidget {
  final int maxMember;
  final String location;
  final DateTime date;

  const MatingTimeSection({
    Key? key,
    required this.maxMember,
    required this.location,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        basicInfo(context, Icons.person_outline, '참가인원', '최대 $maxMember명'),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        basicInfo(context, Icons.place_outlined, '모임장소', location),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        basicInfo(context, Icons.schedule_outlined, '모임날짜',
            AboutDate.dateForMateDetail.format(date)),
      ],
    );
  }

  Row basicInfo(
      BuildContext context, IconData icon, String title, String info) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: Constants.sapceGap * 3,
        ),
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.headline5,
            children: [
              const TextSpan(text: "      "),
              TextSpan(
                  text: info, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
  }
}
