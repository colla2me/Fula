import 'package:flutter/material.dart';
import 'home_list.dart';
import '../../json_models/home.dart';
import '../../services/api_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  final apiClient = ApiClient();

  HomeModel _model;

  @override
  void initState() {
    super.initState();
    apiClient.fetchHomeModel().then((model) => this.setState(() { this._model = model; }));
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        key: Key('loading')
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _model == null ? _buildLoading() : HomeList(homeModel: _model),
    );
  }
}
