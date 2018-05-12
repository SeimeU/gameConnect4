#ifndef GAME_H
#define GAME_H

#include <QObject>

#define ROWS 6
#define COLUMNS 7

class game : public QObject
{
    Q_OBJECT

public:
    game();

    int pitch[ROWS][COLUMNS];
    int row;
    int column;

    // slots that are public methods available in QML
public slots:
    bool setStoneGame(int player, char c[]);
    bool won(int player);
    bool tied();

};

#endif // GAME_H
