import 'package:flutter/material.dart';
import 'serverpod_client.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:vault_client/vault_client.dart';


void main() {
  initServerpodClient();
  runApp(const VaultApp());

}

class VaultApp extends StatelessWidget{
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: "Evidence Vault" , home: HomeScreen() ,
      theme: ThemeData(useMaterial3: true , colorScheme: ColorScheme.dark()),);
  }
}

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  Future<void> _serverCall(BuildContext context) async{
    try {
      final res = await client.greeting.hello('Kushal');
      final msg = (res as dynamic).message ?? res.toString();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Server : $msg")));
      }
    }catch(e){
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Server : $e")));}}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home"), actions: [IconButton(tooltip: 'Ping Backend', onPressed: ()=> _serverCall(context), icon: const Icon(Icons.cloud)), ], ),
        body: Padding(padding: const EdgeInsets.all(16),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(icon: const Icon(Icons.add),
                       onPressed: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateEvidenceScreen()));
                       },
                       label: const  Text("Add Evidence")
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_) => const VerifyEvidenceScreen()));},
                    label: const Text("Verify Evidence"),
                    icon: Icon(Icons.verified),
                ),

              ),

              const SizedBox(height : 12),

              TextButton(
                onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => const EvidenceListScreen()));
                },
                child: const Text("Evidence List(placeholder)")
              ,)



            ],
          ),
        ),
    );




  }
}

class EvidenceListScreen  extends StatefulWidget{
  const EvidenceListScreen({super.key});
  @override
  State<EvidenceListScreen> createState() => _EvidenceListScreenState();

}

class _EvidenceListScreenState extends State<EvidenceListScreen> {
  bool _loading = true ;
  String? _error ;
  List <EvidenceRecord> _records = [];

  @override
  void initState(){
    super.initState();
    _load();
  }

  Future<void> _load() async{
    setState(() {
      _loading = true ;
      _error = null ;
    });

    try {
      final rows = await client.evidence.listEvidenceRecords();
      setState(() {
        _records = rows ;
      });
    }catch(e){
      setState(() {
        _error = e.toString();
      });
    }finally{
      setState(() {
        _loading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Evidence List")),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : (_error != null) ? Center( child: Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Error: ${_error}'), const SizedBox(height: 12,), ElevatedButton(onPressed: _load, child: const Text('Retry'))],),),)
            : RefreshIndicator(child: ListView.builder(itemCount: _records.length, itemBuilder: (context,i) {
              final r  = _records[i];
              final title = (r.note != null && r.note!.trim().isNotEmpty) ? r.note!.trim() : '(untitled)';
              final shortHash = r.hash.length > 8 ? r.hash.substring(0,8) : r.hash;

            return ListTile(
              title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text("ID: ${r.id ?? "-"}\nCreated At : ${r.createdAt}"),
              trailing: Text(shortHash),
              isThreeLine: true,
            );
            }), onRefresh: _load)


    );
  }

}

class VerifyEvidenceScreen  extends StatefulWidget{
  const VerifyEvidenceScreen({super.key});

  @override
  State<VerifyEvidenceScreen> createState() => _VerifyEvidenceScreenState();

}

class _VerifyEvidenceScreenState extends State<VerifyEvidenceScreen>{
  PlatformFile? _pickedImage;
  bool _picking = false ;
  String? _sha256;
  bool _hashing = false;

  List<EvidenceRecord> _records = [] ;
  bool _loading = true ;

  EvidenceRecord? _selected ;

  bool _loadingRecords = true ;
  String? _recordsError;

  bool _verifying = false ;
  bool? _match;
  String? _storedHash;
  String? _verifyError ;

  @override
  void initState(){
    super.initState();
    _loadRecords();
  }

  Future<void> _verify() async{
    if(_selected?.id == null) return ;
    if(_sha256 == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pick an image to verify")),
      );
      return ;
    }

    setState(() {
      _verifying = true ;
      _match = null ;
      _storedHash = null;
      _verifyError = null ;
    });

    try {
      final resu = await client.evidence.verifyEvidence(_selected!.id!, _sha256!);
      setState(() {
        _match = resu;

      });
    }catch(e) {
      setState(() {
        _verifyError = e.toString();
      });
    } finally{
      if (mounted){
        setState(() {
          _verifying = false;
        });
      }
    }


  }

  Future<void> _loadRecords() async{
    setState(() {
      _loadingRecords = true ;
      _recordsError = null ;
    });

    try{
      final rows =  await client.evidence.listEvidenceRecords();
      if (!mounted) return ;
      setState(() {
        _records = rows;
        _selected = rows.isNotEmpty ? rows.first : null ;
      });
    }catch(e){
      if (!mounted) return ;
      setState(() {
        _recordsError = e.toString();
      });
    }finally{
      if(mounted) _loadingRecords = false ;
    }
  }
  Future<void> _pickImage() async{
    setState(() => _picking = true);

    try{
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if(result != null && result.files.isNotEmpty ){
        setState(() => _pickedImage = result.files.first);
        await _hashin();

      }

    }finally{
      if(mounted) {
        setState(() => _picking = false);
      }

    }
  }

  Future<void> _hashin() async{
    final file = _pickedImage;
    if (file == null) return ;

    setState(() {
      _hashing = true;
      _sha256 = null ;
    });

    try{
      Uint8List bytes ;
      if(file.bytes != null){
        bytes = file.bytes!;
      }
      else if(file.path != null){
        bytes = await File(file.path!).readAsBytes();
      }
      else{
        throw Exception("No bytes or path available for hashing");
      }

      final digest = sha256.convert(bytes).toString();

      if(!mounted) return;
      setState(() => _sha256 = digest);
    }finally{
      if(mounted){
        setState(() => _hashing = false);
      }
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Evidence"),) ,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if(_loadingRecords)
              const Align(alignment: Alignment.centerLeft, child: Text('Loading Records....'),)
            else if (_recordsError != null)
              Align(alignment: Alignment.centerLeft,child: Text("Error load record ${_recordsError} "),)
            else if (_records.isEmpty)
              Align(alignment: Alignment.centerLeft, child: Text("No records available, create one"),)
            else
              DropdownButton<EvidenceRecord>(
                isExpanded: true,
                value: _selected,
                items : _records.map((r){
                  return DropdownMenuItem<EvidenceRecord>(
                    value: r,
                    child: Text('ID ${r.id ?? "-"}'),
                  );
                }).toList(),
                onChanged: (v){
                  setState(() {
                    _selected = v ;
                    _match = null ;
                    _storedHash = null ;
                    _verifyError = null ;
                  });
                },
              ),
            const SizedBox(height: 8,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('File: ${_pickedImage?.name ?? "(not selected)"}'),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Size: ${_pickedImage?.size != null ? "${_pickedImage!.size} bytes" : "-"}'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _picking ? null : _pickImage,
                icon: const Icon(Icons.image),
                label: Text(_picking ? 'Picking...' : 'Pick Image'),
              ),
            ),
            const SizedBox(height: 8,),

            Align(alignment: Alignment.centerLeft, child: Text(_hashing? 'SHA-256: hashing' : 'SHA-256: ${_sha256 ?? "-"}'),),

            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _verifying ? null : _verify, child: Text(_verifying ? 'Verifying' : 'Verify' ))),
            const SizedBox(height: 12,),
            Align(alignment: Alignment.centerLeft, child: Text(
              _verifyError != null
                  ? 'Error: $_verifyError'
                  : (_match == null)
                  ? 'Result: -'
                  : (_match! ? 'Result: MATCH' : 'Result: MISMATCH'),
                 ),),

            if (_storedHash != null)
              Align(alignment: Alignment.centerLeft,
              child: Text('Stored Hash : ${_storedHash}'),),

            Align(alignment: Alignment.centerLeft, child: Text('Computed Hash : ${_sha256 ?? "-"}'),)

          ],
        ),
      ) ,

    );
  }



}
class CreateEvidenceScreen extends StatefulWidget {
  const CreateEvidenceScreen({super.key});

  @override
  State<CreateEvidenceScreen> createState() => _CreateEvidenceScreenState();
}
class _CreateEvidenceScreenState  extends State<CreateEvidenceScreen>{
  final _noteCtrl = TextEditingController();
  PlatformFile? _pickedImage ;
  bool _picking =  false ;

  String? _sha256;
  bool _hashing = false;

  bool _saving = false ;
  int? _savedId ;
  String? _saveError ;


  @override
  void dispose()
  {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async{
    setState(() => _picking = true);

    try{
      final result = await FilePicker.platform.pickFiles(
        type : FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty){
        setState(() => _pickedImage = result.files.first);
        await _hashin();
      }

    }finally{
      if (mounted){
        setState(() => _picking = false );

      }


    }
  }

  Future<void> _hashin() async{
    final file = _pickedImage;
    if (file == null) return ;

    setState(() {
      _hashing = true;
      _sha256 = null ;
    });

    try{
      Uint8List bytes ;
      if(file.bytes != null){
        bytes = file.bytes!;
      }
      else if(file.path != null){
        bytes = await File(file.path!).readAsBytes();
      }
      else{
        throw Exception("No bytes or path available for hashing");
      }

      final digest = sha256.convert(bytes).toString();

      if(!mounted) return;
      setState(() => _sha256 = digest);
    }finally{
      if(mounted){
        setState(() => _hashing = false);
      }
    }
  }

  Future<void> _saveEvidence() async {
    if (_sha256 == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pick an image first"))

      );
      return;
    }

    final title = _noteCtrl.text.trim();
    if(title.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title is required"))

      );
      return ;

    }

    setState(() {
      _saving = true ;
      _savedId = null ;
      _saveError = null ;

    });

    try {
      final saved =   await client.evidence.createEvidenceRecord(_sha256!, title );
      setState(() => _savedId = saved.id);

    }catch(e){}finally{}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Evidence")),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(alignment: Alignment.centerLeft,
                          child: Text("File : ${_pickedImage?.name ?? "(not selected)" } "),
              ),
              const SizedBox(height:8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Size: ${_pickedImage?.size != null ? '${_pickedImage!.size} bytes' : '-'}'),
              ),
              const SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    icon:Icon(Icons.image),
                    onPressed: _picking ? null : _pickImage, label: Text(_picking ? 'Picking' : 'Pick Image'),
                )
              ),
              const SizedBox(height: 12,),

              TextField(
                controller: _noteCtrl,
                decoration: const InputDecoration(labelText: "Title"),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                       icon: Icon(Icons.save),
                       onPressed:  _saving ? null : _saveEvidence,
                       label: Text("Save"))

              ),

              if(_savedId != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Evidence ID : ${_savedId}'),
                ),
              if (_saveError != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Save error : ${_saveError}'),
                ),

              const SizedBox(height: 8,),

              Align(alignment: Alignment.centerLeft, child: Text(_hashing? 'SHA-256: hashing' : 'SHA-256: ${_sha256 ?? "-"}'),)



            ],
          ),
      )


    );
  }


}


