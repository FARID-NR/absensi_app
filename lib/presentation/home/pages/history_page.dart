import 'package:absensi_app/core/core.dart';
import 'package:absensi_app/presentation/home/bloc/get_attendance_by_date/get_attendances_bloc.dart';
import 'package:absensi_app/presentation/home/widgets/history_attendace.dart';
import 'package:absensi_app/presentation/home/widgets/history_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    // current date format yyyy-mm-dd
    final bloc = context.read<GetAttendancesBloc>();
    // Pastikan bloc tidak null
    if (bloc != null) {
      // current date format yyyy-mm-dd
      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      // get attendance
      bloc.add(GetAttendancesEvent.getAttendances(currentDate));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 15),
            lastDate: DateTime.now().add(const Duration(days: 7)),
            onDateSelected: (date) {
              final selectedDate = DateFormat('yyyy-MM-dd').format(date);

              context.read<GetAttendancesBloc>().add(
                    GetAttendancesEvent.getAttendances(selectedDate),
                  );
            },
            leftMargin: 20,
            monthColor: AppColors.grey,
            dayColor: AppColors.black,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: AppColors.primary,
            showYears: true,
          ),
          const SpaceHeight(45.0),
          BlocBuilder<GetAttendancesBloc, GetAttendancesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const SizedBox.shrink();
                },
                error: (message) {
                  return Center(
                    child: Text(message),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                empty: () {
                  return const Center(
                      child: Text('No attendance data available.'));
                },
                loaded: (attendance) {
                  // Ambil data pertama dari list (atau ubah logika sesuai kebutuhan Anda)
                  // final attendance = attendanceList.first;

                  // Pisahkan latlongIn menjadi latitude dan longitude
                  // Pisahkan latlongIn menjadi latitude dan longitude
                  final latlongInParts = attendance.latlonIn?.split(',') ?? [];
                  final latitudeIn = latlongInParts.isNotEmpty ? double.parse(latlongInParts.first) : 0.0;
                  final longitudeIn = latlongInParts.length > 1 ? double.parse(latlongInParts.last) : 0.0;

                  final latlongOutParts = attendance.latlonOut?.split(',') ?? [];
                  final latitudeOut = latlongOutParts.isNotEmpty ? double.parse(latlongOutParts.first) : 0.0;
                  final longitudeOut = latlongOutParts.length > 1 ? double.parse(latlongOutParts.last) : 0.0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HistoryAttendance(
                        statusAbsen: 'Datang',
                        time: attendance.timeIn ?? '',
                        date: attendance.date.toString(),
                      ),
                      const SpaceHeight(10.0),
                      HistoryLocation(
                        latitude: latitudeIn,
                        longitude: longitudeIn,
                      ),
                      const SpaceHeight(25),
                      HistoryAttendance(
                        statusAbsen: 'Pulang',
                        isAttendanceIn: false,
                        time: attendance.timeOut ?? 'Belum Absen',
                        date: attendance.date.toString(),
                      ),
                      const SpaceHeight(10.0),
                      HistoryLocation(
                        isAttendance: false,
                        latitude: latitudeOut,
                        longitude: longitudeOut,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}