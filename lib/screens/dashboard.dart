import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/admin.dart';
import 'package:agricare/forms/employee.dart';
import 'package:agricare/forms/farm_form.dart';
import 'package:agricare/forms/machinery_modal.dart';
import 'package:agricare/forms/supplies.dart';
import 'package:agricare/models/farm.dart';
import 'package:agricare/models/machinery.dart';
import 'package:agricare/screens/farms.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/utils/farm.dart';
import 'package:agricare/widgets/totalemployee.dart';
import 'package:agricare/widgets/totalfarms.dart';
import 'package:agricare/widgets/totalmachinery.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final _TotalFarms;
  late final FarmCrud _farmCrud = DatabaseHelper.instance.farmCrudInstance;

  late final _getEmployeeTotal =
      TotalEmployeesWidget(); // Use the TotalEmployeesWidget here

  late var _getFarmsTotal = TotalFarmsWidget();
  late var _getMachineryTotal = const TotalMachinerysWidget();

  void _updateCount() {
    setState(() {
      _getEmployeeTotal;
      _getFarmsTotal = TotalFarmsWidget();
      ;
      _getMachineryTotal = const TotalMachinerysWidget();
      ;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEmployeeTotal;
    _getFarmsTotal;
    _getMachineryTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const EmployeeForm();
                          },
                        ).then((value) => setState(() {}));
                      },
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Employees')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Farms();
                          },
                        ).then((value) => setState(() {
                              _updateCount();
                            }));
                      },
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Supervisor')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
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
                  TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const SuppliesModal();
                          },
                        ).then((value) => setState(() {}));
                      },
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Supplies')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const MachineryModal();
                        },
                      ).then((value) =>
                            _updateCount()
                          );
                    },
                    icon: const Icon(Iconsax.additem_copy),
                    label: const Text('Add Machinery'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
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
          ),
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
                      child: Card(
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
                      child: Card(
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
                                    Text(
                                      '76',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              136, 45, 218, 131)),
                                    ),
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
                      child: Card(
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
                      child: Card(
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
                      child: Card(
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
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              136, 45, 218, 131)),
                                    ),
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
          )
        ],
      ),
    );
  }
}
