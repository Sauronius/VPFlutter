import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dc_video_player/VideoRoute.dart';
import 'package:path_provider/path_provider.dart';

class FNArgument {
  final String fName;
  final File fPath;

  FNArgument(this.fPath, this.fName);
}

class FilePickRoute extends StatefulWidget {
  @override
  _FilePickRouteState createState() => _FilePickRouteState();
}

class _FilePickRouteState extends State<FilePickRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  List<PlatformFile> _paths;
  String _directoryPath;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.video;
  String _completeVideoPath;

  @override
  void initState() {
    super.initState();
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths.first.extension);
      _fileName = _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });
  }

  Future<void> _saveFavourite() async {
    if (_fileName != null && _completeVideoPath != null)
      {

      }
    }

  void _openVideo() {
    if (_fileName != null)
      Navigator.pushNamed(context, VideoRoute.routeName,
          arguments: FNArgument(File(_completeVideoPath), _fileName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _openFileExplorer(),
                      child: const Text("Open file picker"),
                    ),
                    ElevatedButton(
                      onPressed: () => _saveFavourite(),
                      child: const Text("Add to Favourites"),
                    ),
                    ElevatedButton(
                        onPressed: () => _openVideo(),
                        child: const Text("Open Video"))
                  ],
                ),
              ),
              Builder(
                builder: (BuildContext context) => _loadingPath
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: const CircularProgressIndicator(),
                      )
                    : _directoryPath != null
                        ? ListTile(
                            title: const Text('Directory path'),
                            subtitle: Text(_directoryPath),
                          )
                        : _paths != null
                            ? Container(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: Scrollbar(
                                    child: ListView.separated(
                                  itemCount: _paths != null && _paths.isNotEmpty
                                      ? _paths.length
                                      : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final bool isMultiPath =
                                        _paths != null && _paths.isNotEmpty;
                                    final String name = 'File: ' +
                                        (isMultiPath
                                            ? _paths
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...');
                                    final path = _paths
                                        .map((e) => e.path)
                                        .toList()[index]
                                        .toString();

                                    _completeVideoPath = path;

                                    return ListTile(
                                      title: Text(
                                        name,
                                      ),
                                      subtitle: Text('$path'),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                )),
                              )
                            : const SizedBox(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
