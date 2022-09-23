import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/share/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/bloc/auth_bloc.dart';
import '../../share/components/image_container.dart';
import '../../share/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<AuthBloc>().state.user;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ImageContainer(),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            Text(
              'User name',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              user.email,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            Divider(
              height: getProportionateScreenHeight(32.0),
            ),
            ProfileCard(
              icon: Icons.person,
              color: kAccentGreen,
              title: 'My profile',
              tapHandler: () {
                // Navigator.of(context).pushNamed(MyProfileScreen.routeName);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              icon: Icons.person,
              color: kAccentTosca,
              title: 'My Address',
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              icon: Icons.person,
              color: kAccentYellow,
              title: 'Notification',
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            const ProfileCard(
              icon: Icons.person,
              color: kAccentPurple,
              title: 'Help Center',
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            ),
            ProfileCard(
              icon: Icons.person,
              color: kAccentRed,
              title: 'Log out',
              tapHandler: () =>
                  context.read<AuthBloc>().add(AppLogoutRequested()),
            ),
            const Spacer(),
            Text(
              'ver 1.01',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: kTextColorAccent,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8.0),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.icon,
    required this.title,
    this.tapHandler,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback? tapHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapHandler,
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(8.0),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: kShadowColor.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(8.0),
              ),
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(8.0),
                  ),
                ),
              ),
              child: Icon(icon),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8.0),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
