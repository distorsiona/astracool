import 'package:flutter/material.dart';

import '../models/house_model.dart';
import '../services/api_service.dart';
import '../theme/zodiac_theme.dart';
import '../widgets/sacred_detail_top_bar.dart';

import 'housedetail_screen.dart';

import 'allhouses/widgets/empty_houses_card.dart';
import 'allhouses/widgets/page_header.dart';
import 'allhouses/widgets/responsive_houses_grid.dart';

class AllHousesScreen extends StatefulWidget {
  final String userId;
  final String chartId;
  final String zodiacSign;

  const AllHousesScreen({
    super.key,
    required this.userId,
    required this.chartId,
    required this.zodiacSign,
  });

  @override
  State<AllHousesScreen> createState() => _AllHousesScreenState();
}

class _AllHousesScreenState extends State<AllHousesScreen> {
  final ApiService _apiService = ApiService();

  bool _isLoading = true;
  String? _errorMessage;

  List<HouseModel> _houses = [];

  @override
  void initState() {
    super.initState();
    _loadHouses();
  }

  Future<void> _loadHouses() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _apiService.getHouses(
        widget.userId,
      );

      final sortedHouses = [...response.houses]
        ..sort(
          (a, b) => a.house.compareTo(b.house),
        );

      if (!mounted) {
        return;
      }

      setState(() {
        _houses = sortedHouses;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = ZodiacTheme.colorForSign(
      widget.zodiacSign,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EE),
      body: SafeArea(
        child: Column(
          children: [
            SacredDetailTopBar(
              accentColor: accentColor,
              trailingLabel: 'HOUSES',
              onBack: () => Navigator.pop(context),
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final isMobile = width < 650;
                  final isTablet =
                      width >= 650 && width < 1100;

                  final horizontalPadding = isMobile
                      ? 14.0
                      : isTablet
                          ? 28.0
                          : 46.0;

                  final topPadding = isMobile
                      ? 20.0
                      : 30.0;

                  return RefreshIndicator(
                    onRefresh: _loadHouses,
                    child: SingleChildScrollView(
                      physics:
                          const AlwaysScrollableScrollPhysics(
                        parent:
                            BouncingScrollPhysics(),
                      ),
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        topPadding,
                        horizontalPadding,
                        48,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints:
                              const BoxConstraints(
                            maxWidth: 1540,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              PageHeader(
                                accentColor: accentColor,
                                isMobile: isMobile,
                                isTablet: isTablet,
                              ),

                              const SizedBox(height: 30),

                              if (_isLoading)
                                _LoadingHousesCard(
                                  accentColor:
                                      accentColor,
                                )
                              else if (_errorMessage != null)
                                _ErrorHousesCard(
                                  accentColor:
                                      accentColor,
                                  message:
                                      _errorMessage!,
                                  onRetry:
                                      _loadHouses,
                                )
                              else if (_houses.isEmpty)
                                EmptyHousesCard(
                                  accentColor:
                                      accentColor,
                                )
                              else
                                ResponsiveHousesGrid(
                                  houses: _houses,
                                  accentColor:
                                      accentColor,
                                  isMobile: isMobile,
                                  isTablet: isTablet,
                                  onHouseTap: (house) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            HouseDetailScreen(
                                          userId:
                                              widget.userId,
                                          chartId:
                                              widget.chartId,
                                          houseNumber:
                                              house.house,
                                          zodiacSign:
                                              widget.zodiacSign,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingHousesCard extends StatelessWidget {
  final Color accentColor;

  const _LoadingHousesCard({
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 220,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.72,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withValues(
            alpha: 0.18,
          ),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: accentColor,
        ),
      ),
    );
  }
}

class _ErrorHousesCard extends StatelessWidget {
  final Color accentColor;
  final String message;
  final VoidCallback onRetry;

  const _ErrorHousesCard({
    required this.accentColor,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.72,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: accentColor.withValues(
            alpha: 0.18,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Could not load houses',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: accentColor,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF6B625D),
            ),
          ),

          const SizedBox(height: 20),

          OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              foregroundColor: accentColor,
              side: BorderSide(
                color: accentColor,
              ),
            ),
            child: const Text(
              'RETRY',
            ),
          ),
        ],
      ),
    );
  }
}