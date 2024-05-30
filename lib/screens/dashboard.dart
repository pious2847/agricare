import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                      onPressed: () {},
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Employees')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Supervisor')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Farm')),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.additem_copy),
                      label: const Text('Add Machinery')),
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
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.user_octagon_copy,
                                  size: 80.0,
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
                                      'Total Employees',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),                             
                                    SizedBox(height: 3.0),
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent
                                          ),
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
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(136, 45, 218, 131)),
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
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(188, 100, 218, 45)),
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
              const SizedBox(height: 20,),
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
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Iconsax.user_octagon_copy,
                                  size: 80.0,
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
                                      'Total Farms',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),                             
                                    SizedBox(height: 3.0),
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 54.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent
                                          ),
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
                                          color: Color.fromARGB(136, 45, 218, 131)),
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
