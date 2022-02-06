import 'package:fluent_ui/fluent_ui.dart';

class JobSelectionList extends StatefulWidget {
  static const List<String> _oneOffJobs = [
    'FetchCountriesJob',
    'FetchSeasonWithRoundsAndFixturesJob',
    'FetchTeamDetailsJob',
    'FetchTeamFinishedFixturesJob',
    'FetchTeamUpcomingFixturesJob',
    'FinalizeFixtureJob',
    'TrackFixtureLivescoreJob'
  ];

  static const List<String> _periodicJobs = [];

  const JobSelectionList({Key? key}) : super(key: key);

  @override
  State<JobSelectionList> createState() => _JobSelectionListState();
}

class _JobSelectionListState extends State<JobSelectionList> {
  String? _selectedJobType;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      constraints: const BoxConstraints(maxWidth: 600.0),
      title: const Text('Select type'),
      actions: [
        Button(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        Button(
          child: const Text('Ok'),
          onPressed: () => Navigator.pop(context, _selectedJobType),
        ),
      ],
      content: TreeView(
        selectionMode: TreeViewSelectionMode.single,
        items: [
          TreeViewItem(
            leading: const Icon(FluentIcons.fabric_folder),
            content: const Text('Worker.Application.Jobs'),
            children: [
              TreeViewItem(
                leading: const Icon(FluentIcons.fabric_folder),
                content: const Text('OneOff'),
                children: [
                  TreeViewItem(
                    leading: const Icon(FluentIcons.fabric_folder),
                    content: const Text('FootballDataCollection'),
                    children: JobSelectionList._oneOffJobs
                        .map(
                          (job) => TreeViewItem(
                            leading: const Icon(FluentIcons.file_code),
                            content: Text(job),
                            onInvoked: (item) async {
                              _selectedJobType =
                                  'Worker.Application.Jobs.OneOff.FootballDataCollection.$job';
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              TreeViewItem(
                leading: const Icon(FluentIcons.fabric_folder),
                content: const Text('Periodic'),
                children: JobSelectionList._periodicJobs
                    .map(
                      (job) => TreeViewItem(
                        leading: const Icon(FluentIcons.file_code),
                        content: Text(job),
                        onInvoked: (item) async {
                          _selectedJobType =
                              'Worker.Application.Jobs.Periodic.$job';
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
