import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color:color?? Colors.blueAccent,
        size: 20.0,
      ),
    );
  }
}

class LoadingGif extends StatelessWidget {

  const LoadingGif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("assets/loading_gif.gif"),
    );
  }
}




Widget spinKit({Color? color}) => SpinKitThreeBounce(
  color: color ?? Colors.white,
  size: 20.0,
);

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingWidget(),
    );
  }
}

