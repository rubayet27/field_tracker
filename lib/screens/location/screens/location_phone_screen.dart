part of 'location_screen.dart';

class LocationPhoneScreen extends StatelessWidget {
  const LocationPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: PrimaryAppBarWidget(title: "Locations", showBackButton: false),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Routes.addLocation.push<bool>();
            if (result == true && context.mounted) {
              context.read<LocationBloc>().add(GetAllLocation());
            }
          },
          backgroundColor: darkTheme
              ? AppColors.primaryDark
              : AppColors.primary,
          child: Icon(
            Icons.add,
            color: darkTheme ? AppColors.black : AppColors.white,
          ),
        ),

        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state.status == LocationStatus.success && state.data != []) {
              return Padding(
                padding: Sizes.padding.ph20,
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      color: Colors.white,
                      child: PrimaryInputWidget(
                        controller: TextEditingController(),
                        hintText: "Search locations",
                        skipEnterText: true,
                        prefixIcon: Icon(Icons.search, size: Dimensions.iconLg),
                        showBorderSide: false,
                      ),
                    ),
                    Expanded(child: LocationList()),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
