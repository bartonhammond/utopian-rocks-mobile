import 'package:flutter/material.dart';
import 'package:utopian_rocks/providers/information_provider.dart';
import 'package:utopian_rocks/blocs/information_bloc.dart';
import 'package:package_info/package_info.dart';

// import 'package:connectivity/connectivity.dart';

class InformationDrawer extends StatelessWidget {
  final AsyncSnapshot infoStreamSnapshot;

  InformationDrawer(this.infoStreamSnapshot);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          _buildInfoPanel(context),

          Center(
            child: Image.asset('assets/images/utopian-icon.png'),
          ),
          // _buildConnectionPanel(informationBloc),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, {String subtitle}) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle ?? '',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context) {
    if (!infoStreamSnapshot.hasData) {
      return Flexible(
        child: CircularProgressIndicator(),
      );
    }
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Information',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        _buildInfoTile(
          '${infoStreamSnapshot.data.appName}',
          subtitle:
              "Pre-release Version Number: ${infoStreamSnapshot.data.version}",
        ),
        _buildInfoTile(
          'Instructions: ',
          subtitle: 'Double tab on a contribution to open it in a Browser',
        ),
        _buildInfoTile(
          'Author & Application Info',
          subtitle:
              'Developed by @Tensor. Many thanks to @Amosbastian for creating the original website: utopian.rocks and to the folks over at utopian.io',
        )
      ],
    );
  }

  // Widget _buildConnectionPanel(informationBloc) {
  //   return StreamBuilder(
  //     stream: informationBloc.connectionInfo,
  //     builder: (context, AsyncSnapshot<ConnectivityResult> infoStreamSnapshot) {
  //       if (!infoStreamSnapshot.hasData) {
  //         return Container();
  //       }
  //       if (infoStreamSnapshot.data == ConnectivityResult.wifi) {
  //         return Container(
  //           child: _buildInfoTile('Connected through Wifi'),
  //         );
  //       } else if (infoStreamSnapshot.data == ConnectivityResult.mobile) {
  //         return Container(
  //           child: _buildInfoTile('Connected through Mobile'),
  //         );
  //       } else {
  //         return Container(
  //           child: _buildInfoTile('Not connected to the Internet'),
  //         );
  //       }
  //     },
  //   );
  // }
}