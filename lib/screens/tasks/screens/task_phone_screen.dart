part of 'task_screen.dart';

class TaskPhoneScreen extends StatelessWidget {
  const TaskPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> filterList = ["All", "Pending", "Complete"];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: Sizes.padding.po(
              left: Dimensions.defaultPaddingSize * 0.8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "My tasks",
                  fontSize: Dimensions.headlineSmall,
                  fontWeight: FontWeight.w700,
                ),
                TextWidget(
                  formatTime(),
                  fontSize: Dimensions.bodyMedium,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.transparent,
        ),
        body: Padding(
          padding: Sizes.padding.ph20,
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return Column(
                children: [
                  Sizes.height.h10,
                  ProgressCard(completed: 2, total: 6),
                  Sizes.height.h10,
                  Row(
                    children: List.generate(filterList.length, (index) {
                      return FilterChipButton(
                        index: index,
                        onTap: () {
                          context.read<TaskBloc>().add(
                            ChangeFilter(filterIndex: index),
                          );
                        },
                        label: filterList[index],
                        isSelected: index == state.filterIndex,
                      );
                    }),
                  ),
                  Sizes.height.h16,
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.filteredList.length,
                      itemBuilder: (context, index) {
                        final task = state.filteredList[index];
                        return TaskCard(
                          task: task,
                          onCheckboxChanged: (value) {
                            print("adf");
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String formatTime() {
    return DateFormat('EEEE, hh:mm a').format(DateTime.now());
  }
}
