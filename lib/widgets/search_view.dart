import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/screens/favourite/favorite_controller.dart';
import 'package:go_on_get_it/screens/shopDetail/shop_detail_controller.dart';
import 'package:go_on_get_it/utils/space.dart';
import 'package:sizer/sizer.dart';

class SearchView extends StatefulWidget {
  final bool isFavoriteScreen;
  final Function(String)? onChange;
  final Function? clearBtListener;

  const SearchView({Key? key, this.onChange, this.clearBtListener, this.isFavoriteScreen = false})
      : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool _hasFocus = false;
  final textController = TextEditingController();
  final SubSubCategoryController shopDetailController = Get.put(SubSubCategoryController());

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    final FavoriteController _favoriteController = Get.put(FavoriteController());

    return Row(
      children: [
        Expanded(
          child: Container(
              height: Spaces.normY(6.5),
              margin: EdgeInsets.symmetric(horizontal: Spaces.normX(2)),
              padding: EdgeInsets.symmetric(vertical: Spaces.normY(1)),
              decoration: BoxDecoration(
                color: ColorConstants.popupBorderColor,
                //color: _hasFocus ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(Spaces.normX(1)),
                border: Border.all(
                  color: ColorConstants.grayVeryLight,
                  width: 1.0,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spaces.x2,
                  Expanded(
                    child: Focus(
                      onFocusChange: (value){
                        if(mounted) {
                          setState(() {_hasFocus = true;},
                      );
                     }} ,
                      child: TextField(
                        onChanged: widget.onChange,
                        maxLength: 30,
                        controller: textController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: '',
                          focusColor: Colors.black54,
                          hintText: 'searchItem'.tr,
                          hintStyle: TextStyle(
                            fontSize:  _isMobileLayout ? 12.sp : 9.sp
                          ),
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: Spaces.normX(4),
                          ),
                          border: InputBorder.none,
                        ),
                        // onSubmitted: (value) {
                        //   _hasFocus = false;
                        //   print('VALUE: $_hasFocus');
                        // },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Spaces.normX(1)),
                    child: GestureDetector(
                      child: _hasFocus
                          ? SvgPicture.asset(
                              'assets/svgs/cancel.svg',
                              height: Spaces.normY(3),
                            )
                          : SvgPicture.asset(
                              'assets/svgs/search.svg',
                              height: Spaces.normY(2),
                            ),
                      onTap: () {
                        // FocusScopeNode currentScope = FocusScope.of(context);
                        // if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                        //   FocusManager.instance.primaryFocus?.unfocus();
                        // }
                        textController.clear();
                        // widget.clearBtListener;
                        // shopDetailController.getShops(filter: 'item');
                        if(widget.isFavoriteScreen){
                          _favoriteController.favoriteSearchedList.clear();
                        }
                        else {
                          shopDetailController.shopList.clear();
                          shopDetailController.shopFilterList.clear();
                          shopDetailController.isSearching.value = false;
                          shopDetailController.isNoItems.value = true;
                        }
                      },
                    ),
                  ),
                  Spaces.x2,
                ],
              )),
        ),
      ],
    );
  }
}
