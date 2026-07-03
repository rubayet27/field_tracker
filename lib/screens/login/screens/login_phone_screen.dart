part of 'login_screen.dart';

class LoginPhoneScreen extends StatelessWidget {
  LoginPhoneScreen({super.key});

  final emailController = TextEditingController(text: "employee@example.com");
  final passwordController = TextEditingController(text: "secret123");

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
              BrandLogo(),
              Sizes.height.h20,
              WelcomeText(),
              Sizes.height.h16,
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
                isPasswordField: true,
                isFilled: true,
                borderWidth: 0,
                fillColor: isDarkMode
                    ? AppColors.componentDark
                    : AppColors.componentLight,
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
              Sizes.height.h8,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextWidget(
                    "Forgot Password?",
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? AppColors.primaryDark
                        : AppColors.primary,
                  ),
                ],
              ),
              Sizes.height.h16,
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status == LoginStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  return PrimaryButton(
                    title: "Sign in",
                    buttonColor: isDarkMode
                        ? AppColors.primaryDark
                        : AppColors.primary,
                    onPressed: () {
                      context.read<LoginBloc>().add(
                        LoginRequest(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                    },
                    borderRadius: Dimensions.radiusLg,
                  );
                },
              ),
              Sizes.height.h16,
              RegisterTextWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
