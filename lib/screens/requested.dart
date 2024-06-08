import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/requested.dart';
import 'package:agricare/forms/supplies.dart';
import 'package:agricare/models/requested.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/requested.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:agricare/widgets/records/requestedrecords.dart';
import 'package:agricare/widgets/records/suppliesrecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RequestedScreen extends StatefulWidget {
  const RequestedScreen({super.key});

  @override
  State<RequestedScreen> createState() => _RequestedScreenState();
}

class _RequestedScreenState extends State<RequestedScreen> {
  late final RequestedCrud _requestedCrud =
      DatabaseHelper.instance.requestedCrudInstance;

  List<Requested> _requested = [];

  @override
  void initState() {
    loadRequested();
    super.initState();
  }

  Future<void> loadRequested() async {
    _requested = await _requestedCrud.getRequested();
    setState(() {});
  }

  void _deleteRequested(int id) async {
    await _requestedCrud.deleteRequested(id);
    loadRequested();
  }

  void _editRequested(Requested requested) {
    showDialog(
      context: context,
      builder: (context) => RequestedModal(requested: requested),
    ).then((value) => loadRequested());
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
                  child: const Text('Add Requested'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const RequestedModal(),
                    ).then((value) => loadRequested());
                  },
                ),
                Button(
                  child: const Text('Print Preview'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const GenerateRequestedPdf(),
                    ).then((value) => loadRequested());
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
            child: _requested.isNotEmpty
                ? SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FractionColumnWidth(0.05), // ID
                        1: FractionColumnWidth(0.3), // Product
                        3: FractionColumnWidth(0.15), // quantity
                        4: FractionColumnWidth(0.3), // Description
                        5: FractionColumnWidth(0.06), // Actions
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
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Farm Requesting',
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
                        ..._requested.map(
                          (requesting) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${requesting.id}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(requesting.product),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${requesting.quantity}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(requesting.farmRequesting),
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
                                        onPressed: () =>
                                            _editRequested(requesting),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Delete',
                                      displayHorizontally: true,
                                      useMousePosition: false,
                                      child: IconButton(
                                        icon: const Icon(Iconsax.trash_copy),
                                        onPressed: () => showContentDialog(
                                            context, requesting.id!),
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
                    child: Text('No supplies requested yet'),
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
              _deleteRequested(id);
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
