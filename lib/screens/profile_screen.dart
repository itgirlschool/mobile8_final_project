// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

bool isEdited = false;
String userName = 'Иван Иванов';
String userPhone = '8934304243';
String userAdress = 'Улица Что-то, город Какой-то';
String userEmail = 'fdfd@sdfs.ru';
late String newName;
late String newPhone;
late String newAdress;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    isEdited = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _phoneController = TextEditingController();
    final _adressController = TextEditingController();
    _nameController.text = userName;
    _phoneController.text = userPhone;
    _adressController.text = userAdress;
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Профиль'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            actions: [
              isEdited
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isEdited = false;
                          _nameController.text = userName;
                          _phoneController.text = userPhone;
                          _adressController.text = userAdress;
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
                          userAdress = _adressController.text;
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  readOnly: !isEdited,
                  decoration: const InputDecoration(
                    labelText: 'Имя пользователя',
                  ),
                ),
                TextFormField(
                  controller: _phoneController,
                  readOnly: !isEdited,
                  decoration: const InputDecoration(
                    labelText: 'Телефон',
                  ),
                ),
                TextFormField(
                  controller: _adressController,
                  readOnly: !isEdited,
                  decoration: const InputDecoration(
                    labelText: 'Адрес доставки',
                  ),
                ),
                TextFormField(
                  initialValue: userEmail,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Электронная почта',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
