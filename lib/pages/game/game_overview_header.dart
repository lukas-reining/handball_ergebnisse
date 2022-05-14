import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/game.dart';

class GameOverviewHeader extends StatelessWidget {
  final Game game;

  const GameOverviewHeader({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage(
                    'assets/handball.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                  decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.0)),
                ),
              ),
            ),
            Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameHeaderText(
                        text: game.hasData ? game.teams.home.goals.toString() : "-",
                        size: 100,
                        alignment: Alignment.centerRight,
                        flex: 5,
                      ),
                      GameHeaderText(
                        text: ":",
                        size: 100,
                        alignment: Alignment.center,
                        flex: 1,
                      ),
                      GameHeaderText(
                        text: game.hasData ? game.teams.guest.goals.toString() : "-",
                        size: 100,
                        alignment: Alignment.centerLeft,
                        flex: 5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GameHeaderText(
                        text: game.teams.home.name,
                        size: 16,
                        alignment: Alignment.centerRight,
                        flex: 5,
                      ),
                      GameHeaderText(
                        text: ":",
                        size: 16,
                        alignment: Alignment.center,
                        flex: 1,
                      ),
                      GameHeaderText(
                        text: game.teams.guest.name,
                        size: 16,
                        alignment: Alignment.centerLeft,
                        flex: 5,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GameHeaderTextBold extends StatelessWidget {
  final String text;

  const GameHeaderTextBold({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 100,
        ),
      ),
    );
  }
}

class GameHeaderText extends StatelessWidget {
  final String text;
  final double size;
  final Alignment alignment;
  final TextAlign textAlign;
  final int flex;

  GameHeaderText(
      {Key? key,
      required this.text,
      required this.size,
      required this.alignment,
      this.flex = 1})
      : textAlign = alignment == Alignment.centerLeft
            ? TextAlign.left
            : alignment == Alignment.centerRight
                ? TextAlign.right
                : TextAlign.center,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: flex,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}
