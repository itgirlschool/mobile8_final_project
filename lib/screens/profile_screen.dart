// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../main.dart';

// bool isEdited = false;
// String userName = 'Иван Иванов';
// String userPhone = '8934304243';
// String userAddress = 'Улица Что-то, город Какой-то';
// String userEmail = 'fdfd@sdfs.ru';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //объявляем переменную блока чеоез конструктор гетит
   final _block = getIt<ProfileBloc>();
  // final _nameController = TextEditingController();
  // final _phoneController = TextEditingController();
  // final _addressController = TextEditingController();
  //
  // @override
  // void initState() {
  //   isEdited = false;
  //   _nameController.text = userName;
  //   _phoneController.text = userPhone;
  //   _addressController.text = userAddress;
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   isEdited = false;
  //   super.dispose();
  //   _addressController.dispose();
  //   _nameController.dispose();
  //   _phoneController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        //подключаем блок
        child: BlocProvider(
          create: (context) => _block,
          //билдим экран с помощью блок билдера
          child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            //возвращаем виджеты в зависимости от состояния
            return switch (state) {
              LoadingProfileState() => const Center(child: CircularProgressIndicator()),
              LoadedProfileState() => _buildProfile(context, state),
              EditProfileState() => _buildEditProfile(context, state),
              ErrorProfileState() => const Center(child: Text('Ошибка')),
            };
          }),
        ),
      ),
    );
  }

  //экран для состояния, когда отображается профиль без редактирования
  Widget _buildProfile(BuildContext context, state) {
    return Scaffold(
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
          TextButton(
              onPressed: () {
                //при нажатии на кнопку редактирования отправляем событие в блок
                context.read<ProfileBloc>().add(EditProfileEvent(user: state.user));
              },
              child: const Text('Редактировать'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextFormField(context: context,  labelText: 'Имя', initialValue: state.user.name, state: state),
            _buildTextFormField(context: context,  labelText: 'Телефон', initialValue: state.user.name, state: state),
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
    );
  }

  Widget _buildTextFormField({required BuildContext context, required String labelText, required String initialValue, required state}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        readOnly: state is LoadedProfileState ? true : false,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: state is LoadedProfileState
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
          focusedBorder: state is LoadedProfileState
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
