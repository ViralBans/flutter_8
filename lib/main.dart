import 'package:flutter/material.dart';
import 'package:flutter_8/fetch_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'HomeWork 8'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  late String _searchResult;
  String _fileContent = '', _fileName = '';

  void _searchTextField() async {
    setState(() {
      _searchResult = _controller.text;
    });
    try {
      await fetchFileFromAssets(_searchResult);
      _fileName = _searchResult;
    } catch (e) {
      _fileName = 'файл не найден';
    }
  }

  Future<String> getFile(String str) async {
    try {
      _fileContent = await fetchFileFromAssets(str);
      return _fileContent;
    } catch (e) {
      _fileContent = '';
      return _fileContent;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Имя файла (например data.txt)',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                      suffixIcon: ElevatedButton(
                        onPressed: _searchTextField,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Найти'),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  _fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getFile(_fileName),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          return SingleChildScrollView(
                            child: Text(_fileContent),
                          );
                        default:
                          return const Text('');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
