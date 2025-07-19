import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/myappbar.dart';
import 'package:hydex/src/features/auth/signup/presentation/components/type_container.dart';
import 'package:hydex/src/features/auth/welcome/presentation/components/badge.dart';
import 'package:hydex/src/features/auth/welcome/presentation/provider/date_provider.dart';
import 'package:intl/intl.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isEmpty = true;
  final pageController = PageController();
  int currentIndex = 0;
  bool isBadgeVisible = true;
  LifeStyle? currentLifestyle;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateController.dispose();
    pageController.dispose();
  }

  void updateCurrentIndex(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      currentIndex = index;

      isEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / 4;

    return Scaffold(
      appBar: MyAppBar(),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 74,
            height: 75,
            decoration: BoxDecoration(
              color: isEmpty
                  ? Color.fromRGBO(218, 218, 218, 1)
                  : Color.fromRGBO(1, 39, 31, 0.1),
              shape: BoxShape.circle,
            ),
          ),
          FloatingActionButton(
            elevation: 0,
            backgroundColor: isEmpty
                ? Color.fromRGBO(164, 164, 164, 1)
                : Color.fromRGBO(1, 39, 31, 1),
            onPressed: isEmpty
                ? null
                : () {
                    updateCurrentIndex(currentIndex + 1);
                  },
            shape: CircleBorder(),
            child: SvgPicture.asset("img/svg/next.svg", package: "assets"),
          ),
        ],
      ),
      body: Column(
        children: [
          Visibility(
            visible: isBadgeVisible,
            child: AppBadge(
              text: "1. We need some basic information to get started!",
              onDelete: () {
                setState(() {
                  isBadgeVisible = false;
                });
              },
            ),
          ),
          Visibility(
            visible: true,
            child: AppBadge(
              text:
                  "2. We need some lifestyle information to tailor the perfect experience for you!",
              onDelete: () {
                setState(() {
                  isBadgeVisible = false;
                });
              },
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: 0, end: progress),
                  builder: (context, value, _) {
                    return LinearProgressIndicator(
                      color: Color(0xffF5BD02),
                      minHeight: 7,
                      value: value,
                      borderRadius: BorderRadius.circular(35),
                      backgroundColor: Color(0xffF5BD02).withValues(alpha: 0.2),
                    );
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (newIndex) {
                    updateCurrentIndex(newIndex);
                  },
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleHeaderDescription(
                          title: "What's your name?",
                          description: "Please enter your full name.",
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: nameController,
                          cursorColor: Color.fromRGBO(9, 160, 239, 1),
                          style: TextStyle(
                            color: Color.fromRGBO(1, 39, 31, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            setState(() {
                              isEmpty = value.isEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type your name here",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Row(
                              children: [
                                SvgPicture.asset(
                                  "img/svg/person.svg",
                                  package: "assets",
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Full Name",
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleHeaderDescription(
                          title: "Enter your email",
                          description:
                              "Please enter your email to continue the registration process.",
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          cursorColor: Color.fromRGBO(9, 160, 239, 1),
                          style: TextStyle(
                            color: Color.fromRGBO(1, 39, 31, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            setState(() {
                              isEmpty = value.isEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Type your email here",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Row(
                              children: [
                                SvgPicture.asset(
                                  "img/svg/mail.svg",
                                  package: "assets",
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleHeaderDescription(
                          title: "Set password",
                          description:
                              "This for your account's safety, so please set a strong password!",
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          cursorColor: Color.fromRGBO(9, 160, 239, 1),
                          style: TextStyle(
                            color: Color.fromRGBO(1, 39, 31, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            setState(() {
                              isEmpty = value.isEmpty;
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Set your pass here",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: Icon(Icons.visibility_outlined),

                            label: Row(
                              children: [
                                SvgPicture.asset(
                                  "img/svg/password.svg",
                                  package: "assets",
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: confirmPasswordController,
                          cursorColor: Color.fromRGBO(9, 160, 239, 1),
                          style: TextStyle(
                            color: Color.fromRGBO(1, 39, 31, 1),
                            fontWeight: FontWeight.w500,
                          ),
                          obscureText: true,

                          onChanged: (value) {
                            setState(() {
                              isEmpty = value.isEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Confirm your pass",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Row(
                              children: [
                                SvgPicture.asset(
                                  "img/svg/password.svg",
                                  package: "assets",
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Confirm Password",
                                  style: TextStyle(
                                    color: Color.fromRGBO(164, 164, 164, 1),
                                  ),
                                ),
                              ],
                            ),
                            suffixIcon: Icon(Icons.visibility_outlined),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleHeaderDescription(
                          title: "What is your date of birth ?",
                          description:
                              "Please enter your birthday to help us tailor an exclusive experience for you!",
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          readOnly: true,

                          controller: dateController,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              builder: (context) {
                                return CalendarDatePicker2(
                                  value: [selectedDate],

                                  onValueChanged: (value) {
                                    final formatted = DateFormat(
                                      'd-MMMM-yyyy',
                                    ).format(value.first);
                                    setState(() {
                                      dateController.text = formatted;
                                      isEmpty = false;
                                      selectedDate = value.first;
                                    });
                                  },
                                  config: CalendarDatePicker2Config(
                                    selectedDayHighlightColor: Color.fromRGBO(
                                      245,
                                      189,
                                      2,
                                      1,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          cursorColor: Color.fromRGBO(9, 160, 239, 1),
                          style: TextStyle(
                            color: Color.fromRGBO(1, 39, 31, 1),
                            fontWeight: FontWeight.w500,
                          ),

                          decoration: InputDecoration(
                            hintText: "Date of birth",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "img/svg/calendar.svg",
                                package: "assets",
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.keyboard_arrow_down_outlined),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleHeaderDescription(
                          title: "What’s your current path ?",
                          description: "Please choose what you do.",
                        ),
                        SizedBox(height: 16),
                        Row(
                          spacing: 16,
                          children: [
                            TypeContainer(
                              title: "Worker",
                              description: "I'm working",
                              value: LifeStyle.worker,
                              currentValue: currentLifestyle,
                              onTap: (v) {
                                setState(() {
                                  currentLifestyle = v;
                                });
                              },
                            ),
                            TypeContainer(
                              title: "Student",
                              description: "I'm still studying",
                              value: LifeStyle.student,
                              currentValue: currentLifestyle,
                              onTap: (v) {
                                setState(() {
                                  currentLifestyle = v;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleHeaderDescription extends StatelessWidget {
  const TitleHeaderDescription({
    super.key,
    required this.title,
    required this.description,
  });
  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 17, color: Color(0xff5A5A5A)),
        ),
      ],
    );
  }
}
