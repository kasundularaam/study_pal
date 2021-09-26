import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/data/models/pie_data_model.dart';

List<PieChartSectionData> getSections(
        {required List<PieDataModel> pieDataList}) =>
    pieDataList
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: '${data.percent.toStringAsFixed(1)}%',
            radius: 20.w,
            titleStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();
