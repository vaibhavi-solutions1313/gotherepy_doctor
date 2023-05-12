import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotherepy_doctor/app/appWidgets/text_styles.dart';

import '../app_constants/constants_appColors.dart';

class CustomTextFieldWithTitle extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController textEditingController;
  const CustomTextFieldWithTitle({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.inputType = TextInputType.text,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomTextFieldWithTitle> createState() => _CustomTextFieldWithTitleState();
}

class _CustomTextFieldWithTitleState extends State<CustomTextFieldWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Text16by400(
          text: widget.title,
          fontSize: 14,
          color: AppColors.lightGreyTextColor,
        ),
        TextFormField(
          controller: widget.textEditingController,
          keyboardType: widget.inputType,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Please Enter a valid input';
            }
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.blackishTextColor,
          ),
          cursorColor: AppColors.blackishTextColor,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.blackishTextColor,
                    width: 3,
                  ))),

        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

class CustomPasswordTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType inputType;
  final bool isObscureText;
  final TextEditingController textEditingController;
  const CustomPasswordTextField({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    this.inputType = TextInputType.text,
    required this.title, this.isObscureText=false,
  }) : super(key: key);

  @override
  State<CustomPasswordTextField> createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    var showPassword=widget.isObscureText.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Text16by400(
          text: widget.title,
          fontSize: 14,
          color: AppColors.lightGreyTextColor,
        ),
        Obx(() => TextFormField(
          controller: widget.textEditingController,
          keyboardType: widget.inputType,
          obscureText: showPassword.value,
          validator: (val) {
            if(val!.isEmpty) {
             return 'Please Enter a valid input';
            }
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.blackishTextColor,
          ),
          cursorColor: AppColors.blackishTextColor,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColors.blackishTextColor,
                    width: 3,
                  )),
              suffix: InkWell(
                  onTap: (){showPassword.value=!showPassword.value;},
                  child: Text16by400(text:showPassword.value?'Show': "Hide",fontSize: 16,color: AppColors.tealColor,))
          ),

        )),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class CustomTextFieldWithHintTextAndBorder extends StatelessWidget {
  final String title;
  final String labelText;
  final bool readOnly;
  final TextInputType inputType;
  final TextEditingController textEditingController;
  const
  CustomTextFieldWithHintTextAndBorder({Key? key,
    required this.textEditingController,
    this.inputType = TextInputType.text,
    required this.title, required this.labelText, this.readOnly=false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        readOnly: readOnly,
        autofocus: false,
        controller: textEditingController,
        keyboardType: inputType,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Please Enter a valid input';
          }
        },
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.blackishTextColor,
        ),
        cursorColor: AppColors.blackishTextColor,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color:AppColors.lightGreyTextColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColors.lightGreyTextColor.withOpacity(0.5),
                  width: 1.5,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColors.lightGreyTextColor.withOpacity(0.5),
                  width: 1.5,
                ))

        ),

      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////////

class CustomCircularBorderTextFieldWithHintTextAndTitle extends StatefulWidget {
  final String title;
  final bool readOnly;
  final bool isTextFieldRequired;
  final TextInputType inputType;
  final TextEditingController textEditingController;
  final String hintText;
  const CustomCircularBorderTextFieldWithHintTextAndTitle({
    Key? key,
    required this.title,
    required this.hintText,
    required this.textEditingController,
    this.inputType = TextInputType.text, this.readOnly=false, this.isTextFieldRequired=false,

  }) : super(key: key);

  @override
  State<CustomCircularBorderTextFieldWithHintTextAndTitle> createState() => _CustomCircularBorderTextFieldWithHintTextAndTitle();
}

class _CustomCircularBorderTextFieldWithHintTextAndTitle extends State<CustomCircularBorderTextFieldWithHintTextAndTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text14by400(
                text: widget.title,
                color: AppColors.blackish2D2D2D,
              ),
              if(widget.isTextFieldRequired)...[
                Align(
                  alignment: Alignment.topCenter,
                    child: Icon(Icons.star,size: 10,color: Colors.red,))
              ]
            ],
          ),
          SizedBox(height: 6.0,),
          Material(
            elevation: 2.0,
            color: Colors.white,
            shadowColor: AppColors.whiteShadow,
            borderRadius: BorderRadius.circular(10.0),
            child: TextFormField(

              readOnly: widget.readOnly,
              autofocus: false,
              controller: widget.textEditingController,
              keyboardType: widget.inputType,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'This field is required';
                }
              },
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.blackishTextColor,
              ),
              cursorColor: AppColors.blackishTextColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  hintText: widget.hintText,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                     )

              ),

            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////
class CustomTextFieldWithoutBorderAndHeading extends StatelessWidget {
  final String hintText;
  final int maxLine;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  const CustomTextFieldWithoutBorderAndHeading({Key? key, required this.hintText, required this.textEditingController,this.inputType = TextInputType.text, required this.maxLine,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autofocus: false,
        controller: textEditingController,
        keyboardType: inputType,
        validator: (val) {
          if (val!.isEmpty) {
            return 'Please Enter a valid input';
          }
        },
        maxLines: maxLine,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.blackishTextColor,
        ),
        cursorColor: AppColors.blackishTextColor,
        decoration: InputDecoration(

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none
          ),
          filled: true,
          fillColor: AppColors.containerColor,
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color:AppColors.lightGreyTextColor),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //     borderSide: BorderSide(
          //       color: AppColors.lightGreyTextColor.withOpacity(0.5),
          //       width: 1.5,
          //     )),
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //     borderSide: BorderSide(
          //       color: AppColors.lightGreyTextColor.withOpacity(0.5),
          //       width: 1.5,
          //     ))

        ),

      ),
    );
  }
}