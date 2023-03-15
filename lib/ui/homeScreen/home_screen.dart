import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeb/ui/detailScreen/detail_screen.dart';
import 'package:makeb/ui/homeScreen/bloc/home_screen_bloc.dart';
import 'package:makeb/ui/homeScreen/bloc/home_screen_event.dart';
import 'package:makeb/ui/homeScreen/bloc/home_screen_state.dart';
import 'package:makeb/utility/color.dart';
import 'package:makeb/widget/text_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc homeScreenBloc = HomeScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     homeScreenBloc.add(GetHomeScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return  BlocProvider<HomeScreenBloc>(
        create: (context) => homeScreenBloc,
    child:SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: colorPrimary,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          leading: const Text(""),
          title: const Text('Home Screen'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: colorPrimary,
        ),
        body: Container(
          child:
        BlocBuilder<HomeScreenBloc, HomeScreenState>
        (builder: (context, state) {
          log("====>$state");
          if(state is GetHomeScreenState){

          return ListView.builder(
              itemCount:  state.homeScreenModel.jscncodes!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                      tileColor: Colors.blue.withOpacity(0.5),
                  
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                 ),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>
                          DetailScreen(id:state.homeScreenModel.jscncodes![index].id.toString())));
                    },
                    leading:  ClipRRect(
                        borderRadius: BorderRadius.circular(35.0),
                        child: Image.network(state.homeScreenModel.jscncodes![index].flickrImages!.first,width: 60,height: 100,fit: BoxFit.cover,)),
                    title: titleText(data: state.homeScreenModel.jscncodes![index].name.toString()),
                    subtitle: descriptionText(data:  state.homeScreenModel.jscncodes![index].country.toString()),
                    trailing: titleText(data: state.homeScreenModel.jscncodes![index].engines!.number!.toString()),
                  ),
                );
              });
        }
          if(state is LoadingState){
          return Container(

            child: const Center(child: CircularProgressIndicator()),
          );}
          if(state is FailureState) {
            Future.delayed(const Duration(seconds: 2)).then((value) {
              showAlert(context);
            });
          }
          return Container();
        },

        ),
      ),
    )));
  }
  showAlert(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,  builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Error"),
            content: const Text("Might Be An Error Please Retry"),
            actions: [
              ElevatedButton(onPressed: (){
                homeScreenBloc.add(GetHomeScreenEvent());
                Navigator.of(context).pop();
              }, child: const Text("OK"))
            ],
          );
        }
    );



  }
}
