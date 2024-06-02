import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/utils/farm.dart';
import 'package:flutter/material.dart';
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
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const FarmModal();
                    },
                  );
                },
                icon: const Icon(Iconsax.additem_copy),
                label: const Text('Add Farm'),
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: _farms.isNotEmpty
                ? DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Location')),
                      DataColumn(label: Text('Farm Produce')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _farms
                        .map(
                          (farm) => DataRow(cells: [
                            DataCell(Text(farm.name)),
                            DataCell(Text(farm.location)),
                            DataCell(Text(farm.farmproduce)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editFarm(farm),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteFarms(farm.id!),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )
                        .toList(),
                  )
                : const Center(
                    child: Text('No farms added yet'),
                  ),
          ),
        ),
     
      ],
    ),
  );
}
}
