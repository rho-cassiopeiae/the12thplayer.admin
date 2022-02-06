import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';

import '../widgets/one_off_job_view.dart';
import '../models/dto/job_dto.dart';

class OneOffJobsComposePage extends StatefulWidget {
  const OneOffJobsComposePage({Key? key}) : super(key: key);

  @override
  _OneOffJobsComposePageState createState() => _OneOffJobsComposePageState();
}

class _OneOffJobsComposePageState extends State<OneOffJobsComposePage> {
  late final ScrollController _scrollController;
  late final TextEditingController _textController;

  final List<JobDto> _jobs = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _addJob() {
    setState(() {
      _jobs.add(JobDto(DateTime.now().millisecondsSinceEpoch));
      _updateJson();
    });
  }

  void _refreshJobList() {
    setState(() {
      _updateJson();
    });
  }

  void _removeJob(JobDto job) {
    setState(() {
      _jobs.remove(job);
      _updateJson();
    });
  }

  void _updateJson() {
    _textController.text = JsonEncoder.withIndent('    ').convert(_jobs);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        commandBar: Row(
          children: [
            FilledButton(
              child: const Text('Add'),
              onPressed: _addJob,
            ),
            const SizedBox(width: 10.0),
            FilledButton(
              child: const Text('Execute'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      content: Row(
        children: [
          const SizedBox(width: 12.0),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.only(right: 16.0),
                children: _jobs
                    .map(
                      (job) => OneOffJobView(
                        key: ValueKey(job.id),
                        job: job,
                        otherJobNames: _jobs
                            .where((j) => j.name != null && j.id != job.id)
                            .map((j) => j.name!)
                            .toList(),
                        refreshJobList: _refreshJobList,
                        removeJob: _removeJob,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: TextBox(
                controller: _textController,
                placeholder: 'json',
                minLines: 30,
                maxLines: 30,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
