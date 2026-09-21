import 'package:flutter/material.dart';

class IdleStateWidget extends StatelessWidget {
  final VoidCallback checkPermission;

  const IdleStateWidget({
    super.key,
    required this.checkPermission,
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Idle state"),
          SizedBox(height: 24,),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register_transaction_page'),
              child: Text("BACK"),
          ),
          SizedBox(height: 24,),
          FloatingActionButton(
              onPressed: checkPermission,
          )
        ],
      ),
    );
  }
}
