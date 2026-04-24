import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_cubit.dart';
import 'package:flutter_application_1/features/profile/cubit/profile_state.dart';
import 'package:flutter_application_1/features/profile/widget/profile_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen ({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder:(context, state) {
          return switch (state.status) {
            ProfileStatus.initial || ProfileStatus.loading =>
            const Center(
              child: CircularProgressIndicator(),
            ),
            ProfileStatus.failure =>
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      state.errorMessage ?? 'Произошла ошибка',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              ProfileStatus.success => SingleChildScrollView(
                child: Column(
                  children: [
                    if (state.user != null) ProfileHeader(user: state.user!),
                    const SizedBox(height: 24,),
                  ],
                ),
              ),
              ProfileStatus.uploadingUserAvatar =>
              const Center(
                child: CircularProgressIndicator(),
              )
          };
        }, 
        ),
    );
  }
}