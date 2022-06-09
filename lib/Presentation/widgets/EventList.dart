import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/bloc.dart';

class EventList extends StatelessWidget {
  EventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      if (state is EventsLoaded) {
        return Column(
          children: [
            // Container(
            //   height: 50,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: TextField(
            //       // onChanged: (value) => _runFilter(value),
            //       cursorColor: Colors.grey,
            //       decoration: InputDecoration(
            //         contentPadding:
            //             EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //         filled: true,
            //         fillColor: Colors.grey.shade200,
            //         prefixIcon: Icon(Icons.search, color: Colors.grey),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(50),
            //             borderSide: BorderSide.none),
            //         hintText: "Search for Events",
            //         hintStyle: TextStyle(fontSize: 14),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(children: [
                                Container(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            'https://www.kindpng.com/picc/m/701-7015112_tick-mark-symbol-icon-check-mark-symbol-transparent.png')
                                        // child: Image.asset('assets/images/logo.png'),
                                        )),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(job.title,
                                        Text(state.events[index].location,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        // Text(job.address,
                                        Text(state.events[index].description,
                                            style: TextStyle(
                                                color: Colors.grey[500])),
                                      ]),
                                )
                              ]),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/games",
                                    arguments: state.events[index].eventId);
                              },
                              child: AnimatedContainer(
                                  height: 35,
                                  padding: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        // color: job.isMyFav
                                        //     ? Colors.red.shade100
                                        //     : Colors.grey.shade300,
                                        color: Colors.grey.shade300,
                                      )),
                                  child: Center(
                                    // child: job.isMyFav
                                    //     ? const Icon(
                                    //         Icons.favorite,
                                    //         color: Colors.red,
                                    //       )
                                    //     : Icon(
                                    //         Icons.favorite_outline,
                                    //         color: Colors.grey.shade600,
                                    //       ))
                                    child: Icon(
                                      Icons.navigate_next_outlined,
                                      color: Colors.grey.shade600,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade200),
                                    child: const Text(
                                      // job.type,
                                      'Pro',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200,
                                      // color: Color(
                                      //         int.parse("0xff${job.experienceLevelColor}"))
                                      //     .withAlpha(20)
                                    ),
                                    child: const Text(
                                      // job.experienceLevel,
                                      'experience',
                                      style: TextStyle(
                                        color: Colors.black,
                                        // color: Color(
                                        //     int.parse("0xff${job.experienceLevelColor}"))
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                '5 yrs ago',
                                // job.timeAgo,
                                style: TextStyle(
                                    color: Colors.grey.shade800, fontSize: 12),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
      return Container();
    });
  }
}
