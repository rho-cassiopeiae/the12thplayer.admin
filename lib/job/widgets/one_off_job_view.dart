import 'package:fluent_ui/fluent_ui.dart';

import 'job_selection_list.dart';
import '../models/dto/job_dto.dart';

class OneOffJobView extends StatefulWidget {
  final JobDto job;
  final List<String> otherJobNames;
  final VoidCallback refreshJobList;
  final void Function(JobDto) removeJob;

  const OneOffJobView({
    Key? key,
    required this.job,
    required this.otherJobNames,
    required this.refreshJobList,
    required this.removeJob,
  }) : super(key: key);

  @override
  _OneOffJobViewState createState() => _OneOffJobViewState();
}

class _OneOffJobViewState extends State<OneOffJobView> {
  late final TextEditingController _nameFieldController;
  late final TextEditingController _typeFieldController;
  late final TextEditingController _dataMapFieldController;
  late final TextEditingController _executeAfterFieldController;

  @override
  void initState() {
    super.initState();

    _nameFieldController = TextEditingController(text: widget.job.name);
    _typeFieldController = TextEditingController(text: widget.job.type);
    _dataMapFieldController = TextEditingController(text: widget.job.dataMap);
    _executeAfterFieldController = TextEditingController(
      text: widget.job.executeAfter,
    );
  }

  @override
  void dispose() {
    _nameFieldController.dispose();
    _typeFieldController.dispose();
    _dataMapFieldController.dispose();
    _executeAfterFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('One-off job'),
              const Spacer(),
              IconButton(
                icon: Icon(
                  FluentIcons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget.removeJob(widget.job);
                },
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextBox(
            controller: _nameFieldController,
            placeholder: 'Name',
            onChanged: (_) {
              widget.job.name = _nameFieldController.text;
              widget.refreshJobList();
            },
          ),
          const SizedBox(height: 8.0),
          TextBox(
            controller: _typeFieldController,
            placeholder: 'Type',
            onTap: () async {
              var type = await showDialog<String?>(
                context: context,
                builder: (context) => JobSelectionList(),
              );

              if (type != null) {
                _typeFieldController.text = type;
                widget.job.type = type;
                widget.refreshJobList();
              }
            },
          ),
          const SizedBox(height: 8.0),
          TextBox(
            controller: _dataMapFieldController,
            placeholder: 'Data',
            minLines: 4,
            maxLines: 4,
            onChanged: (_) {
              widget.job.dataMap = _dataMapFieldController.text;
              widget.refreshJobList();
            },
          ),
          const SizedBox(height: 8.0),
          AutoSuggestBox(
            controller: _executeAfterFieldController,
            items: widget.otherJobNames,
            onSelected: (value) {
              widget.job.executeAfter = value;
              widget.refreshJobList();
            },
            placeholder: 'Execute after',
          ),
        ],
      ),
    );
  }
}
