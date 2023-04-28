import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instgrameclone/Feature/search/presentation/controller/search_cubit.dart';
import 'package:instgrameclone/core/uttils/strings.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
      child: SizedBox(
        height: 36.h,
        child: TextFormField(
          controller: SearchCubit.get(context).searchController,
          onChanged: (val){
            SearchCubit.get(context).getAnotherUser();
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              hintText: AppStrings.search,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            )
        ),
      ),
    );
  }
}
