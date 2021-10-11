import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

import 'blocs/drop_file_bloc/drop_file_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late DropzoneViewController controller;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocProvider<DropFileBloc>(
          create: (context) => DropFileBloc(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: LayoutBuilder(
                  builder: (context, ctrs) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: ctrs.maxHeight,
                          width: ctrs.maxWidth,
                          child: DropzoneView(
                            mime: const ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"],
                            onDrop: (value) {
                              BlocProvider.of<DropFileBloc>(context).add(
                                DropFileEventGetFile(
                                  dropzoneViewController: controller,
                                  value: value,
                                ),
                              );
                            },
                            onCreated: (DropzoneViewController ctrl) => controller = ctrl,
                            onLoaded: () => print('Zone loaded'),
                            onError: (String? ev) => print('Error: $ev'),
                            onHover: () => print('Zone hovered'),
                            onLeave: () => print('Zone left'),
                            operation: DragOperation.copy,
                            cursor: CursorType.grab,
                          ),
                        ),
                        Container(
                          height: ctrs.maxHeight,
                          width: ctrs.maxWidth,
                          color: Colors.amber,
                          child: const Center(child: Text('Drop files here')),
                        ),
                      ],
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
