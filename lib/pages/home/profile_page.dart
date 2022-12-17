import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

bool isLoading = false; 

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleLogout() async{

      setState(() {
        isLoading = true;
      });

      if(await authProvider.logout(user.token!)){
        Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: secondaryColor,
            content: const Text(
              'Logout Berhasil!',
              textAlign: TextAlign.center,
            )
          )
        );
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Gagal Logout!',
              textAlign: TextAlign.center,
            )
          )
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    confirmButtonLogout(){
      return SizedBox(
        width: 100,
        height: 44,
        child: TextButton(
          onPressed: handleLogout,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading ? 
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    primaryTextColor,
                  ),
                ),
              ) : const SizedBox(
                width: 0,
              ),
              SizedBox(
                width: isLoading ? -5 :  5,
              ),
              Text(
                isLoading ? 
                'Loading' : 'Okay',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<void> showLogoutDialog() async{
      return showDialog(
        context: context, 
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Icon(
                      Icons.logout,
                      color: primaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Are You Sure To Logout?',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      confirmButtonLogout(),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 100,
                        height: 44,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: backgroundColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            )
                          ),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
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
        ),
      );
    }

    Widget header(){
      return AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              defaultMargin
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    user.profilePhotoUrl,
                    width: 64,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text(
                      'Halo, ${user.name}',
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                     ),
                     Text(
                      '@${user.username}',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 16,
                      ),
                     )
                    ],
                  )
                ),
                GestureDetector(
                  // onTap: handleLogout,
                  onTap: (){
                    showLogoutDialog();  
                  },
                  child: Image.asset(
                    'assets/button_exit.png',
                    width: 20,
                  ),
                )
              ]
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text){
      return Container(
        margin: const EdgeInsets.only(
          top: 16
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            ),
          ],
        )
      );
    }

    Widget content(){
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor3 
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: (){
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                child: menuItem(
                  'Edit Profile'
                ),
              ),
              menuItem(
                'Your Orders'
              ),
              menuItem(
                'Help'
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              menuItem(
                'Privacy & Policy'
              ),
              menuItem(
                'Term of Service'
              ),
              menuItem(
                'Rate App'
              ),
            ],
          ),
        )
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}