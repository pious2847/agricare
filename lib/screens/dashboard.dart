import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/admin.dart';
import 'package:agricare/forms/employee.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/forms/machinery_modal.dart';
import 'package:agricare/forms/supervisor.dart';
import 'package:agricare/forms/supplies.dart';
import 'package:agricare/models/supplies.dart';
import 'package:agricare/utils/supplies.dart';
import 'package:agricare/widgets/totalemployee.dart';
import 'package:agricare/widgets/totalfarms.dart';
import 'package:agricare/widgets/totalmachinery.dart';
import 'package:agricare/widgets/totalsupervisors.dart';
import 'package:agricare/widgets/totalsupplies.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as Material;
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final SuppliesCrud _suppliesCrud =
      DatabaseHelper.instance.suppliesCrudInstance;

  List<Supplies> _supplies = [];

  late final _getEmployeeTotal =
      TotalEmployeesWidget(); // Use the TotalEmployeesWidget here

  late final _getFarmsTotal = TotalFarmsWidget();
  late final _getSupervisorsTotal = const TotalSupervisorWidget();
  late final _getMachineryTotal = const TotalMachinerysWidget();
  late final _getTotalSupplies = TotalSuppliesWidget();

  void _updateCount() {
    setState(() {
      _getSupervisorsTotal;
      _getEmployeeTotal;
      _getFarmsTotal;
      _getMachineryTotal;
      _getTotalSupplies;
    });
  }

  Future<void> loadsupplies() async {
    _supplies = await _suppliesCrud.getLowStock();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    loadsupplies();
    _updateCount();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TotalCards(context),
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Iconsax.user_octagon_copy,
                                  size: 80.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      'Total Employees',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    TotalEmployeesWidget(), // Use the TotalEmployeesWidget here
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.user_octagon_copy,
                                  size: 80.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Total Supervisors',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    TotalSupervisorWidget(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: Material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.truck_copy,
                                  size: 80.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Total Machinery',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    TotalMachinerysWidget(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Iconsax.user_octagon_copy,
                                  size: 80.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    const Text(
                                      'Total Farms',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    TotalFarmsWidget(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Material.Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.shopping_bag_copy,
                                  size: 80.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Total Products',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    TotalSuppliesWidget(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'Supplies Low In Stock',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
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
                            color: Color.fromARGB(204, 68, 138, 245),
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
                                child: Text(
                                  supplies.product,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${supplies.stock}',
                                  style: TextStyle(color: Colors.red),
                                ),
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
                                      child: IconButton(
                                        icon: const Icon(Iconsax.edit_2_copy),
                                        onPressed: () =>
                                            _editSupplies(supplies),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Delete',
                                      child: IconButton(
                                        icon: const Icon(Iconsax.trash_copy),
                                        onPressed: () => showContentDialog(
                                            context, supplies.id!),
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

  SizedBox TotalCards(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Material.TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const EmployeeModal();
                    },
                  ).then((value) => setState(() {}));
                },
                icon: const Icon(Iconsax.additem_copy),
                label: const Text('Add Employees')),
            const SizedBox(
              width: 10,
            ),
            Material.TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SupervisorModal();
                  },
                ).then((value) => setState(() {
                      _updateCount();
                    }));
              },
              icon: const Icon(Iconsax.additem_copy),
              label: const Text('Add Supervisor'),
            ),
            const SizedBox(
              width: 10,
            ),
            Material.TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const FarmModal();
                    },
                  ).then((value) => setState(() {}));
                },
                icon: const Icon(Iconsax.additem_copy),
                label: const Text('Add Farm')),
            const SizedBox(
              width: 10,
            ),
            Material.TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SuppliesModal();
                  },
                ).then((value) => setState(() {}));
              },
              icon: const Icon(Iconsax.additem_copy),
              label: const Text('Add Supplies'),
            ),
            const SizedBox(
              width: 10,
            ),
            Material.TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const MachineryModal();
                  },
                ).then((value) => _updateCount());
              },
              icon: const Icon(Iconsax.additem_copy),
              label: const Text('Add Machinery'),
            ),
            const SizedBox(
              width: 10,
            ),
            Material.TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AdminModal();
                    },
                  );
                },
                icon: const Icon(Iconsax.additem_copy),
                label: const Text('Add Admin')),
          ],
        ),
      ),
    );
  }
}
