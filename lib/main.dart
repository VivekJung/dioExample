import 'package:dioapi/api/dio/dio_client.dart';
import 'package:dioapi/model/user_model.dart';
import 'package:dioapi/widgets/input_field.dart';
import 'package:dioapi/widgets/output_error.dart';
import 'package:dioapi/widgets/output_panel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DioScreen(),
    );
  }
}

class DioScreen extends StatelessWidget {
  const DioScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DioClient dioClient = DioClient();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio example'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      )),
    );
  }
}

class GETMETHODTile extends StatefulWidget {
  const GETMETHODTile({Key? key, required this.dioClient}) : super(key: key);
  final DioClient dioClient;

  @override
  State<GETMETHODTile> createState() => _GETMETHODTileState();
}

class _GETMETHODTileState extends State<GETMETHODTile> {
  final TextEditingController _idController = TextEditingController();
  int? userId;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('GET Method'),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enter the ID of the user:'),
            SizedBox(
              width: 100,
              child: DataInputField(
                controller: _idController,
                inputType: TextInputType.number,
                onSubmitted: (id) => setState(() => userId = int.parse(id)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        userId == null
            ? const OutputPanel()
            : FutureBuilder<User?>(
                future: widget.dioClient.getUserByID(id: userId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const OutputPanel(showLoading: true);
                  } else if (snapshot.hasError) {
                    return OutputError(errorMessage: snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    return OutputPanel(user: snapshot.data);
                  } else {
                    return const OutputPanel();
                  }
                },
              ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
