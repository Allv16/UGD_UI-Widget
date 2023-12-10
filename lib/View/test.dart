import 'package:flutter/material.dart';

void main() => runApp(testApp());

class testApp extends StatefulWidget {
  const testApp({Key? key}) : super(key: key);

  @override
  _testAppState createState() => _testAppState();
}

class _testAppState extends State<testApp> {
  static const String _title = 'Flutter Tutorial';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Steps(),
      ),
    );
  }
}

class Step {
  Step(
    this.title,
    this.body,
    [this.isExpanded = false]
  );
  String title;
  String body;
  bool isExpanded;
}

Future<List<Step>> getSteps() async {
  var _items = [
    Step('Step 0: Install Flutter', 'Install Flutter development tools according to the official documentation.'),
    Step('Step 1: Create a project', 'Open your terminal, run `flutter create <project_name>` to create a new project.'),
    Step('Step 2: Run the app', 'Change your terminal directory to the project directory, enter `flutter run`.'),
  ];
  return Future<List<Step>>.delayed(const Duration(seconds: 2), () => _items);
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> with AutomaticKeepAliveClientMixin {
  late Future<List<Step>> _steps;

  @override
  void initState() {
    super.initState();
    _steps = getSteps();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder<List<Step>>(
          future: _steps,
          builder: (BuildContext context, AsyncSnapshot<List<Step>> snapshot) {
            if (snapshot.hasData) {
              return StepList(steps: snapshot.data ?? []);
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StepList extends StatelessWidget {
  final List<Step> steps;
  const StepList({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        // Handle state changes if needed
      },
      children: steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
