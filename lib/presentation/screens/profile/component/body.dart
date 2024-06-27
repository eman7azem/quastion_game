import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/constants/colors.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:quastions_game/data/api/api.dart';
import 'package:quastions_game/data/models/user_data.dart';
import 'package:quastions_game/presentation/screens/profile/component/change_pass.dart';
import 'package:quastions_game/presentation/screens/profile/component/profile_shimmer.dart';


import '../../../utilities/image_helper.dart';
import '../../../utilities/my_toast.dart';
import '../../../widgets/button.dart';
import 'custom_textField.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? image;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  bool progress = false;
  final _api = API();
  UserData? profile;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    UserData? fetchedProfile = await _api.getDataProfile();
    if (fetchedProfile != null) {
      setState(() {
        profile = fetchedProfile;
        _name.text = profile!.name ?? '';
        _email.text = profile!.email ?? '';
        _phone.text = profile!.phone ?? '';
      });
    }
  }

  void chooseImage() async {
    File? selectedImage = await ImageHelper.showImageSourceDialog(context);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  void editProfile() async {
    setState(() {
      progress = true;
    });

    Map<String, dynamic>? response = await _api.editProfile(
      name: _name.text,
      email: _email.text.isEmpty ? null : _email.text,
      phone: _phone.text.isEmpty ? null : _phone.text,
      image: image,
    );

    if (response != null) {
      if (response['success'] == true) {
        showToast(response['message']);
        _fetchData();
      } else {
        showToast(response['message'], error: true);
      }
    } else {
      if (context.mounted) showToast('Error connecting', error: true);
    }

    setState(() {
      progress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return profile == null
        ? const ProfileShimmer()
        : Stack(
      children: [
        Image.asset(
          'assets/images/bg1.png',
          height: size.height * 0.9,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: size.height * 0.2,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              height: size.height * 0.7,
              width: size.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.13),
                    CustomTextField(controller: _name),
                    SizedBox(height: size.height * 0.02),
                    CustomTextField(controller: _email),
                    SizedBox(height: size.height * 0.02),
                    CustomTextField(controller: _phone),
                    SizedBox(height: size.height * 0.02),
                    _buildPasswordChange(size),
                    SizedBox(height: size.height * 0.05),
                    _buildSaveButton(size),
                    SizedBox(height: size.height * 0.1),

                  ],
                ),
              ),
            ),
          ),
        ),
        _buildProfileImage(size),
        _buildEditImageIcon(size),
      ],
    );
  }

  Container _buildPasswordChange(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      width: size.width,
      height: size.height * 0.085,
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: const Color(0xABC5C5C5), width: 2),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '***************',
              style: TextStyle(
                height: 4,
                color: Colors.grey,
                fontSize: 20.sp,
                fontFamily: 'Kohinoor Arabic',
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                navigateTo(context, ChangePass());
              },
              child: Text(
                'تغيير كلمة السر',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: kPrimaryDark,
                  fontSize: size.width * 0.042,
                  fontFamily: 'Kohinoor Arabic',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _buildSaveButton(Size size) {
    return GestureDetector(
      onTap: editProfile,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: Button(
          width: double.infinity,
          text: 'حفظ التغييرات',
          inProgress: progress,
          colorPrimary: kPrimaryColor,
          colorDark: kPrimaryDark,
          colorProgress: Colors.white,
          fontSize: 20.sp,
        ),
      ),
    );
  }

  Positioned _buildProfileImage(Size size) {
    return Positioned(
      top: size.height * 0.14,
      left: size.width * 0.36,
      child: Container(
        width: size.width * 0.3,
        height: size.width * 0.3,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: scundryColor,
            width: 2.0,
          ),
        ),
        child: ClipOval(
          child: image != null
              ? Image.file(
            image!,
            fit: BoxFit.cover,
          )
              : profile?.image != null
              ? Image.network(
            'https://binhizam-sa.com/${profile?.image}',
            fit: BoxFit.cover,
          )
              : Image.asset(
            'assets/images/user.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Positioned _buildEditImageIcon(Size size) {
    return Positioned(
      top: size.height * 0.23,
      left: size.width * 0.54,
      child: GestureDetector(
        onTap: () => chooseImage(),
        child: Container(
          width: size.width * 0.2,
          height: size.width * 0.1,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 30.r,
          ),
        ),
      ),
    );
  }
}
