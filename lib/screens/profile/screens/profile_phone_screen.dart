part of 'profile_screen.dart';

class ProfilePhoneScreen extends StatelessWidget {
  const ProfilePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PrimaryAppBarWidget(
          title: "Profile",
          showBackButton: false,
          actions: [ThemeToggleWidget()],
        ),
        body: Padding(
          padding: Sizes.padding.ph20,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserInfoWidget(),
              Sizes.height.h12,
              TaskInfo(),
              Sizes.height.h12,
              MenuOptions(),
              Sizes.height.h16,
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state.logoutstatus == LogoutStatus.success) {
                    Routes.login.go();
                  }
                },
                builder: (context, state) {
                  if (state.logoutstatus == LogoutStatus.loading) {
                    return LinearProgressIndicator();
                  }
                  return PrimaryButton(
                    title: "Sign out",
                    buttonTextColor: AppColors.error,
                    borderColor: AppColors.error,
                    icon: Icon(Icons.logout),
                    borderWidth: 1,
                    borderRadius: AppRadius.md,
                    onPressed: () {
                      context.read<ProfileBloc>().add(LogoutEvent());
                    },
                    buttonColor: Colors.transparent,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
