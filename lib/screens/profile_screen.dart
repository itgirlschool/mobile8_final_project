// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

bool isEdited = false;
String userName = 'Иван Иванов';
String userPhone = '8934304243';
String userAddress = 'Улица Что-то, город Какой-то';
String userEmail = 'fdfd@sdfs.ru';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    isEdited = false;
    _nameController.text = userName;
    _phoneController.text = userPhone;
    _addressController.text = userAddress;
    super.initState();
  }

  @override
  void dispose() {
    isEdited = false;
    super.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Профиль'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              isEdited
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isEdited = false;
                          _nameController.text = userName;
                          _phoneController.text = userPhone;
                          _addressController.text = userAddress;
                        });
                      },
                      child: const Text('Отменить'))
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              isEdited
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isEdited = false;
                          userAddress = _addressController.text;
                          userName = _nameController.text;
                          userPhone = _phoneController.text;
                        });
                      },
                      child: const Text('Сохранить'))
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
              !isEdited
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isEdited = true;
                        });
                      },
                      child: const Text('Редактировать'))
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTextFormField(controller: _nameController, context: context, isEdited: isEdited, labelText: 'Имя'),
                _buildTextFormField(controller: _phoneController, context: context, isEdited: isEdited, labelText: 'Телефон'),
                _buildTextFormField(controller: _addressController, context: context, isEdited: isEdited, labelText: 'Адрес доставки'),
                TextFormField(
                  initialValue: userEmail,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Электронная почта',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({required TextEditingController controller, required BuildContext context, bool isEdited = false, required String labelText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: !isEdited,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: isEdited
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
          focusedBorder: isEdited
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
        ),
      ),
    );
  }
}
