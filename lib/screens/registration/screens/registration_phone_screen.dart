part of 'registration_screen.dart';

class RegistrationPhoneScreen extends StatelessWidget {
  RegistrationPhoneScreen({super.key});

  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: Sizes.padding.h(Dimensions.paddingSizeHorizontal),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Sizes.height.addHeight(Dimensions.marginSizeVertical * 5),
              BrandLogo(showTitle: false),
              Sizes.height.h10,
              CreateAccount(),
              Sizes.height.h16,
              PrimaryInputWidget(
                controller: fullNameController,
                hintText: "",
                outerLabel: true,
                label: "Full Name",
                isFilled: true,
                borderWidth: 0,
                fillColor: isDarkMode
                    ? AppColors.componentDark
                    : AppColors.componentLight,
                prefixIcon: Icon(Icons.person_outline_outlined),
              ),
              Sizes.height.h10,
              PrimaryInputWidget(
                controller: emailController,
                hintText: "",
                outerLabel: true,
                label: "Email",
                isFilled: true,
                borderWidth: 0,
                fillColor: isDarkMode
                    ? AppColors.componentDark
                    : AppColors.componentLight,
                prefixIcon: Icon(Icons.mail_outline),
              ),
              Sizes.height.h10,
              PrimaryInputWidget(
                controller: passwordController,
                hintText: "",
                outerLabel: true,
                label: "Password",
                isFilled: true,
                borderWidth: 0,
                fillColor: isDarkMode
                    ? AppColors.componentDark
                    : AppColors.componentLight,
                isPasswordField: true,
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),

              Sizes.height.h16,
              PrimaryButton(
                title: "Create Account",
                buttonColor: isDarkMode
                    ? AppColors.primaryDark
                    : AppColors.primary,
                onPressed: () {
                  context.read<RegistrationBloc>().add(
                    RegistrationRequest(
                      email: emailController.text,
                      password: passwordController.text,
                      fullName: fullNameController.text,
                    ),
                  );
                },
                borderRadius: Dimensions.radiusLg,
              ),
              Sizes.height.h16,
              AlreadyHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}
