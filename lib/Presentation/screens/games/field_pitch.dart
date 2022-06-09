import 'dart:convert';

import 'package:dev_scout_fds/Bloc/ParameterBloc/parameter_bloc.dart';
import 'package:dev_scout_fds/Bloc/TeamBloc/team_bloc.dart';
import 'package:dev_scout_fds/Bloc/bloc.dart';
import 'package:dev_scout_fds/Data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../widgets/CustomTitle.dart';
// import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

// On the pitch widgets #############################################
class Field extends StatelessWidget {
  const Field(
      {Key? key,
      required this.team1,
      required this.team2,
      required this.paramterId})
      : super(key: key);

  final int team1;
  final int team2;
  final int paramterId;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeamBloc()..add(GetTeams(team1, team2)),
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
            child: BlocBuilder<TeamBloc, TeamState>(builder: (context, state) {
              if (state is TeamLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TeamLoaded) {
                var t1_formation = state.team1.formation.split(" ");
                var t2_formation = state.team2.formation.split(" ");

                t1_formation.removeLast();
                t2_formation.removeLast();

                List<int> t1_to_int = [];
                List<int> t2_to_int = [];

                for (var num in t1_formation) {
                  t1_to_int.add(int.parse(num));
                }
                for (var num in t2_formation) {
                  t2_to_int.add(int.parse(num));
                }

                return Pitch(t1_to_int, t2_to_int, state.team1.players,
                    state.team2.players, paramterId);
              }
              if (state is TeamFailed) {
                return Center(
                  child: Text('Please try again.'),
                );
              } else {
                return Center(
                  child: Text('Failed to load details. Please try again.'),
                );
              }
            }),
          )),
    );
  }
}

class Pitch extends StatelessWidget {
  List<int> formation1;
  List<int> formation2;

  List team1;
  List team2;

  final Color team1_color = Colors.blue;
  final Color team2_color = Colors.red;

  int paramterId;

  Pitch(this.formation1, this.formation2, this.team1, this.team2,
      this.paramterId);

  @override
  Widget build(BuildContext context) {
    List<List<int>> squad1 = [];
    int current_player_index = 1;
    while (current_player_index < 7) {
      for (var num in formation1) {
        List<int> current_line = [];
        for (var i = 0; i < num; i++) {
          current_line.add(team1[current_player_index]);
          current_player_index++;
        }
        squad1.add(current_line);
      }
    }

    List<List<int>> squad2 = [];
    int current_player_index2 = 1;
    while (current_player_index2 < 7) {
      for (var num in formation2) {
        List<int> current_line = [];
        for (var i = 0; i < num; i++) {
          current_line.add(team2[current_player_index2]);
          current_player_index2++;
        }
        squad2.add(current_line);
      }
    }

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/field.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Align(
              child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Expanded(
                        child:
                            PlayerIcon(team1_color, 1, team1[0], paramterId)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      formation1[0],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team1_color,
                              team1.indexOf(squad1[0][index]) + 1,
                              squad1[0][index],
                              paramterId))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      formation1[1],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team1_color,
                              team1.indexOf(squad1[1][index]) + 1,
                              squad1[1][index],
                              paramterId))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      formation1[2],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team1_color,
                              team1.indexOf(squad1[2][index]) + 1,
                              squad1[2][index],
                              paramterId))),
                ),
              ],
            ),
            alignment: AlignmentDirectional.bottomCenter,
          )),
          Align(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: List.generate(
                      formation2[2],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team2_color,
                              team2.indexOf(squad2[2][index]) + 1,
                              squad2[2][index],
                              paramterId))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      formation2[1],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team2_color,
                              team2.indexOf(squad2[1][index]) + 1,
                              squad2[1][index],
                              paramterId))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      formation2[0],
                      (index) => Expanded(
                          child: PlayerIcon(
                              team2_color,
                              team2.indexOf(squad2[0][index]) + 1,
                              squad2[0][index],
                              paramterId))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  // GK
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child:
                            PlayerIcon(team2_color, 1, team2[0], paramterId)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
              ],
            ),
            alignment: AlignmentDirectional.bottomCenter,
          )),
        ]));
  }
}

class PlayerIcon extends StatelessWidget {
  final Color color1;
  int field_no;
  int player_id;
  int paramterId;
  PlayerIcon(this.color1, this.field_no, this.player_id, this.paramterId);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: color1,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.85,
                  child: RatePlayerFormWindow(player_id, paramterId),
                );
              },
            );
          },
          child: Text(
            field_no.toString(),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}

class RatePlayerFormWindow extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  int player_id;
  int paramterId;
  RatePlayerFormWindow(this.player_id, this.paramterId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParameterBloc()..add(GetAllParameters(paramterId)),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: [Profile(player_id)],
          ),
          FormBuilder(
            key: _formKey,
            child: BlocBuilder<ParameterBloc, ParameterState>(
              builder: (context, state) {
                if (state is ParametersLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ParametersLoaded) {
                  return BlocProvider(
                    create: (context) => GradeBloc()
                      ..add(GetGrade(
                          player_id, 145, state.parameter['event']['id'])),
                    child: BlocBuilder<GradeBloc, GradeState>(
                      builder: (context, gradestate) {
                        if (gradestate is GradeLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (gradestate is GradeLoaded) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(children: <Widget>[
                              Column(
                                  children: List.generate(
                                state.parameter['skills'].length,
                                (index) => FormBuilderSlider(
                                  name: state.parameter['skills'][index]['id']
                                      .toString(),
                                  min: 0.0,
                                  max: 10.0,
                                  initialValue: gradestate
                                      .grade.score["${index + 1}"]
                                      .toDouble(),
                                  divisions: 20,
                                  activeColor: Color.fromARGB(255, 0, 0, 0),
                                  inactiveColor: Color.fromARGB(70, 94, 94, 94),
                                  decoration: InputDecoration(
                                    labelText: state.parameter['skills'][index]
                                            ['name']
                                        .toString(),
                                  ),
                                ),
                              )),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: BlocProvider(
                                      create: (context) =>
                                          GradeBloc()..add(GradeFormPrepare()),
                                      child: MaterialButton(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        child: Text(
                                          "Save",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          _formKey.currentState?.save();
                                          if (_formKey.currentState != null) {
                                            Grade grade = Grade(
                                                id: gradestate.grade.id,
                                                eventId: state
                                                    .parameter['event']['id'],
                                                player: player_id,
                                                scoutId:
                                                    gradestate.grade.scoutId,
                                                score: _formKey
                                                    .currentState?.value);
                                            GradeBloc()
                                              ..add(GradePlayer(
                                                  grade, gradestate.grade.id));
                                            print(_formKey.currentState?.value);
                                            print(player_id);

                                            Navigator.pop(context);
                                          } else {
                                            print("validation failed");
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          );
                        } else {
                          return Center(
                            child: Text(
                                'Failed to load details. Please try again.'),
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('Failed to load details. Please try again.'),
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final int userId;
  Profile(this.userId);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(GetPlayer(userId)),
      child: Expanded(child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return CircularProgressIndicator();
          } else if (state is AccountLoaded) {
            return Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/pic.jpg')),
                  ),
                ),
                Text('${state.user['first_name']} ${state.user['first_name']}'),
              ],
            );
          } else {
            return Text('Failed to load details. Please try again.');
          }
        },
      )),
    );
  }
}
