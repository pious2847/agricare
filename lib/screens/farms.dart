import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/widgets/records/farmrecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Farms extends StatefulWidget {
  const Farms({super.key});

  @override
  State<Farms> createState() => _FarmsState();
}

class _FarmsState extends State<Farms> {
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  List<Farm> _farms = [];

  @override
  void initState() {
    loadFarms();
    super.initState();
  }

  Future<void> loadFarms() async {
    _farms = await _farmCrud.getFarms();
    setState(() {});
  }

  void _deleteFarms(int id) async {
    await _farmCrud.deleteFarm(id);
    loadFarms();
  }

  void _editFarm(Farm farm) {
    showDialog(
      context: context,
      builder: (context) => FarmModal(farm: farm),
    ).then((value) => loadFarms());
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
                  child: const Text('Add Farm'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const FarmModal();
                      },
                    ).then((value) => loadFarms());
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
                    ).then((value) => loadFarms());
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
            child: _farms.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.3), // Name
                        1: FractionColumnWidth(0.3), // Location
                        2: FractionColumnWidth(0.3), // Farm Produce
                        3: FractionColumnWidth(0.1), // Actions
                      },
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(213, 21, 131, 196),
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
                                'Location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Farm Produce',
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
                        ..._farms.map(
                          (farm) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(farm.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(farm.location),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(farm.farmproduce),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Tooltip(
                                    message: 'Edit',
                                    displayHorizontally: true,
                                    useMousePosition: false,
                                    child: IconButton(
                                      icon: const Icon(Iconsax.edit_2_copy),
                                      onPressed: () => _editFarm(farm),
                                    ),
                                  ),
                                  Tooltip(
                                    message: 'Delete',
                                    displayHorizontally: true,
                                    useMousePosition: false,
                                    child: IconButton(
                                      icon: const Icon(Iconsax.trash_copy),
                                      onPressed: () => showContentDialog(
                                          context, farm.id!),
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
              _deleteFarms(id);
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
