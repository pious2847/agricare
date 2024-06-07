import 'package:agricare/database/databaseHelper.dart';
import 'package:agricare/forms/employee.dart';
import 'package:agricare/models/employee.dart';
import 'package:agricare/utils/employee.dart';
import 'package:agricare/widgets/records/employeerecords.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  late final EmployeeCrud _employeesCrud =
      DatabaseHelper.instance.employeeCrudInstance;
 
  List<Employee> _employees = [];

  @override
  void initState() {
    loadEmployees();
    super.initState();
  }

  Future<void> loadEmployees() async {
    _employees = await _employeesCrud.getEmployees();
    setState(() {});
  }

  void _deleteEmployees(int id) async {
    await _employeesCrud.deleteEmployee(id);
    loadEmployees();
  }


  void _editEmployees(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => EmployeeModal(employee: employee),
    ).then((value) => loadEmployees());
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
                  child: const Text('Add Employee'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const EmployeeModal();
                      },
                    ).then((value) => loadEmployees());
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
                        return const GenerateEmployeesPdf();
                      },
                    ).then((value) => loadEmployees());
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
            child: _employees.isNotEmpty
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
                        ..._employees.map(
                          (Employee) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(Employee.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(Employee.contact),
                              ),
                               Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${Employee.farmAssigned}'),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${Employee.machineryAssigned}'),
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
                                      onPressed: () => _editEmployees(Employee),
                                    ),
                                  ),
                                  Tooltip(
                                    message: 'Delete',
                                    displayHorizontally: true,
                                    useMousePosition: false,
                                    child: IconButton(
                                      icon: const Icon(Iconsax.trash_copy),
                                      onPressed: () => showContentDialog(context, Employee.id!),
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
              _deleteEmployees(id);
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
