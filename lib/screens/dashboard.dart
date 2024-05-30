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
                            color: const Color.fromARGB(136, 45, 218, 131),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.card_giftcard_outlined,
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
                                      'Gifts',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'enjoy free gifts',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
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
                            color: Colors.amberAccent,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.card_giftcard_outlined,
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
                                      'Gifts',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'enjoy free gifts',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    ),
                                    SizedBox(height: 7.0),
                                    Text(
                                      '60.4%',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
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
                            color: const Color.fromARGB(80, 0, 0, 0),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Inventory',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Sword x 1',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                              Text(
                                'Potion x 5',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                              Text(
                                'Armor Set',
                                style: TextStyle(fontWeight: FontWeight.w200),
                              ),
                            ],
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
