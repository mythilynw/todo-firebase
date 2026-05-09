import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // TOP SECTION
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: const [
                      Text(
                        'Hello 👋',

                        style: TextStyle(
                          fontSize: 30,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Manage your daily todos',

                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const CircleAvatar(
                    radius: 28,

                    backgroundColor: Colors.blue,

                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // BANNER CARD
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4A80F0),
                      Color(0xFF7F56D9),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.task_alt,
                      size: 60,
                      color: Colors.white,
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: const [
                          Text(
                            'Track Your Tasks',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Complete your daily goals easily.',

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Todo Views',

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // LISTVIEW CARD
              GestureDetector(
                onTap: () {
                  context.push('/todo-list');
                },

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                              alpha: 0.05,
                            ),

                        blurRadius: 10,

                        offset: const Offset(
                          0,
                          5,
                        ),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(
                              18,
                            ),

                        decoration: BoxDecoration(
                          color: Colors.blue
                              .withValues(
                                alpha: 0.1,
                              ),

                          borderRadius:
                              BorderRadius.circular(
                                18,
                              ),
                        ),

                        child: const Icon(
                          Icons.view_list_rounded,

                          color: Colors.blue,

                          size: 40,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: const [
                            Text(
                              'ListView Todos',

                              style: TextStyle(
                                fontSize: 22,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              'View todos.',

                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}