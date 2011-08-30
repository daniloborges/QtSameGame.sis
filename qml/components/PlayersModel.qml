import QtQuick 1.0

//Code base here: http://grip.espace-win.net/doc/apps/qt4/html/demos-declarative-snake-content-highscoremodel-qml.html

ListModel {
    id: model
//  property string game: ""
    property int topScore: 0
    property string topPlayer: ""
    property int maxScores: 10


    function __db()
    {
        return openDatabaseSync("SameGameScores", "1.0", "Local SameGame High Scores", 1000);
//        return openDatabaseSync("HighScoreModel", "1.0", "Generic High Score Functionality for QML", 1000000);
    }
    function __ensureTables(tx)
    {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, gridSize TEXT, time NUMBER)');
//        tx.executeSql('CREATE TABLE IF NOT EXISTS HighScores(game TEXT, score INT, player TEXT)', []);
    }

    function fillModel() {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);
                var rs = tx.executeSql("SELECT score, name, time FROM Scores ORDER BY score DESC");
//                var rs = tx.executeSql("SELECT score,player FROM HighScores WHERE game=? ORDER BY score DESC", [game]);
                model.clear();
                if (rs.rows.length > 0) {
                    topScore = rs.rows.item(0).score
                    topPlayer = rs.rows.item(0).name
                    for (var i=0; i<rs.rows.length; ++i) {
                        if (i < maxScores)
                            model.append(rs.rows.item(i))
                    }
                    if (rs.rows.length > maxScores)
                        tx.executeSql("DELETE FROM Scores WHERE score <= ?",
                                      [rs,rows.item(maxScores).score]);
//                        tx.executeSql("DELETE FROM HighScores WHERE game=? AND score <= ?",
//                                            [game, rs.rows.item(maxScores).score]);
                }
            }
        )
    }

    function savePlayerScore(name, score, time, gridSize) {
        __db().transaction(
            function(tx) {
                __ensureTables(tx);
                tx.executeSql("INSERT INTO Scores VALUES(?,?,?)", [name, score, gridSize, time]);
//                tx.executeSql("INSERT INTO HighScores VALUES(?,?,?)", [game,score,player]);
                fillModel();
            }
        )
    }

//    function saveScore(score) {
//        savePlayerScore("player",score);
//    }

    function clearScores() {
        __db().transaction(
            function(tx) {
                tx.executeSql("DELETE FROM Scores");
//                tx.executeSql("DELETE FROM HighScores WHERE game=?", [game]);
                fillModel();
            }
        )
    }

    Component.onCompleted: { fillModel() }
}
