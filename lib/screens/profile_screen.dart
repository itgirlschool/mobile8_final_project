import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/profile/profile_state.dart';
import '../data/model/user_model.dart';
import '../data/repositories/user_repository.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //объявляем переменную блока чеоез конструктор гетит
  final _bloc = ProfileBloc(getIt<UserRepository>());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _newUserName = '';
  String _newUserPhone = '';
  String _newUserAddress = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        //подключаем блок
        child: BlocProvider(
          create: (context) => _bloc,
          //билдим экран с помощью блок билдера
          child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            //возвращаем виджеты в зависимости от состояния
            return switch (state) {
              LoadingProfileState() => const Center(child: CircularProgressIndicator()),
              LoadedProfileState() => _buildProfile(context, state),
              EditProfileState() => _buildProfile(context, state),
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
          state is EditProfileState
              ? TextButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(CancelEditProfileEvent(user: state.user));
                  },
                  child: const Text('Отменить'))
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          state is EditProfileState
              ? TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      context.read<ProfileBloc>().add(UpdateProfileEvent(user: User(name: _newUserName, phone: _newUserPhone, address: _newUserAddress, email: state.user.email)));
                    }
                  },
                  child: const Text('Сохранить'))
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
          state is LoadedProfileState
              ? TextButton(
                  onPressed: () {
                    //при нажатии на кнопку редактирования отправляем событие в блок
                    context.read<ProfileBloc>().add(EditProfileEvent(user: state.user));
                  },
                  child: const Text('Редактировать'))
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              _buildTextFormField(
                  context: context,
                  labelText: 'Имя',
                  initialValue: state.user.name,
                  state: state,
                  validator: _validateName,
                  onSaved: (value) {
                    _newUserName = value!;
                  }),
              Row(
                children: [
                  Padding(
                    padding: state is LoadedProfileState ? const EdgeInsets.only(right: 4, top: 4) : const EdgeInsets.only(right: 4, bottom: 14),
                    child: const Text(
                      '+7',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    child: _buildTextFormField(
                        context: context,
                        labelText: 'Телефон',
                        initialValue: state.user.phone,
                        state: state,
                        validator: _validatePhone,
                        onSaved: (value) {
                          _newUserPhone = value!;
                        }),
                  ),
                ],
              ),
              _buildTextFormField(
                  context: context,
                  labelText: 'Адрес доставки',
                  initialValue: state.user.address,
                  state: state,
                  validator: _validateAddress,
                  onSaved: (value) {
                    _newUserAddress = value!;
                  }),
              TextFormField(
                initialValue: state.user.email,
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
    );
  }

  Widget _buildTextFormField({required BuildContext context, required String labelText, required String initialValue, required state, required validator, required Function(String?)? onSaved}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        readOnly: state is LoadedProfileState ? true : false,
        initialValue: initialValue,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: state is! LoadedProfileState
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                ),
          focusedBorder: state is! LoadedProfileState
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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите имя';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите номер телефона';
    } else if (value.length != 10) {
      return 'Некорректный номер телефона';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите адрес доставки';
    }
    return null;
  }
}
