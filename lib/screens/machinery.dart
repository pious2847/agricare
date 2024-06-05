import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/forms/machinery_modal.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/machinery.dart';
import 'package:agricare/widgets/records/machineryrecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Machinerys extends StatefulWidget {
  const Machinerys({super.key});

  @override
  State<Machinerys> createState() => _MachinerysState();
}

class _MachinerysState extends State<Machinerys> {
  late final MachineryCrud _machineryCrud =
      DatabaseHelper.instance.machineryCrudInstance;

  List<Machinery> _Machinerys = [];

  @override
  void initState() {
    loadMachinerys();
    super.initState();
  }

  Future<void> loadMachinerys() async {
    _Machinerys = await _machineryCrud.getMachinery();
    setState(() {});
  }

  void _deleteMachinerys(int id) async {
    await _machineryCrud.deleteMachinery(id);
    loadMachinerys();
  }

  void _editMachinerys(Machinery machinery) {
    showDialog(
      context: context,
      builder: (context) => MachineryModal(machinery: machinery),
    ).then((value) => loadMachinerys());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Button(
                  child: const Text('Add Machinery'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const MachineryModal(),
                    ).then((value) => loadMachinerys());
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Button(
                  child: const Text('Print Preview'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context){
                       return const GenerateMachineryPdf();
                      },
                    ).then((value) => loadMachinerys());
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: _Machinerys.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.3), // Name
                        1: FractionColumnWidth(0.3), // TagNumber
                        3: FractionColumnWidth(0.1), // Actions
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(106, 50, 49, 48),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'ID',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'TagNumber',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Actions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ..._Machinerys.map(
                          (machinery) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${machinery.id}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(machinery.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(machinery.tagNumber),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: const Icon(Iconsax.edit_2_copy),
                                    onPressed: () => _editMachinerys(machinery),
                                  ),
                                  IconButton(
                                    icon: const Icon(Iconsax.trash_copy),
                                    onPressed: () => showContentDialog(
                                        context, machinery.id!),
                                    // _deleteMachinerys(machinery.id!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: Text('No Machinerys added yet'),
                  ),
          ),
        ],
      ),
    );
  }

  void showContentDialog(BuildContext context, int id) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Delete permanently?'),
        content: const Text(
          'If you delete this file, you won\'t be able to recover it. Do you want to delete it?',
        ),
        actions: [
          Button(
            child: const Text('Delete'),
            onPressed: () {
              _deleteMachinerys(id);
              Navigator.pop(
                context,
              );
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }
}
