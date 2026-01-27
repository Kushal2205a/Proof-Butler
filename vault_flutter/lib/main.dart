import 'package:flutter/material.dart';
import 'serverpod_client.dart';
import 'package:file_picker/file_picker.dart';


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

class EvidenceListScreen  extends StatelessWidget{
  const EvidenceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Evidence List")),
      body: ListView(
        children: const [
          ListTile(title : Text('Placeholder rec 1') , subtitle: Text("hash : ..."),),
          ListTile(title : Text('Placeholder rec 2') , subtitle: Text("hash : ..."),)


        ],
      )

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

  Future<void> _pickImage() async{
    setState(() => _picking = true);

    try{
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if(result != null && result.files.isNotEmpty ){
        setState(() => _pickedImage = result.files.first);

      }

    }finally{
      if(mounted) {
        setState(() => _picking = false);
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
            const Align(alignment: Alignment.centerLeft, child: Text('Pick record : (placeholder)')),
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
            const SizedBox(height: 16),
            const SizedBox(width: double.infinity, child: ElevatedButton(onPressed: null, child: Text('Verify (placeholder)'))),
            const Align(alignment: Alignment.centerLeft, child: Text("Result: (placeholder)"),)

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
      }

    }finally{
      if (mounted){
        setState(() => _picking = false );

      }


    }
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
                decoration: const InputDecoration(labelText: "Note"),
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                       icon: Icon(Icons.save),
                       onPressed: ()=> {},
                       label: Text("Save (placeholder)"))

              )



            ],
          ),
      )


    );
  }


}


