import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../widgets/custom_dialog.dart';

class ListDemoScreen extends StatelessWidget {

  final List<String> _routes = [
    AppSampleRoutes.home,
    AppSampleRoutes.store,
    AppSampleRoutes.tabbar,
    AppSampleRoutes.first,
    AppSampleRoutes.chart,
    AppSampleRoutes.expansion,
    AppSampleRoutes.sliver
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Demo"),
      ),

      body: ListView.builder(
        itemCount: _routes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Route to"),
            subtitle: Text("${_routes[index]}"),
            onTap: () {
              Navigator.pushNamed(context, _routes[index]);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.radio),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CustomDialog(
              image: Image.network(
                "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                // 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1558354399545&di=c7fbb96d898f4d72a1f8a6cb04cb3071&imgtype=0&src=http%3A%2F%2Fs3.sinaimg.cn%2Fmw690%2F001LVQHHty6PTKLaphMd2%26690',
                fit: BoxFit.cover,
              ),
              title: Text(
                'Granny Eating Chocolate',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              detail: Text(
                'This is a granny eating chocolate dialog box. This library helps you easily create fancy giffy dialog.',
                textAlign: TextAlign.center,
              ),
              onPress: () {},
            )
          );
        },
      ),
    );
  }
}
