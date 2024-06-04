import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/forms/supplies.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SuppliesScreen extends StatefulWidget {
  const SuppliesScreen({super.key});

  @override
  State<SuppliesScreen> createState() => _SuppliesScreenState();
}

class _SuppliesScreenState extends State<SuppliesScreen> {
  late final SuppliesCrud _suppliesCrud = DatabaseHelper.instance.suppliesCrudInstance;

  List<Supplies> _supplies = [];

  @override
  void initState() {
    loadsupplies();
    super.initState();
  }

  Future<void> loadsupplies() async {
    _supplies = await _suppliesCrud.getSupplies();
    setState(() {});
  }

  void _deletesupplies(int id) async {
    await _suppliesCrud.deleteSupplies(id);
    loadsupplies();
  }

  void _editSupplies(Supplies supplies) {
    showDialog(
      context: context,
      builder: (context) => SuppliesModal(supplies: supplies),
    ).then((value) => loadsupplies());
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
                  child: const Text('Add Supplies'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const SuppliesModal(),
                    ).then((value) => loadsupplies());
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
            child: Expanded(
              flex: 1,
              child: _supplies.isNotEmpty
                  ? SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const {
                          0: FractionColumnWidth(0.05), // ID
                          1: FractionColumnWidth(0.3), // Product
                          3: FractionColumnWidth(0.3), // Stock
                          4: FractionColumnWidth(0.3), // Description
                          5: FractionColumnWidth(0.05), // Actions
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
                                  'Products',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Stock',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Description',
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
                          ..._supplies.map(
                            (supplies) => TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${supplies.id}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(supplies.product),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${supplies.stock}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(supplies.description),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.01,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Tooltip(
                                        message: 'Edit',
                                        displayHorizontally: true,
                                        useMousePosition: false,
                                        child: IconButton(
                                          icon: const Icon(Iconsax.edit_2_copy),
                                          onPressed: () => _editSupplies(supplies),
                                        ),
                                      ),
                                      Tooltip(
                                        message: 'Delete',
                                        displayHorizontally: true,
                                        useMousePosition: false,
                                        child: IconButton(
                                          icon: const Icon(Iconsax.trash_copy),
                                          onPressed: () =>
                                              showContentDialog(context,supplies.id!),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('No supplies added yet'),
                    ),
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
              _deletesupplies(id);
              Navigator.pop(context,);
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
