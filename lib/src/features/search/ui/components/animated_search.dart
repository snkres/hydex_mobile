import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/features/search/ui/search_screen.dart';
import 'package:hydex/src/features/search/ui/viewmodel.dart';

class AnimatedSearch extends ConsumerStatefulWidget {
  const AnimatedSearch({
    super.key,
    required this.searchController,
    required this.onClick,
    required this.onCancel,
    this.isClicked = false,
  });
  final TextEditingController searchController;
  final VoidCallback onClick, onCancel;
  final bool isClicked;

  @override
  ConsumerState<AnimatedSearch> createState() => _AnimatedSearchState();
}

class _AnimatedSearchState extends ConsumerState<AnimatedSearch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: widget.searchController.text.isEmpty ? 0 : 8,
      ),
      child: Row(
        spacing: 4,
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              decoration: BoxDecoration(
                image: widget.isClicked
                    ? DecorationImage(
                        image: AssetImage(
                          "img/search_gradient.png",
                          package: "assets",
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(100),
                color: !widget.isClicked ? Color(0xff1B1921) : null,
              ),
              child: TextField(
                onTap: widget.onClick,
                controller: widget.searchController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (value) {
                  setState(() {});
                  ref.read(searchViewModelProvider.notifier).setQuery(value);
                },
                decoration: InputDecoration(
                  hintText: "Search events, venues...",
                  hintStyle: AppTextStyles(
                    context,
                  ).smallRegular.copyWith(color: Color(0xff89898F)),
                  fillColor: !widget.isClicked
                      ? Color(0xff1B1921)
                      : Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff323133),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  filled: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: SvgPicture.asset(
                      "img/svg/search.svg",
                      width: 23,
                      package: "assets",
                      colorFilter: ColorFilter.mode(
                        !widget.isClicked ? Color(0xff47464D) : Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: !widget.isClicked ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic,
                        child: IgnorePointer(
                          ignoring: widget.isClicked,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              top: 5,
                              bottom: 5,
                              right: 5,
                            ),
                            child: SizedBox(
                              width: 54,
                              height: 54,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: widget.isClicked ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic,
                        child: IgnorePointer(
                          ignoring: !widget.isClicked,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              top: 5,
                              bottom: 5,
                              right: 5,
                            ),
                            child: SizedBox(
                              width: 54,
                              height: 54,
                              child: IconButton(
                                style: ButtonStyle(
                                  backgroundColor: .all(Colors.transparent),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => FiltersWidget(),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  width: 19,
                                  "img/svg/filter.svg",
                                  package: "assets",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            child: widget.isClicked
                ? AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCubic,
                    child: AnimatedSlide(
                      offset: Offset.zero,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic,
                      child: TextButton(
                        onPressed: () {
                          widget.searchController.clear();
                          ref
                              .read(searchViewModelProvider.notifier)
                              .setQuery("");
                          FocusScope.of(context).unfocus();
                          widget.onCancel();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppTextStyles(context).accumulator * 12,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
