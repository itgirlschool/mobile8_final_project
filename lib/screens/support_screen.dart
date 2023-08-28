import 'package:flutter/material.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(title: 'Поддержка',),
          body: Center(
            child: Text(
              'Поддержка',
            ),
          ),
        ),
      ),
    );
  }
}
