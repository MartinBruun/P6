import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/presentation/provider/unlock_provider.dart';
import 'package:washee/features/unlock/presentation/widgets/start_wash.dart';
import 'package:washee/features/unlock/presentation/widgets/wash_timer.dart';

class UnlockSuccessfull extends StatefulWidget {
  final MachineModel machine;
  UnlockSuccessfull({required this.machine});

  @override
  State<UnlockSuccessfull> createState() => _UnlockSuccessfullState();
}

class _UnlockSuccessfullState extends State<UnlockSuccessfull> {
  @override
  Widget build(BuildContext context) {
    var unlockProvier = Provider.of<UnlockProvider>(context, listen: true);
    return unlockProvier.hasInitiatedWash
        ? WashTimer(
            activeMachine: widget.machine,
          )
        : StartWash(machine: widget.machine);
  }
}
