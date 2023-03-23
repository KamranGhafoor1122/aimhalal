import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/controllers/profile_controller.dart';
import 'package:markets/src/repository/user_repository.dart';

import '../../generated/l10n.dart';
import '../models/user.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final User user;
  ProfileController con;
  ProfileAvatarWidget({
    Key key,
    this.user,
    this.con
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
//              SizedBox(
//                width: 50,
//                height: 50,
//                child: MaterialButton(elevation:0,
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
//                  color: Theme.of(context).accentColor,
//                  shape: StadiumBorder(),
//                ),
//              ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  child: CachedNetworkImage(
                    height: 135,
                    width: 135,
                    fit: BoxFit.cover,
                    imageUrl: user.image?.url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 135,
                      width: 135,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),
//              SizedBox(
//                width: 50,
//                height: 50,
//                child: MaterialButton(elevation:0,
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
//                  color: Theme.of(context).accentColor,
//                  shape: StadiumBorder(),
//                ),
//              ),
              ],
            ),
          ),
          Text(
            user.name ?? "",
            style: Theme.of(context).textTheme.headline5.merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
          Text(
            user.address ?? "",
            style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               TextButton(onPressed: (){

               }, child: Text(
                 S.of(context).about,
                 style: Theme.of(context).textTheme.headline4,
               ),),


              TextButton(onPressed: (){
                showDialog(context: context, builder: (ctx){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Delete Account",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor,
                          ),),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Are you sure you want to delete your account? After deleting your account , all of your data and activities "
                              "inside the app will be deleted and you will not be able to use this account anymore.",style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            children: [
                              Expanded(child: TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).accentColor
                                ),),
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: Theme.of(context).accentColor,
                                        )
                                    )
                                ),
                              )),

                              SizedBox(
                                width: 15,
                              ),

                              Expanded(child: ElevatedButton(
                                onPressed: () async{
                                  Navigator.pop(context);
                                  var response =  await con.deleteAccount(user.id);
                                  if(response.statusCode == 200){
                                    await logout();
                                    Navigator.of(context).pushNamedAndRemoveUntil('/Pages', (Route<dynamic> route) => false, arguments: 0);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).accentColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text("Delete",style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),),
                              )),
                            ],
                          )

                        ],
                      ),
                    ),
                  );
                });
              }, child: Text(
                "Delete Account",
                style: Theme.of(context).textTheme.headline4,
              ),),
            ],
          )
        ],
      ),
    );
  }
}
