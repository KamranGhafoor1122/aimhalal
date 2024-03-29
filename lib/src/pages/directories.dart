import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/directory_controller.dart';
import '../controllers/events_controller.dart';
import '../controllers/favorite_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/EventGridItemWidget.dart';
import '../elements/FavoriteGridItemWidget.dart';
import '../elements/FavoriteListItemWidget.dart';
import '../elements/PermissionDeniedWidget.dart';
import '../elements/SearchBarWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/user_repository.dart';

class DirectoryWidget extends StatefulWidget {
  String name;


  DirectoryWidget(this.name);

  @override
  _DirectoryWidgetState createState() => _DirectoryWidgetState();
}

class _DirectoryWidgetState extends StateMVC<DirectoryWidget> {
  String layout = 'grid';

  DirectoryController _con;

  _DirectoryWidgetState() : super(DirectoryController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: true,

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.name,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
        //  new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
              onRefresh: () async{
                _con.refreshDirectories();
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onSubmitted: (text) async {
                        },
                        autofocus: false,
                        onChanged: (query){
                          _con.searchDirectory(query);
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                          hintText: "Search",
                          hintStyle: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 14)),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.3))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.1))),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    _con.directories.isEmpty
                        ? CircularLoadingWidget(height: 500)
                        :
                    /*DataTable(
                      columnSpacing: 15,
                          horizontalMargin: 10,
                          columns: [
                            *//*DataColumn(label: Container(
                              width: width * .1,
                              child: Text(
                                "Id",
                                style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            )),*//*
                            DataColumn(label: Container(
                                width: width * .7,
                                child:  Text(
                              "Name",
                              style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700
                              ),
                            ))),
                            DataColumn(label:
                            Container(
                                width: width * .3,
                                child: Text(
                              "Type",
                              style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700
                              ),
                            ))),
                          ],
                          border: TableBorder.all(
                            color: Theme.of(context).hintColor
                          ),

                          rows:
                          _con.directories // Loops through dataColumnText, each iteration assigning the value to element
                              .map(
                            ((element) => DataRow(
                              cells: <DataCell>[
                                // DataCell( Text(
                                //   element.id?.toString()??"",
                                //   style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                //       fontWeight: FontWeight.w700
                                //   ),
                                // ),), //Extracting from Map element the value
                                DataCell(Text(
                                  element.name??"",
                                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w700
                                  ),
                                )),
                                DataCell(Text(
                                  element.type??"",
                                  style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w700
                                  ),
                                )),
                              ],
                            )),
                          )
                              .toList(),
                        )*/


                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              separatorBuilder: (ctx,index)=>SizedBox(
                                height: 10,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7
                              ),
                              itemCount: _con.directories.length,
                              itemBuilder: (ctx,index)=>
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color: Theme.of(context).focusColor.withOpacity(0.1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _con.directories[index].name??"",
                                          style: Theme.of(context).textTheme.bodyMedium.copyWith(
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          _con.directories[index].type??"",
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  )
                          )
                  ],
                ),
              ),
            ),
    );
  }
}
