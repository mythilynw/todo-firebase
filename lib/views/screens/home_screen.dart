import 'package:flutter/material.dart';

import 'todo_grid_screen.dart';
import 'todo_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  bool isGridView = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(
                  20,
                ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [
                /// TOP SECTION

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: const [
                        Text(
                          'Hello 👋',

                          style: TextStyle(
                            fontSize: 30,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Text(
                          'Manage your daily todos',

                          style: TextStyle(
                            fontSize: 16,

                            color:
                                Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const CircleAvatar(
                      radius: 28,

                      backgroundColor:
                          Colors.blue,

                      child: Icon(
                        Icons.person,

                        color:
                            Colors.white,

                        size: 30,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                /// BANNER CARD

                Container(
                  width:
                      double.infinity,

                  padding:
                      const EdgeInsets.all(
                        20,
                      ),

                  decoration: BoxDecoration(
                    gradient:
                        const LinearGradient(
                          colors: [
                            Color(
                              0xFF4A80F0,
                            ),

                            Color(
                              0xFF7F56D9,
                            ),
                          ],
                        ),

                    borderRadius:
                        BorderRadius.circular(
                          25,
                        ),
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.task_alt,

                        size: 60,

                        color:
                            Colors.white,
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: const [
                            Text(
                              'Track Your Tasks',

                              style: TextStyle(
                                color:
                                    Colors
                                        .white,

                                fontSize:
                                    24,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Text(
                              'Complete your daily goals easily.',

                              style: TextStyle(
                                color:
                                    Colors
                                        .white70,

                                fontSize:
                                    15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                /// TITLE + TOGGLE BUTTONS

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    const Text(
                      'Todo Views',

                      style: TextStyle(
                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.all(
                            5,
                          ),

                      decoration: BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                              16,
                            ),
                      ),

                      child: Row(
                        children: [
                          /// LIST VIEW BUTTON

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isGridView =
                                    false;
                              });
                            },

                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                    horizontal:
                                        18,

                                    vertical:
                                        10,
                                  ),

                              decoration: BoxDecoration(
                                color:
                                    !isGridView
                                    ? Colors
                                        .blue
                                    : Colors
                                        .transparent,

                                borderRadius:
                                    BorderRadius.circular(
                                      12,
                                    ),
                              ),

                              child: Row(
                                children: [
                                  Icon(
                                    Icons
                                        .view_list_rounded,

                                    color:
                                        !isGridView
                                        ? Colors
                                            .white
                                        : Colors
                                            .grey,
                                  ),

                                  const SizedBox(
                                    width:
                                        8,
                                  ),

                                  Text(
                                    'List',

                                    style: TextStyle(
                                      color:
                                          !isGridView
                                          ? Colors
                                              .white
                                          : Colors
                                              .grey,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 6,
                          ),

                          /// GRID VIEW BUTTON

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isGridView =
                                    true;
                              });
                            },

                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                    horizontal:
                                        18,

                                    vertical:
                                        10,
                                  ),

                              decoration: BoxDecoration(
                                color:
                                    isGridView
                                    ? Colors
                                        .purple
                                    : Colors
                                        .transparent,

                                borderRadius:
                                    BorderRadius.circular(
                                      12,
                                    ),
                              ),

                              child: Row(
                                children: [
                                  Icon(
                                    Icons
                                        .grid_view_rounded,

                                    color:
                                        isGridView
                                        ? Colors
                                            .white
                                        : Colors
                                            .grey,
                                  ),

                                  const SizedBox(
                                    width:
                                        8,
                                  ),

                                  Text(
                                    'Grid',

                                    style: TextStyle(
                                      color:
                                          isGridView
                                          ? Colors
                                              .white
                                          : Colors
                                              .grey,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                /// SCREEN VIEW

                SizedBox(
                  height:
                      MediaQuery.of(context)
                          .size
                          .height,

                  child:
                      AnimatedSwitcher(
                        duration:
                            const Duration(
                              milliseconds:
                                  300,
                            ),

                        child: isGridView
                            ? const TodoGridScreen()
                            : const TodoListScreen(),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}