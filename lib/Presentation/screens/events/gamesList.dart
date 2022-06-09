import 'dart:io';
import 'package:dev_scout_fds/Bloc/EventBloc/event_bloc.dart';
import 'package:dev_scout_fds/Bloc/bloc.dart';
import 'package:dev_scout_fds/Data/repository/repository.dart';
import 'package:dev_scout_fds/Presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamsArgument {
  final int team1;
  final int team2;
  final int paramterId;

  TeamsArgument(this.team1, this.team2, this.paramterId);
}

class GamesList extends StatelessWidget {
  final int eventId;
  const GamesList(this.eventId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc()..add(GetAllGames(eventId)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 20,
          // leading: BackButton(),

          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: NotificationButton(),
          //   )
          // ],
          title: CustomTitle('Booo '),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
            child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          if (state is GamesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GamesLoaded) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: state.games.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                      context, "/field",
                                      arguments: TeamsArgument(
                                          state.games[index].team1,
                                          state.games[index].team2,
                                          eventId)),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5, top: 10, right: 5, bottom: 10),
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        top: 50,
                                        right: 30,
                                        bottom: 50),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.08),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              ' Team ${index + 1}',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('vs.'),
                                            ),
                                            Text(
                                                'Team ${state.games.length * 2 - index}',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        Text(state.games[index].time)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ));
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Failed to load details. Please try again.'),
            );
          }
        })),
      ),
    );
  }
}  
            
          
        
      
    
  


             
              
                  // alignment: Alignment.bottomCenter,
                 
                  // child: StickyFooterScrollView(
                        
                  //       ListView(
                  //         shrinkWrap: true,
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal:
                  //                 MediaQuery.of(context).size.width * 0.02),
                  //         physics: BouncingScrollPhysics(),
                  //         children: [
                  //           // Divider(),
                            
                  //         ],
                  //       ),
                      

                  //     footer:                     Positioned(
                  //     child: ButtonWidget(
                  //       text: 'Apply',
                  //       onClicked: () {
                  //         // UserPreferences.setUser(user);
                  //         Navigator.of(context).pop();
                  //       },
                  //     ),
                  //     bottom: 0,
                  //   ),
                  //   ),
                    

                  
                
              
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


