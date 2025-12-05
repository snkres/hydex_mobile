import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hydex/core/ui/colors.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/booking/data/create_book.dart';
import 'package:hydex/src/features/booking/ui/components/guests_container.dart';
import 'package:hydex/src/features/vibes/data/event.dart';
import 'package:smooth_corner/smooth_corner.dart';

final vipCountProvider = StateProvider<int>((ref) => ref.watch(guestsProvider));

final ticketCountProvider = StateProvider<int>((ref) => 0);

class AccessSection extends ConsumerWidget {
  const AccessSection({super.key, required this.passes});

  final List<Passes> passes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPass = ref.watch(
      createBookProvider.select((v) => v?.selectedPasses),
    );

    final guestCount = ref.watch(guestsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Choose Your Access",
            style: AppTextStyles(
              context,
            ).secondaryBold.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 12),

        ListView.separated(
          itemCount: passes.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final pass = passes[index];
            final isSelected = selectedPass == pass;

            return AccessContainer(
              title: pass.name,
              price: pass.price.toString(),
              description: "Enjoy full access to the event.",
              features: const ["Event access", "Welcome drink"],
              isSelected: isSelected,
              count: isSelected ? guestCount : 0,

              onSelect: () {
                ref.read(createBookProvider.notifier).selectPasses(pass);
                if (ref.read(guestsProvider) == 0) {
                  ref.read(guestsProvider.notifier).state = 1;
                }
              },

              onIncrement: () {
                ref.read(guestsProvider.notifier).update((state) => state + 1);
              },

              onDecrement: () {
                if (guestCount > 1) {
                  ref
                      .read(guestsProvider.notifier)
                      .update((state) => state - 1);
                } else {
                  ref.read(createBookProvider.notifier).clearSelectedPass();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: onPressed,
        child: Text(
          "Add",
          style: TextStyle(
            color: AppColors.textInverse,
            fontSize: AppTextStyles(context).accumulator * 13,
          ),
        ),
      ),
    );
  }
}

class AccessContainer extends StatelessWidget {
  final String title;
  final String price;
  final String? description;
  final List<String> features;
  final bool isSelected;
  final int count;
  final VoidCallback onSelect;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const AccessContainer({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.count,
    required this.onSelect,
    required this.onIncrement,
    required this.onDecrement,
    this.description,
    this.features = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.signalBrandTint : const Color(0xff1E1E20),
        shape: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          smoothness: 1,
          side: BorderSide(
            color: isSelected
                ? AppColors.signalBrandSolid
                : AppColors.borderDefault,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles(context).secondaryBold),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "$price ",
                          style: AppTextStyles(context).smallBold,
                        ),
                        TextSpan(
                          text: "EGP",
                          style: AppTextStyles(context).captionMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: !isSelected
                    ? AddButton(onPressed: onSelect)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: onDecrement,
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),
                            icon: Transform.translate(
                              offset: const Offset(0, -6),
                              child: const Icon(
                                Icons.minimize,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: AppTextStyles(
                              context,
                            ).smallMedium.copyWith(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: onIncrement,
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),
                            icon: const Icon(Icons.add, color: Colors.black),
                          ),
                        ],
                      ),
              ),
            ],
          ),
          if (description != null || features.isNotEmpty) ...[
            const SizedBox(height: 8),
            if (description != null)
              Text(
                description!,
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
            const SizedBox(height: 20),
            if (features.isNotEmpty) ...[
              Text(
                "Includes:",
                style: AppTextStyles(
                  context,
                ).captionRegular.copyWith(color: AppColors.textSecondary),
              ),
              ...features.map(
                (f) => Text(
                  "\u2022 $f",
                  style: AppTextStyles(
                    context,
                  ).captionRegular.copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
