import 'package:flutter/material.dart';
import 'package:flutter_attendance/core/core.dart';
import 'package:flutter_attendance/data/datasources/auth_local_datasource.dart';
import 'package:flutter_attendance/presentation/auth/pages/login.dart';
import '../../home/pages/mainpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: FutureBuilder(
        future: AuthLocalDatasource().isAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }

          // Pastikan snapshot.data tidak null
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == true) {
              // Jika sudah login, navigasi ke MainPage
              Future.delayed(
                const Duration(seconds: 2),
                () => context.pushReplacement(const MainPage()),
              );
            } else {
              // Jika belum login, navigasi ke Login
              Future.delayed(
                const Duration(seconds: 2),
                () => context.pushReplacement(const Login()),
              );
            }
          } else {
            // Jika tidak ada data, tetap di halaman splash
            return _buildLoading();
          }

          return Container(); // Kembalikan widget kosong jika tidak ada kondisi yang terpenuhi
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Assets.images.logoWhite.image(),
        ),
        const Spacer(),
        Assets.images.logoCodeWithBahri.image(height: 70),
        const SpaceHeight(20.0),
      ],
    );
  }
}
