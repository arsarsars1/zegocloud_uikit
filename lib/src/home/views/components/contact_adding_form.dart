import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:zegocloud_uikit/components/components.dart';
import 'package:zegocloud_uikit/core/core.dart';
import 'package:zegocloud_uikit/src/home/services/home_service.dart';

class ContactAddingForm extends StatefulWidget {
  const ContactAddingForm({
    super.key,
    this.onSaved,
  });

  final VoidCallback? onSaved;

  @override
  State<ContactAddingForm> createState() => _ContactAddingFormState();
}

class _ContactAddingFormState extends State<ContactAddingForm> {
  final keyPhoneForm = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = context.mediaQuery.viewInsets.bottom;

    return SizedBox(
      height: 370 + keyboardHeight,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 4,
          automaticallyImplyLeading: false,
          title: const Text('Add a new contact'),
          actions: const [CloseButton()],
        ),
        bottomNavigationBar: AppRoundedButton(
          label: 'Save New Contact',
          onPressed: () async {
            if (keyPhoneForm.currentState!.validate()) {
              // FocusManager.instance.primaryFocus?.unfocus();
              await HomeService.addContact(
                name: nameController.text,
                phoneNumber: phoneController.text,
              );

              if (mounted) {
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
              widget.onSaved?.call();
            }
          },
        ),
        extendBodyBehindAppBar: false,
        extendBody: false,
        body: SingleChildScrollView(
          child: Form(
            key: keyPhoneForm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextFormField(
                    controller: nameController,
                    hintText: 'Enter contact name',
                    prefixIcon: const Icon(Icons.person, size: 24),
                    validator: qValidator([
                      IsRequired('Contact name is required'),
                    ]),
                  ),
                  const Gap(16),
                  AppTextFormField(
                    controller: phoneController,
                    hintText: 'Enter contact phone number',
                    keyboardType: TextInputType.phone,
                    validator: qValidator([
                      IsRequired('Contact phone number is required'),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
