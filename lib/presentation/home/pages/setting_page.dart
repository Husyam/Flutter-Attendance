import 'package:flutter/material.dart';
import 'package:flutter_attendance/core/core.dart';
import 'package:flutter_attendance/main.dart';
import 'package:flutter_attendance/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_attendance/presentation/home/pages/mainpage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<LogoutBloc, LogoutState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              success: (_) {
                context.pushReplacement(const MainPage());
              },
              error: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.message),
                    backgroundColor: AppColors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () {
                    context.read<LogoutBloc>().add(const LogoutEvent.logout());
                  },
                  label: 'Logout',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
