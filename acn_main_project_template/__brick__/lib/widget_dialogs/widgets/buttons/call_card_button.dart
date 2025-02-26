import 'package:{{project_file_name}}/core/extensions/int_extension.dart';
import 'package:{{project_file_name}}/core/managers/url_launcher_manager.dart';
import 'package:flutter/material.dart';

class CallCardButton extends StatelessWidget {
  final String content;
  final String number;
  final IconData? iconData;
  final double size;
  const CallCardButton({Key? key,this.iconData,required this.content,required this.number,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:(){
      UrlLauncher.call(telNo: number);
    } ,child:
    Container(
      decoration:
      BoxDecoration(color: const Color.fromRGBO(93, 92, 92, 1), borderRadius: BorderRadius.circular(6), ),
      padding: EdgeInsets.symmetric(vertical: size * .03, horizontal: size * .03),
      child: Row(
        children: [
           Icon(
            Icons.phone,
            color: Colors.white,
            size: size * .06,
          ),
         if(iconData!=null)...[
           4.widthIntMargin,
             Icon(
               iconData,
                color: Colors.white,
                size: size * .052,
              ),
           ],
          8.widthIntMargin,
           Text(
            content,
            style:  TextStyle(fontSize: size * .04,color: Colors.white),
          ),
          const Spacer(),
          Text(number, style: TextStyle(fontSize: size * .04,color: Colors.white))
        ],
      ),
    )
      ,);
  }
}
class MailCardButton extends StatelessWidget {
  final String content;
  final String mail;
  final IconData? iconData;
  final double size;
  const MailCardButton({Key? key,this.iconData,required this.content,required this.mail,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap:(){
      UrlLauncher.sendMail(eMail: mail);
    } ,child:
    Container(
      decoration:
      BoxDecoration(color: const Color.fromRGBO(93, 92, 92, 1), borderRadius: BorderRadius.circular(6),),
      padding: EdgeInsets.symmetric(vertical: size * .03, horizontal: size * .03),
      child: Row(
        children: [
          Icon(
            Icons.mail,
            color: Colors.white,
            size: size * .06,
          ),
          if(iconData!=null)...[
            4.widthIntMargin,
            Icon(
              iconData,
              color: Colors.white,
              size: size * .052,
            ),
          ],
          8.widthIntMargin,
          Text(
            content,
            style:  TextStyle(fontSize: size * .04,color: Colors.white),
          ),
          Expanded(child: Text(mail,textAlign: TextAlign.right, maxLines: 1,style: TextStyle(fontSize: size * .04,color: Colors.white)))
        ],
      ),
    )
      ,);
  }
}

/**/