import 'package:flutter/material.dart';
import 'package:matrix_app/core/widgets/custom_text_from_field.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1F2937),
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // 📸 قسم الصورة الشخصية مع إطار بنفسجي وأيقونة الكاميرا العائمة
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(
                            0xFF7B73F3,
                          ), // الإطار البنفسجي حول الصورة
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage(
                          'assets/images/Banner3.png', // ضع مسار صورتك هنا
                        ),
                      ),
                    ),
                    // زر الكاميرا العائم أسفل اليمين
                    Container(
                      margin: const EdgeInsets.only(bottom: 4, right: 4),
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // 📝 حقل الاسم
              CustomTextFromField(
                title: "Name",
                controller: nameController,
                hintText: 'Ismail Abu Shanab',
              ),

              const SizedBox(height: 20),

              CustomTextFromField(
                title: "email",
                controller: emailController,
                hintText: 'Ismail@gmail.com',
              ),

              const SizedBox(height: 20),
              CustomTextFromField(
                title: "Phon",
                controller: phoneController,
                hintText: '+970 59 000 0000',
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF7B73F3,
                    ), // لون الزر البنفسجي المطابق للصورة
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // دالة الحفظ
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
