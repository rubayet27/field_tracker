part of 'sync_screen.dart';

class SyncPhoneScreen extends StatelessWidget {
  const SyncPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PrimaryAppBarWidget(title: "Sync", showBackButton: false),
        body: Padding(
          padding: Sizes.padding.ph20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OfflineAlert(),
              Sizes.height.h16,
              PendingChangesCard(count: 3, lastSyncTime: "5:55 PM"),
              Sizes.height.h10,
              TextWidget(
                'WAITING TO UPLOAD',
                fontSize: Dimensions.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
              SyncItemCard(),
            ],
          ),
        ),
      ),
    );
  }
}
