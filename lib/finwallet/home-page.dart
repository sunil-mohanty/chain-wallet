import 'package:chain_wallet/components/animations.dart';
import 'package:chain_wallet/components/theme.dart';
import 'package:chain_wallet/components/util.dart';
import 'package:chain_wallet/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chain_wallet/market.dart';
import 'package:chain_wallet/chain-work/activity.dart';
import 'package:chain_wallet/BottomNavigationBarScreen.dart';

//import 'l10n/l10n.dart';

import 'package:chain_wallet/components/profilepage_model.dart';
export 'package:chain_wallet/components/profilepage_model.dart';

class HomePageWidget extends StatefulWidget {
  //final String? username;
  //final String? password;

  //final VoidCallback onActivityPressed;

  //HomePageWidget({required this.onTransfersPressed});
  //const HomePageWidget(this.username, this.password, {Key? key}) : super(key: key);
  const HomePageWidget({Key? key, this.arguments}) : super(key: key);

  final Map<String, dynamic>? arguments;

  @override
  _HomePageWidgetState createState() =>
      _HomePageWidgetState(this.arguments); //, this.onActivityPressed);
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  final Map<String, dynamic>? arguments;
  _HomePageWidgetState(this.arguments, {Key? key}) : super();

  //final VoidCallback onActivityPressed;
  // final String? username;

  late ProfilepageModel _model;
  late String username;
  final kTransitionInfoKey = 'transition_info_key';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, 60),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 800.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 800.ms,
          begin: Offset(0, 90),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(0, 90),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilepageModel());
    username = arguments?['username'];
    print('username = arguments?[username] :$username');
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // other MaterialApp properties
    );
    // if (isiOS) {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarBrightness: Theme.of(context).brightness,
    //       systemStatusBarContrastEnforced: true,
    //     ),
    //   );
    // }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,

        //backgroundColor: DarkModeTheme()
        //    .primaryBackground, //ChainWorkTheme.of(context).primaryBackground,

        body: Container(
          //SafeArea(
          //top: true,
          child: Container(
            margin: EdgeInsets.zero, // Set margin to zero
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 13, 19, 133),
                  Color.fromARGB(255, 87, 91, 35),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                //stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 60.0),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.walletBalance ??
                            'Wallet Balance',
                        /* Wallet Balance */

                        style: ChainWorkTheme.of(context).titleMedium,
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: ChainWorkTheme.of(context).primary,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                          child: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://picsum.photos/seed/750/600',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // AppLocalizations.of(context).getText(
                        //   'fgf8icmv' /* $23,000 */,
                        //
                        AppLocalizations.of(context)?.balance ?? '\AED 23,000',

                        style: ChainWorkTheme.of(context).displaySmall.override(
                              fontFamily: 'Lexend',
                              fontSize: 36,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.currencies ??
                            '3 currencies',
                        style: ChainWorkTheme.of(context).bodyMedium.override(
                              fontFamily: 'Lexend',
                              color: ChainWorkTheme.of(context).tertiary,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(26, 16, 26, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.24,
                          // decoration: BoxDecoration(
                          //   color: ChainWorkTheme.of(context)
                          //       .secondaryBackground,
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.transparent],
                              stops: [0, 1],
                              begin: AlignmentDirectional(1, -1),
                              end: AlignmentDirectional(-1, 1),
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                  0.2), // Adjust the opacity as needed
                              width: 1.0, // Adjust the border width as needed
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 12),
                                  child: Icon(
                                    Icons.account_balance_outlined,
                                    color:
                                        ChainWorkTheme.of(context).primaryText,
                                    size: 36,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    AppLocalizations.of(context)?.myBank ??
                                        'My Bank',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      'Lexend Deca',
                                      color: ChainWorkTheme.of(context)
                                          .primaryText,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              Navigator.pushNamed(context, '/transfer',
                                  arguments: arguments);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.24,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent
                                  ],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(1, -1),
                                  end: AlignmentDirectional(-1, 1),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(
                                      0.2), // Adjust the opacity as needed
                                  width:
                                      1.0, // Adjust the border width as needed
                                ),
                              ),
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 16, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Icon(
                                      Icons.swap_horiz_outlined,
                                      color: ChainWorkTheme.of(context)
                                          .primaryText,
                                      size: 36,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      AppLocalizations.of(context)?.transafer ??
                                          'Transfer',
                                      style: GoogleFonts.getFont(
                                        'Lexend Deca',
                                        color: ChainWorkTheme.of(context)
                                            .primaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            // context.goNamed('MY_Card');
                            //  Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //      builder: (context) => onActivityPressed(),
                            //     ));
                            //onActivityPressed();
                            print('username in the home-page is $username');
                            Navigator.pushNamed(context, '/activity',
                                arguments: arguments);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.24,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ],
                                stops: [0, 1],
                                begin: AlignmentDirectional(1, -1),
                                end: AlignmentDirectional(-1, 1),
                              ),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                    0.2), // Adjust the opacity as needed
                                width: 1.0, // Adjust the border width as needed
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 16, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Icon(
                                      Icons.stacked_line_chart_rounded,
                                      color: ChainWorkTheme.of(context)
                                          .primaryText,
                                      size: 36,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 4, 0, 0),
                                    child: Text(
                                      AppLocalizations.of(context)?.activity ??
                                          'Activity',
                                      style: GoogleFonts.getFont(
                                        'Lexend Deca',
                                        color: ChainWorkTheme.of(context)
                                            .primaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.transparent],
                              stops: [0, 1],
                              begin: AlignmentDirectional(1, -1),
                              end: AlignmentDirectional(-1, 1),
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(
                                  0.2), // Adjust the opacity as needed
                              width: 1.0, // Adjust the border width as needed
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)?.bitcoin ??
                                      'Magnate',
                                  style:
                                      ChainWorkTheme.of(context).headlineSmall,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Text(
                                        AppLocalizations.of(context)
                                                ?.bitcoinBalance ??
                                            '\AED 7,302',
                                        style: ChainWorkTheme.of(context)
                                            .displaySmall,
                                      ),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)
                                                ?.bitcoinPortfolio ??
                                            '32% of portfolio',
                                        style: ChainWorkTheme.of(context)
                                            .bodyMedium
                                        // .override(
                                        //   fontFamily: 'Lexend',
                                        //   color:
                                        //       Color.fromARGB(189, 22, 22, 22),
                                        // ),
                                        ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 12, 0, 0),
                                        child: LinearPercentIndicator(
                                          percent: 0.3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.77,
                                          lineHeight: 20,
                                          animation: true,
                                          animateFromLastPercent: true,
                                          progressColor:
                                              ChainWorkTheme.of(context)
                                                  .primaryText,
                                          backgroundColor: Color(0x33F1F4F8),
                                          center: Text(
                                            AppLocalizations.of(context)
                                                    ?.firstBalnk ??
                                                '',
                                            style: ChainWorkTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Lexend',
                                                  color:
                                                      ChainWorkTheme.of(context)
                                                          .primary,
                                                ),
                                          ),
                                          barRadius: Radius.circular(40),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                    .animateOnPageLoad(
                        animationsMap['containerOnPageLoadAnimation1']!),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.transparent],
                        stops: [0, 1],
                        begin: AlignmentDirectional(1, -1),
                        end: AlignmentDirectional(-1, 1),
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white
                            .withOpacity(0.2), // Adjust the opacity as needed
                        width: 1.0, // Adjust the border width as needed
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.solana ?? 'Tether',
                            style: ChainWorkTheme.of(context).headlineSmall,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Text(
                                  AppLocalizations.of(context)?.solanaBalance ??
                                      '\AED 7,403',
                                  style:
                                      ChainWorkTheme.of(context).displaySmall,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                        ?.solanaPortfolioPercentage ??
                                    '40% of portfolio',
                                style: ChainWorkTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: LinearPercentIndicator(
                                  percent: 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.77,
                                  lineHeight: 20,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      ChainWorkTheme.of(context).primaryText,
                                  backgroundColor: Color(0x33F1F4F8),
                                  center: Text(
                                    AppLocalizations.of(context)?.secondBlank ??
                                        '',
                                    style: ChainWorkTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Lexend',
                                          color: ChainWorkTheme.of(context)
                                              .primary,
                                        ),
                                  ),
                                  barRadius: Radius.circular(40),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation2']!),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.transparent],
                        stops: [0, 1],
                        begin: AlignmentDirectional(1, -1),
                        end: AlignmentDirectional(-1, 1),
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white
                            .withOpacity(0.2), // Adjust the opacity as needed
                        width: 1.0, // Adjust the border width as needed
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.dogeCoin ?? 'Ripple',
                            style: ChainWorkTheme.of(context).headlineSmall,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Text(
                                  AppLocalizations.of(context)
                                          ?.dogeCoinBalance ??
                                      '\AED 7,403',
                                  style:
                                      ChainWorkTheme.of(context).displaySmall,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                        ?.dogeCoinPortfolioPercentage ??
                                    '40% of portfolio',
                                style: ChainWorkTheme.of(context).bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: LinearPercentIndicator(
                                  percent: 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.77,
                                  lineHeight: 20,
                                  animation: true,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      ChainWorkTheme.of(context).primaryText,
                                  backgroundColor:
                                      Color.fromARGB(51, 93, 114, 142),
                                  center: Text(
                                    AppLocalizations.of(context)?.thirdBlank ??
                                        '',
                                    style: ChainWorkTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Lexend',
                                          color: ChainWorkTheme.of(context)
                                              .primary,
                                        ),
                                  ),
                                  barRadius: Radius.circular(40),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation3']!),
                ),
              ],
            ),
          ),
        ),
        //bottomNavigationBar: BottomNavigationBarScreen(),
      ),
    );
  }
}
