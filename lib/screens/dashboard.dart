import 'package:fluent_ui/fluent_ui.dart';
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
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
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
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RPG Stats',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Hero Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                              color: Colors.blue),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Level 5 Warrior',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    color: Color.fromARGB(255, 206, 206, 206),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Health',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            '100%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Mana',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            '80%',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatar.jpg'),
                                radius: 60.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 350.0,
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
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quest Progress',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Epic Journey',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                              color: Colors.greenAccent),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Ongoing',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    color: Color.fromARGB(255, 206, 206, 206),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Monsters Slain',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            '25',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Gold Earned',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            '500',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/avatar1.jpeg'),
                                radius: 60.0,
                              )
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
