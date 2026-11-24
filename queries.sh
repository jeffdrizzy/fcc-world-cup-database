#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"
# Do not change code above this line. Use the PSQL variable above to query your database.
# Run a query, stripping the psql startup banner lines printed by .psqlrc
run_query() {
  $PSQL "$1" | grep -v -e '^Border style' -e '^Title is' -e '^Pager usage'
}
echo -e "\nTotal number of goals in all games from winning teams:"
echo "$(run_query "SELECT SUM(winner_goals) FROM games")"
echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$(run_query "SELECT SUM(winner_goals + opponent_goals) FROM games")"
echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$(run_query "SELECT AVG(winner_goals) FROM games")"
echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$(run_query "SELECT ROUND(AVG(winner_goals), 2) FROM games")"
echo -e "\nAverage number of goals in all games from both teams:"
echo "$(run_query "SELECT AVG(winner_goals + opponent_goals) FROM games")"
echo -e "\nMost goals scored in a single game by one team:"
echo "$(run_query "SELECT MAX(winner_goals) FROM games")"
echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$(run_query "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"
echo -e "\nWinner of the 2018 tournament team name:"
echo "$(run_query "SELECT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE year = 2018 AND round = 'Final'")"
echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$(run_query "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id OR teams.team_id = games.opponent_id WHERE year = 2014 AND round = 'Eighth-Final' ORDER BY name")"
echo -e "\nList of unique winning team names in the whole data set:"
echo "$(run_query "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name")"
echo -e "\nYear and team name of all the champions:"
echo "$(run_query "SELECT year, name FROM teams INNER JOIN games ON teams.team_id = games.winner_id WHERE round = 'Final' ORDER BY year")"
echo -e "\nList of teams that start with 'Co':"
echo "$(run_query "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name")"
