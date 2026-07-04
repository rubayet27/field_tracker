part of 'sync_screen.dart';

class SyncPhoneScreen extends StatelessWidget {
  const SyncPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Refresh sync status when screen is shown
    context.read<SyncBloc>().add(LoadSyncStatus());

    return SafeArea(
      child: Scaffold(
        appBar: PrimaryAppBarWidget(title: "Sync", showBackButton: false),
        body: BlocBuilder<SyncBloc, SyncState>(
          builder: (context, state) {
            return Padding(
              padding: Sizes.padding.ph20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show offline alert only when offline
                  if (!state.isOnline) ...[OfflineAlert(), Sizes.height.h16],

                  // Pending changes summary card
                  PendingChangesCard(
                    count: state.pendingChanges.length,
                    lastSyncTime: state.lastSyncTime ?? "Never",
                  ),

                  Sizes.height.h10,

                  if (state.pendingChanges.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          'WAITING TO UPLOAD',
                          fontSize: Dimensions.bodyMedium,
                          fontWeight: FontWeight.w500,
                        ),
                        if (state.isSyncing)
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                    Sizes.height.h8,
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.pendingChanges.length,
                        itemBuilder: (context, index) {
                          return SyncItemCard(
                            item: state.pendingChanges[index],
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_done_rounded,
                              size: 64,
                              color: AppColors.success.withValues(alpha: 0.6),
                            ),
                            Sizes.height.h16,
                            TextWidget(
                              "All synced!",
                              fontSize: Dimensions.titleMedium,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                            Sizes.height.h8,
                            TextWidget(
                              "No pending changes",
                              fontSize: Dimensions.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  PrimaryButton(
                    title: "Sync Now",
                    onPressed: () {
                      context.read<SyncBloc>().add(BatchSync());
                    },
                    buttonColor: isDark
                        ? AppColors.primaryDark
                        : AppColors.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
