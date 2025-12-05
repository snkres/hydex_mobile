import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/data/format_time.dart';
import 'package:hydex/src/features/booking/ui/components/access_container.dart';
import 'package:hydex/src/features/booking/ui/components/bottom_bar.dart';
import 'package:hydex/src/features/booking/ui/components/date_container.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/booking/ui/components/slots_container.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:hydex/src/widgets/backbtn.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class CreateBooking extends ConsumerStatefulWidget {
  const CreateBooking({super.key, required this.book});

  final CreateBook book;

  @override
  ConsumerState<CreateBooking> createState() => _CreateBookingState();
}

class _CreateBookingState extends ConsumerState<CreateBooking> {
  DateTime? selectedDate;
  DateTime? selectedSlot;
  List<DateTime> vendorAvailable = [];
  bool get isEvent => widget.book.startTime != null;

  @override
  void initState() {
    vendorAvailable = widget.book.operatingHours
        .map((e) => e.toOpenDateTime())
        .toList();
    selectedDate = isEvent ? widget.book.startTime : vendorAvailable.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPass = ref.watch(
      createBookProvider.select((v) => v?.selectedPasses),
    );
    return Scaffold(
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton:
          (selectedPass != null && selectedDate != null && selectedSlot != null)
          ? BottomBar(selectedDate: selectedDate, selectedSlot: selectedSlot)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                onTap: null,
                title: "RSVP",
                frColor: Colors.black,
                bgColor: AppColors.buttonPrimaryDisabled,
              ),
            ),
      body: SoftEdgeBlur(
        edges:
            (selectedPass != null &&
                selectedDate != null &&
                selectedSlot != null)
            ? [
                EdgeBlur(
                  type: EdgeType.bottomEdge,
                  size: 125,
                  sigma: 30,
                  tintColor: AppColors.signalBrandTint,
                  controlPoints: [
                    ControlPoint(position: 0.5, type: ControlPointType.visible),
                    ControlPoint(
                      position: 1,
                      type: ControlPointType.transparent,
                    ),
                  ],
                ),
              ]
            : [],
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 195,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.signalBrandSolid,
                        AppColors.signalBrandSolid.withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomBackButton(),
                        Column(
                          crossAxisAlignment: .start,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                widget.book.name,
                                maxLines: 1,
                                overflow: .ellipsis,
                                style: TextStyle(
                                  fontWeight: .w600,
                                  fontSize:
                                      AppTextStyles(context).accumulator * 16,
                                ),
                              ),
                            ),
                            widget.book.startTime != null
                                ? Text(
                                    widget.book.startTime?.toPrettyString() ??
                                        "",
                                    style: AppTextStyles(context).primaryRegular
                                        .copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(),
                        SizedBox(width: 16),
                      ],
                    ),
                    SizedBox(height: 6),
                    GuestsContainer(),
                    // SizedBox(height: 24),
                    // PerkContainer(),
                    SizedBox(height: 24),
                    DateContainer(
                      availableDates: [
                        ?widget.book.startTime,
                        ...vendorAvailable,
                      ],
                      selectedDate: selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                    SizedBox(height: 24),
                    SlotsContainer(
                      selectedDate: selectedDate,
                      operatingHours: widget.book.operatingHours
                          .map((e) => e.toOpenDateTime())
                          .toList(),
                      startTime: widget.book.startTime,
                      selectedSlot: selectedSlot,
                      onSelectSlot: (slot) {
                        if (selectedSlot == slot) {
                          setState(() {
                            selectedSlot = null;
                          });
                        } else {
                          setState(() {
                            selectedSlot = slot;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    AccessSection(passes: widget.book.passes),
                    // SizedBox(height: 24),
                    // ExclusivePerks(),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
