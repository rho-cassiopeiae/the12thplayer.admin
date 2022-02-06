import 'package:fluent_ui/fluent_ui.dart';

import '../../job/pages/one_off_jobs_compose_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Text('The 12th Player'),
      ),
      pane: NavigationPane(
        selected: _index,
        onChanged: (index) => setState(() => _index = index),
        displayMode: PaneDisplayMode.open,
        items: [
          PaneItem(
            icon: Icon(FluentIcons.add_work),
            title: Text('Jobs'),
          ),
        ],
      ),
      content: NavigationBody.builder(
        index: _index,
        itemBuilder: (context, index) {
          return OneOffJobsComposePage();
        },
      ),
    );
  }
}
