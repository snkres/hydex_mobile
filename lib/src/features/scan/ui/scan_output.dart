import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/src/features/scan/data/rsv_status.dart';
import 'package:intl/intl.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/profile_summary/components/ticket.dart';
import 'package:hydex/src/features/scan/data/scan_response.dart';
import 'package:hydex/src/features/scan/ui/components/scan_action_buttons.dart';

class ScanOutput extends ConsumerWidget {
  const ScanOutput({super.key, required this.data, this.isTicket = false});

  final ScanResponse data;
  final bool isTicket;

  bool get isCancelled => data.status.toLowerCase().contains("cancel");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                BackButton(),
                Text(
                  "TICKET #${data.id.substring(0, 7).toUpperCase()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                TicketContainer(
                  backgroundColor: isCancelled
                      ? Color.fromARGB(255, 141, 141, 156)
                      : AppColors.surfaceContainer,
                  upperChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              data.pass.bookingExperience?.event?.name ?? "",
                              style: TextStyle(
                                fontSize:
                                    AppTextStyles(context).accumulator * 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final imageUrl = data
                                  .pass
                                  .bookingExperience
                                  ?.event
                                  ?.media
                                  ?.firstOrNull;
                              return Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(8),
                                  border: imageUrl == null || imageUrl.isEmpty
                                      ? Border.all(
                                          color: Colors.grey,
                                          width: 1.5,
                                        )
                                      : null,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: imageUrl != null && imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(
                                                Icons.broken_image,
                                                size: 32,
                                              ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 32,
                                          ),
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          data
                                  .pass
                                  .bookingExperience
                                  ?.event
                                  ?.location
                                  .address ??
                              "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppTextStyles(context).accumulator * 11,
                            color: Color(0xff77767B),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      Text(
                        "Guest Name",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 11,
                          color: Color(0xff77767B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        data.fullName,
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${data.email} - ${data.gender}",
                        style: TextStyle(
                          fontSize: AppTextStyles(context).accumulator * 12,
                          color: Color(0xff77767B),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                              Text(
                                DateFormat('EEE').format(data.bookingDate),
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                DateFormat(
                                  'd MMM yyyy',
                                ).format(data.bookingDate),
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                              Text(
                                DateFormat('hh:mm a').format(data.bookingDate),
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Doors open 1h before",
                                style: TextStyle(
                                  fontSize:
                                      AppTextStyles(context).accumulator * 12,
                                  color: Color(0xff77767B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  lowerChild: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        spacing: 8,
                        children: [
                          Image.network(
                            data.qrCodeUrl ?? "",
                            width: 125,
                            height: 125,
                          ),
                          Text(
                            "Scan at entrance",
                            style: TextStyle(
                              fontSize: AppTextStyles(context).accumulator * 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ScanActionButtons(
                  bookingId: data.id,
                  isTicket: isTicket,
                  givenStatus: isTicket ? data.status : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
