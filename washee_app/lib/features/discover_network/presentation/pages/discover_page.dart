import 'package:flutter/material.dart';
import 'package:washee/features/discover_network/domain/usecases/discover.dart';

import '../../../../core/presentation/themes/colors.dart';
import '../../../../core/presentation/themes/dimens.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../injection_container.dart';

class DiscoveryPage extends StatefulWidget {
  DiscoveryPage({Key? key}) : super(key: key);

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainDarkLight,
        leading: Container(),
        title: Text(
          'Networks',
          style: textStyle.copyWith(
            fontSize: textSize_60,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      // body: _buildBody(context),
    );
  }
}

// _buildBody(
//   BuildContext context,
// ) {
//   return FutureBuilder(
//     future: sl<DiscoverUseCase>().call(NoParams()),
//     builder: (context, snapshot) {
//       switch (snapshot.connectionState) {
//         case ConnectionState.none:
//           return const Text("No connection");
//         case ConnectionState.waiting:
//           return ScanningForBaseStationsView();
//         case ConnectionState.done:
//           if (snapshot.hasData) {
//             var result = snapshot.data as List<BluetoothDiscoveryResult>;
//             if (result.isNotEmpty) {
//               return ListOfBaseStationsView(results: result);
//             }
//             return NoBaseStationsFoundDialog();
//           }
//           return NoBaseStationsFoundDialog();

//         case ConnectionState.active:
//           return const Text('Active');
//         default:
//           return BaseStationErrorView(message: "Something went wrong");
//       }
//     },
//   );
// }
