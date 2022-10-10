// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:top_bantz_2/constants/custom_colors.dart';
import 'package:top_bantz_2/constants/design.dart';
import 'package:top_bantz_2/global/global_view/custom_button.dart';
import 'package:top_bantz_2/global/global_view/custom_text.dart';
import 'package:top_bantz_2/modules/authentication/auth_controller.dart';
import 'package:top_bantz_2/modules/avatar/create_avatar.dart';
import 'package:top_bantz_2/repositories/user_repository.dart';
import 'package:top_bantz_2/services/user_services.dart';

import 'package:http/http.dart' as http;

class SelectSubscriptionScreen extends StatefulWidget {
  const SelectSubscriptionScreen({Key? key, required this.userRepository})
      : super(key: key);

  final UserRepository userRepository;

  @override
  _SelectSubscriptionScreenState createState() =>
      _SelectSubscriptionScreenState();
}

class _SelectSubscriptionScreenState extends State<SelectSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Design.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45.h,
                ),
                CustomText(
                  text: "Select Subscription",
                  color: CustomColors.textWhiteColor,
                  maxLines: 2,
                  alignment: TextAlign.left,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 27.h,
                ),
                for (int i = 0; i < 2; i++) SubscriptionTypeTile(index: i),
                SizedBox(
                  height: 27.h,
                ),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    Get.to(
                      () => CreateAvatar(
                        userRepository: widget.userRepository,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionTypeTile extends StatefulWidget {
  SubscriptionTypeTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  @override
  State<SubscriptionTypeTile> createState() => _SubscriptionTypeTileState();
}

class _SubscriptionTypeTileState extends State<SubscriptionTypeTile> {
  final AuthController _authController = Get.put(AuthController(
      userRepository: UserRepository(userServices: UserServices())));

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(bottom: 19.h),
        child: InkWell(
          onTap: () async {
            _authController.selectedSubscription.value = widget.index;
            widget.index == 0
                ? _authController.userModel.isPremium = false
                : _authController.userModel.isPremium = true;
            if (widget.index == 1) {
              await makePayment();
            }
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (widget.index == _authController.selectedSubscription.value)
                Container(
                  height: 180.h,
                  width: 327.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffF1E291),
                        Color(0xffDFAE00),
                        Color(0xffF1E291),
                        Color(0xffE0B108),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Design.radius),
                  ),
                ),
              Container(
                height:
                    widget.index == _authController.selectedSubscription.value
                        ? 175.h
                        : 180.h,
                width:
                    widget.index == _authController.selectedSubscription.value
                        ? 322.w
                        : 327.w,
                decoration: BoxDecoration(
                  color: CustomColors.foreGroundColor,
                  borderRadius: BorderRadius.circular(Design.radius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: widget.index == 0 ? 'Free' : 'Premium',
                            color: CustomColors.textWhiteColor,
                            maxLines: 2,
                            alignment: TextAlign.left,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          if (widget.index == 1)
                            CustomText(
                              text: '£20 / mo',
                              color: CustomColors.textYellowColor,
                              maxLines: 4,
                              alignment: TextAlign.left,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                        ],
                      ),
                      CustomText(
                        text: widget.index == 0
                            ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.'
                            : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.',
                        color: CustomColors.textWhiteColor,
                        maxLines: 3,
                        alignment: TextAlign.left,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Future<void> makePayment() async {
  //   try {
  //     paymentIntentData = await createPaymentIntent('20', 'USD');

  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //           paymentIntentClientSecret: paymentIntentData!['client_secret'],
  //           style: ThemeMode.dark,
  //           applePay: true,
  //           googlePay: true,
  //           merchantCountryCode: 'US',
  //           merchantDisplayName: 'TopBantz'),
  //     );
  //     displayPaymentSheet();
  //   } catch (err) {
  //     log(err.toString());
  //   }
  // }

  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance
  //         .presentPaymentSheet(
  //       parameters: PresentPaymentSheetParameters(
  //         clientSecret: paymentIntentData!['client_secret'],
  //         confirmPayment: true,
  //       ),
  //     )
  //         .then((newValue) {
  //       print('payment intent' + paymentIntentData!['id'].toString());
  //       print(
  //           'payment intent' + paymentIntentData!['client_secret'].toString());
  //       print('payment intent' + paymentIntentData!['amount'].toString());
  //       print('payment intent' + paymentIntentData.toString());
  //       //orderPlaceApi(paymentIntentData!['id'].toString());
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("paid successfully")));

  //       paymentIntentData = null;
  //     }).onError((error, stackTrace) {
  //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
  //     });
  //     setState(() {
  //       paymentIntentData = null;
  //     });

  //     Get.snackbar('Success', 'Payment made successfully');
  //   } on StripeException catch (e) {
  //     log(e.toString());
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               content: CustomText(text: 'Canceled'),
  //             ));
  //   }catch (e) {
  //     print('$e');
  //   }
  // }

  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': calculateAmount(amount),
  //       'currency': currency,
  //       'payment_method_types[]': 'card',
  //     };
  //     http.Response response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       body: body,
  //       headers: {
  //         'Authorization':
  //             'Bearer sk_test_51LrPisGcPFPi3K5sIsdEXdX38tLKxSfZaQdfWf9SnF7sXek4RiUUHhGSIKh4oTBZr4YCraMEQZbcomcGePkYvVU900E9sNpO1h',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //     );

  //     return jsonDecode(response.body.toString());
  //   } catch (err) {
  //     log('Exception: $err');
  //   }
  // }

  // calculateAmount(String amount) {
  //   return (int.parse(amount) * 100).toString();
  // }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'TopBantz'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LrPisGcPFPi3K5sIsdEXdX38tLKxSfZaQdfWf9SnF7sXek4RiUUHhGSIKh4oTBZr4YCraMEQZbcomcGePkYvVU900E9sNpO1h',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
