import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/address/services/address_services.dart';
import 'package:amazon/provider/user_provider.dart';
import 'package:amazon/payment_configurations.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // Text editing controllers
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  // Form key for validation
  final _addressFormKey = GlobalKey<FormState>();

  // Strings to store selected addresses
  String addressToBeUsed = "";
  String addressCash = "";

  // Payment items for payment buttons
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    // Initialize payment items
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose text editing controllers
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  // Callback for Apple Pay result
  void onApplePayResult(res) {
    // Save user address if empty
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    // Place order
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  // Callback for Google Pay result
  void onGooglePayResult(res) {
    // Save user address if empty
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    // Place order
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  // Callback for Cash payment
  void onPayCash() {
    // Save user address if empty
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(context: context, address: addressCash);
    }
    // Place order
    addressServices.placeOrder(
      context: context,
      address: addressCash,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  // Determine which address to use for payment
  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    // Check if the form is filled
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    // Determine the address to use
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR',false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            children: [
              // Display user address if available
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Text(
                          address,
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              // Address input form
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              // Apple Pay button
              ApplePayButton(
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultApplePay),
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                margin: EdgeInsets.only(top: 15.h),
                height: 50.h,
                onPressed: () => payPressed(address),
              ),
              SizedBox(height: 10.h),
              // Google Pay button
              GooglePayButton(
                onPressed: () => payPressed(address),
                paymentConfiguration:
                    PaymentConfiguration.fromJsonString(defaultGooglePay),
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                height: 50.h,
                type: GooglePayButtonType.buy,
                margin: EdgeInsets.only(top: 15.h),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              SizedBox(height: 10.h),
              // Cash payment button
              SizedBox(
                width: 145.w,
                child: CustomButton(
                  text: 'Pay Cash',
                  onPressed: () {
                    if (_addressFormKey.currentState!.validate()) {
                      addressCash =
                          '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
                      onPayCash();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
