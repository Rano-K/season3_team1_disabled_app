import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';

import '../../binding/Binding.dart';
import '../../components/imageProfile.dart';
import '../../util/theme.dart';
import '../../vm/login_ctrl.dart';
import '../register/change_user.dart';
import '../register/register.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(
            () => UserAccountsDrawerHeader(
              currentAccountPicture:
                  FirebaseImageWidget(imagePath: loginController.picPath.value),
              accountName: Obx(
                () => loginController.isLogged.value
                    ? Text('환영합니다, ${loginController.userName.value}님!',
                        style: const TextStyle(
                            fontFamily: "NotoSansKR-Bold", color: Colors.black))
                    : const Text("로그인이 필요합니다",
                        style: TextStyle(
                            fontFamily: "NotoSansKR-Bold",
                            color: Colors.black)),
              ),
              accountEmail: loginController.isLogged.value
                  ? Text(loginController.userId.value,
                      style: const TextStyle(
                          fontFamily: "NotoSansKR-Bold", color: Colors.black))
                  : const Text(""),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(
                const ChangeUser(),
              );
            },
            leading: Icon(Icons.emoji_people_sharp,
                color: Theme.of(context).colorScheme.secondary),
            title: const Text('계정 설정'),
          ),
          ListTile(
            onTap: () {
              Get.to(
                const LoginUser(),
                binding: LoginBinding(),
              );
            },
            leading: Icon(Icons.login,
                color: Theme.of(context).colorScheme.secondary),
            title: const Text('로그인 하기'),
          ),
          ListTile(
            onTap: () {
              Get.changeTheme(
                Get.isDarkMode ? CustomTheme.lighttheme : CustomTheme.darktheme,
              );
            },
            leading: Icon(Icons.dark_mode,
                color: Theme.of(context).colorScheme.secondary),
            title: Get.isDarkMode
                ? const Text('라이트 테마 변경')
                : const Text('다크 테마 변경'),
          ),
        ],
      ),
    );
  }
}
