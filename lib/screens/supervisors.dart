import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/supervisor.dart';
import 'package:agricare/models/supervisor.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supervisor.dart';
import 'package:agricare/widgets/records/farmrecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as Material;
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SupervisorPage extends StatefulWidget {
  const SupervisorPage({super.key});

  @override
  State<SupervisorPage> createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  late final SupervisorCrud _supervisorCrud =
      DatabaseHelper.instance.supervisorCrudInstance;
  late final FarmCrud _farmsCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Supervisor> _supervisors = [];

  @override
  void initState() {
    loadSupervisors();
    super.initState();
  }

  Future<void> loadSupervisors() async {
    _supervisors = await _supervisorCrud.getSupervisors();
    setState(() {});
  }

  void _deleteSupervisor(int id) async {
    await _supervisorCrud.deleteSupervisor(id);
    loadSupervisors();
  }

  Future<String> _getFarmName(int? id) async {
    final farm = await _farmsCrud.getFarmById(id!);
    return farm.isNotEmpty ? farm.first.name : 'Unknown Farm';
  }

  void _editSupervisor(Supervisor supervisor) {
    showDialog(
      context: context,
      builder: (context) => SupervisorModal(supervisor: supervisor),
    ).then((value) => loadSupervisors());
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
                  child: const Text('Add Supervisor'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SupervisorModal();
                      },
                    ).then((value) => loadSupervisors());
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Button(
                  child: const Text('Print Preview'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const GeneratePdf();
                      },
                    ).then((value) => loadSupervisors());
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: _supervisors.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.3), // Name
                        1: FractionColumnWidth(0.2), // Contact
                        2: FractionColumnWidth(0.2), // Assigned Farm
                        3: FractionColumnWidth(0.2), // Notes
                        4: FractionColumnWidth(0.1), // Action
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
                                'Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Contact',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Assigned Farm',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Notes',
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
                        ..._supervisors.map(
                          (supervisor) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.contact),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<String>(
                                  future: _getFarmName(supervisor.farmsAssigned),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Material.CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Text('Error');
                                    } else {
                                      return Text(snapshot.data ?? 'Unknown Farm');
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(supervisor.notes),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Tooltip(
                                    message: 'Edit',
                                    displayHorizontally: true,
                                    useMousePosition: false,
                                    child: IconButton(
                                      icon: const Icon(Iconsax.edit_2_copy),
                                      onPressed: () => _editSupervisor(supervisor),
                                    ),
                                  ),
                                  Tooltip(
                                    message: 'Delete',
                                    displayHorizontally: true,
                                    useMousePosition: false,
                                    child: IconButton(
                                      icon: const Icon(Iconsax.trash_copy),
                                      onPressed: () => showContentDialog(context, supervisor.id!),
                                    ),
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
                    child: Text('No farms added yet'),
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
              _deleteSupervisor(id);
              Navigator.pop(context);
            },
          ),
          FilledButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, 'User canceled deletion');
            },
          ),
        ],
      ),
    );
    debugPrint('Content Dialog Result: $result');
  }
}
