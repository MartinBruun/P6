import 'package:flutter/material.dart';
import 'package:washee/core/washee_box/machine_model.dart';
import 'package:washee/features/unlock/presentation/widgets/start_wash.dart';

class UnlockSuccessfull extends StatefulWidget {
  final MachineModel machine;
  UnlockSuccessfull({required this.machine});

  @override
  State<UnlockSuccessfull> createState() => _UnlockSuccessfullState();
}

class _UnlockSuccessfullState extends State<UnlockSuccessfull> {
  @override
  Widget build(BuildContext context) {
    return StartWash(currentMachine: widget.machine);
  }
}
