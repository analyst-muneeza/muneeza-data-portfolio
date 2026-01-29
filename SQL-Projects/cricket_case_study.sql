------------------------------------------------------------
-- CRICKET SQL CASE STUDY – SQLITE VERSION
------------------------------------------------------------
-- Enable foreign key constraints in SQLite (off by default)
PRAGMA foreign_keys = ON;

------------------------------------------------------------
-- DROP OLD TABLES (order matters)
------------------------------------------------------------
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS Teams;

------------------------------------------------------------
-- 1) CREATE TABLES
------------------------------------------------------------
CREATE TABLE Players (
    PlayerID     INTEGER PRIMARY KEY,
    PlayerName   TEXT,
    TeamName     TEXT,
    Role         TEXT,
    DebutYear    INTEGER
);

CREATE TABLE Matches (
    MatchID   INTEGER PRIMARY KEY,
    MatchDate TEXT,          -- store as ISO date string 'YYYY-MM-DD'
    Location  TEXT,
    Team1     TEXT,
    Team2     TEXT,
    Winner    TEXT
);

CREATE TABLE Performance (
    MatchID      INTEGER,
    PlayerID     INTEGER,
    RunsScored   INTEGER,
    WicketsTaken INTEGER,
    Catches      INTEGER,
    Stumpings    INTEGER,
    NotOut       INTEGER,   -- SQLite: 0/1
    RunOuts      INTEGER,
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

CREATE TABLE Teams (
    TeamName TEXT PRIMARY KEY,
    Coach    TEXT,
    Captain  TEXT
);

------------------------------------------------------------
-- 2) INSERT MASTER DATA 
------------------------------------------------------------
-- Teams
INSERT INTO Teams VALUES
('India',        'Rahul Dravid',       'Rohit Sharma'),
('Australia',    'Andrew McDonald',    'Pat Cummins'),
('England',      'Brendon McCullum',   'Ben Stokes'),
('Afghanistan',  'Jonathan Trott',     'Hashmatullah Shahidi'),
('New Zealand',  'Gary Stead',         'Kane Williamson');

-- Players
INSERT INTO Players VALUES
(1,  'Virat Kohli',        'India',       'Batsman',       2008),
(4,  'MS Dhoni',           'India',       'Wicket-Keeper', 2004),
(8,  'Jasprit Bumrah',     'India',       'Bowler',        2016),
(11, 'Rohit Sharma',       'India',       'Batsman',       2007),
(12, 'Hardik Pandya',      'India',       'All-Rounder',   2016),

(2,  'Steve Smith',        'Australia',   'Batsman',       2010),
(3,  'Mitchell Starc',     'Australia',   'Bowler',        2010),
(7,  'David Warner',       'Australia',   'Batsman',       2009),
(13, 'Pat Cummins',        'Australia',   'Bowler',        2011),
(14, 'Glenn Maxwell',      'Australia',   'All-Rounder',   2012),

(5,  'Ben Stokes',         'England',     'All-Rounder',   2011),
(9,  'Joe Root',           'England',     'Batsman',       2012),
(15, 'Jos Buttler',        'England',     'Wicket-Keeper', 2011),
(16, 'Jofra Archer',       'England',     'Bowler',        2019),
(17, 'Moeen Ali',          'England',     'All-Rounder',   2014),

(6,  'Rashid Khan',        'Afghanistan', 'Bowler',        2015),
(18, 'Mohammad Nabi',      'Afghanistan', 'All-Rounder',   2010),
(19, 'Hazratullah Zazai',  'Afghanistan', 'Batsman',       2016),
(20, 'Rahmanullah Gurbaz', 'Afghanistan', 'Wicket-Keeper', 2019),

(10, 'Kane Williamson',    'New Zealand', 'Batsman',       2010),
(21, 'Trent Boult',        'New Zealand', 'Bowler',        2011),
(22, 'Devon Conway',       'New Zealand', 'Batsman',       2020),
(23, 'Tom Latham',         'New Zealand', 'Wicket-Keeper', 2012);

-- Matches
INSERT INTO Matches VALUES
(1, '2023-03-01', 'Mumbai',    'India',     'Australia',   'India'),
(2, '2023-03-05', 'Sydney',    'Australia', 'England',     'England'),
(3, '2023-04-10', 'London',    'England',   'India',       'India'),
(4, '2023-05-15', 'Dubai',     'India',     'Afghanistan', 'India'),
(5, '2023-06-20', 'Melbourne', 'Australia', 'New Zealand', 'Australia');

-- Performance
-- Match 1: India vs Australia (Winner: India)
INSERT INTO Performance VALUES
(1, 1,  82, 0, 1, 0, 0, 0),
(1, 4,  35, 0, 0, 1, 1, 0),
(1, 8,  15, 2, 0, 0, 0, 0),
(1, 11, 55, 0, 1, 0, 0, 0),
(1, 12, 25, 1, 0, 0, 0, 0),
(1, 2,  60, 0, 1, 0, 0, 0),
(1, 3,  10, 3, 0, 0, 0, 0),
(1, 7,  40, 0, 0, 0, 1, 0),
(1, 13, 5,  2, 0, 0, 0, 0),
(1, 14, 35, 1, 1, 0, 0, 0);

-- Match 2: Australia vs England (Winner: England)
INSERT INTO Performance VALUES
(2, 2,  75, 0, 1, 0, 0, 0),
(2, 3,  20, 2, 0, 0, 0, 0),
(2, 7,  55, 0, 0, 0, 0, 0),
(2, 13, 15, 3, 0, 0, 0, 0),
(2, 14, 30, 1, 0, 0, 0, 0),
(2, 5,  85, 0, 0, 0, 0, 0),
(2, 9,  120,0, 2, 0, 1, 0),
(2, 15, 25, 0, 1, 1, 0, 0),
(2, 16, 5,  4, 0, 0, 0, 0),
(2, 17, 40, 1, 0, 0, 0, 0);

-- Match 3: England vs India (Winner: India)
INSERT INTO Performance VALUES
(3, 5,  35, 0, 1, 0, 0, 0),
(3, 9,  90, 0, 0, 0, 1, 0),
(3, 15, 15, 0, 2, 1, 0, 0),
(3, 16, 10, 3, 0, 0, 0, 0),
(3, 1,  45, 0, 1, 0, 0, 0),
(3, 4,  22, 0, 0, 2, 1, 0),
(3, 8,  12, 2, 0, 0, 0, 0),
(3, 11, 65, 0, 0, 0, 0, 0),
(3, 12, 35, 1, 1, 0, 0, 0);

-- Match 4: India vs Afghanistan (Winner: India)
INSERT INTO Performance VALUES
(4, 1,  90, 0, 1, 0, 0, 0),
(4, 4,  30, 0, 0, 1, 1, 0),
(4, 8,  20, 3, 0, 0, 0, 0),
(4, 11, 75, 0, 0, 0, 0, 0),
(4, 12, 40, 1, 1, 0, 0, 0),
(4, 6,  35, 5, 0, 0, 0, 0),
(4, 18, 55, 2, 1, 0, 0, 0),
(4, 19, 20, 0, 0, 0, 0, 0),
(4, 20, 45, 0, 0, 1, 0, 0);

-- Match 5: Australia vs New Zealand (Winner: Australia)
INSERT INTO Performance VALUES
(5, 2,  70, 0, 1, 0, 0, 0),
(5, 3,  18, 3, 1, 0, 0, 0),
(5, 7,  75, 0, 0, 0, 1, 0),
(5, 13, 5,  2, 0, 0, 0, 0),
(5, 14, 60, 1, 1, 0, 0, 0),
(5, 10, 85, 0, 0, 0, 0, 1),
(5, 21, 12, 4, 0, 0, 0, 0),
(5, 22, 40, 0, 1, 0, 0, 0),
(5, 23, 25, 0, 2, 1, 0, 0);


------------------------------------------------------------
-- Q1. Player with best batting average 
--    batting avg = total runs / matches played
------------------------------------------------------------
WITH player_stats AS (
    SELECT
        p.PlayerID,
        pl.PlayerName,
        SUM(p.RunsScored) AS total_runs,
        COUNT(DISTINCT p.MatchID) AS matches_played,
        1.0 * SUM(p.RunsScored) / COUNT(DISTINCT p.MatchID) AS batting_avg
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.PlayerID
)
SELECT *
FROM player_stats
WHERE batting_avg = (SELECT MAX(batting_avg) FROM player_stats);

------------------------------------------------------------
-- Q2. Team with highest win percentage
------------------------------------------------------------
WITH team_matches AS (
    SELECT TeamName AS team, COUNT(*) AS matches_played
    FROM (
        SELECT Team1 AS TeamName FROM Matches
        UNION ALL
        SELECT Team2 AS TeamName FROM Matches
    )
    GROUP BY TeamName
),
team_wins AS (
    SELECT Winner AS team, COUNT(*) AS wins
    FROM Matches
    GROUP BY Winner
)
SELECT
    tm.team,
    COALESCE(tw.wins, 0) AS wins,
    tm.matches_played,
    1.0 * COALESCE(tw.wins, 0) / tm.matches_played AS win_pct
FROM team_matches tm
LEFT JOIN team_wins tw ON tm.team = tw.team
ORDER BY win_pct DESC, tm.team
LIMIT 1;

------------------------------------------------------------
-- Q3. Player who contributed highest % of their team's runs
--     in any single match
------------------------------------------------------------
WITH player_team_runs AS (
    SELECT
        p.MatchID,
        p.PlayerID,
        pl.PlayerName,
        pl.TeamName,
        p.RunsScored
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
),
team_totals AS (
    SELECT
        MatchID,
        TeamName,
        SUM(RunsScored) AS team_runs
    FROM player_team_runs
    GROUP BY MatchID, TeamName
),
player_pct AS (
    SELECT
        ptr.MatchID,
        ptr.PlayerID,
        ptr.PlayerName,
        ptr.TeamName,
        ptr.RunsScored,
        tt.team_runs,
        1.0 * ptr.RunsScored / tt.team_runs AS pct_of_team
    FROM player_team_runs ptr
    JOIN team_totals tt
      ON ptr.MatchID = tt.MatchID
     AND ptr.TeamName = tt.TeamName
)
SELECT *
FROM player_pct
ORDER BY pct_of_team DESC
LIMIT 1;

------------------------------------------------------------
-- Q4. Most consistent player (smallest variance of runs)
--     Using variance = avg(x^2) - avg(x)^2
--     (compare only players who played >1 match)
------------------------------------------------------------
WITH player_runs AS (
    SELECT
        p.PlayerID,
        pl.PlayerName,
        p.RunsScored * 1.0 AS r
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
),
player_var AS (
    SELECT
        PlayerID,
        PlayerName,
        COUNT(*) AS matches_played,
        AVG(r) AS avg_runs,
        AVG(r * r) - (AVG(r) * AVG(r)) AS variance
    FROM player_runs
    GROUP BY PlayerID, PlayerName
    HAVING COUNT(*) > 1
)
SELECT *
FROM player_var
WHERE variance = (SELECT MIN(variance) FROM player_var);

------------------------------------------------------------
-- Q5. Matches where (runs + wickets + catches) > 500
------------------------------------------------------------
WITH match_aggr AS (
    SELECT
        MatchID,
        SUM(RunsScored)   AS total_runs,
        SUM(WicketsTaken) AS total_wickets,
        SUM(Catches)      AS total_catches
    FROM Performance
    GROUP BY MatchID
)
SELECT
    m.MatchID,
    m.MatchDate,
    ma.total_runs,
    ma.total_wickets,
    ma.total_catches,
    (ma.total_runs + ma.total_wickets + ma.total_catches) AS combined_total
FROM match_aggr ma
JOIN Matches m ON ma.MatchID = m.MatchID
WHERE (ma.total_runs + ma.total_wickets + ma.total_catches) > 500;

------------------------------------------------------------
-- Q6. Player who has won the most "Player of the Match" awards
--     (highest runs OR highest wickets in a match)
------------------------------------------------------------
WITH per_match_max AS (
    SELECT
        MatchID,
        MAX(RunsScored)   AS max_runs,
        MAX(WicketsTaken) AS max_wkts
    FROM Performance
    GROUP BY MatchID
),
pom AS (
    SELECT
        p.MatchID,
        p.PlayerID
    FROM Performance p
    JOIN per_match_max pm
      ON p.MatchID = pm.MatchID
     AND (p.RunsScored = pm.max_runs OR p.WicketsTaken = pm.max_wkts)
)
SELECT
    pl.PlayerID,
    pl.PlayerName,
    COUNT(*) AS awards_won
FROM pom
JOIN Players pl ON pom.PlayerID = pl.PlayerID
GROUP BY pl.PlayerID, pl.PlayerName
ORDER BY awards_won DESC, pl.PlayerName
LIMIT 1;

------------------------------------------------------------
-- Q7. Team with the most diverse player roles
------------------------------------------------------------
SELECT
    TeamName,
    COUNT(DISTINCT Role) AS distinct_roles
FROM Players
GROUP BY TeamName
ORDER BY distinct_roles DESC, TeamName
LIMIT 1;

------------------------------------------------------------
-- Q8. Matches where teams' runs were unequal,
--     ordered by smallest difference
------------------------------------------------------------
WITH team_runs AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        SUM(p.RunsScored) AS team_runs
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.MatchID, pl.TeamName
),
pairwise AS (
    SELECT
        tr1.MatchID,
        tr1.TeamName AS TeamA,
        tr1.team_runs AS TeamA_Runs,
        tr2.TeamName AS TeamB,
        tr2.team_runs AS TeamB_Runs,
        ABS(tr1.team_runs - tr2.team_runs) AS run_diff
    FROM team_runs tr1
    JOIN team_runs tr2
      ON tr1.MatchID = tr2.MatchID
     AND tr1.TeamName < tr2.TeamName
)
SELECT
    m.MatchID,
    m.MatchDate,
    TeamA,
    TeamA_Runs,
    TeamB,
    TeamB_Runs,
    run_diff
FROM pairwise
JOIN Matches m ON pairwise.MatchID = m.MatchID
WHERE TeamA_Runs <> TeamB_Runs
ORDER BY run_diff ASC, m.MatchID;

------------------------------------------------------------
-- Q9. Players who played in EVERY match their team played
------------------------------------------------------------
WITH team_match_counts AS (
    SELECT TeamName, COUNT(*) AS team_matches
    FROM (
        SELECT MatchID, Team1 AS TeamName FROM Matches
        UNION ALL
        SELECT MatchID, Team2 AS TeamName FROM Matches
    )
    GROUP BY TeamName
),
player_match_counts AS (
    SELECT
        pl.PlayerID,
        pl.PlayerName,
        pl.TeamName,
        COUNT(DISTINCT p.MatchID) AS player_matches
    FROM Players pl
    LEFT JOIN Performance p ON pl.PlayerID = p.PlayerID
    GROUP BY pl.PlayerID, pl.PlayerName, pl.TeamName
)
SELECT
    pmc.PlayerID,
    pmc.PlayerName,
    pmc.TeamName
FROM player_match_counts pmc
JOIN team_match_counts tmc
  ON pmc.TeamName = tmc.TeamName
WHERE pmc.player_matches = tmc.team_matches
  AND tmc.team_matches > 0
ORDER BY pmc.TeamName, pmc.PlayerName;

------------------------------------------------------------
-- Q10. Match with the closest margin of victory
--      (based on actual winner in Matches table)
------------------------------------------------------------
WITH team_runs AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        SUM(p.RunsScored) AS team_runs
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.MatchID, pl.TeamName
),
match_diff AS (
    SELECT
        m.MatchID,
        m.MatchDate,
        m.Winner,
        tr_win.team_runs AS winner_runs,
        tr_opp.team_runs AS opponent_runs,
        (tr_win.team_runs - tr_opp.team_runs) AS margin
    FROM Matches m
    JOIN team_runs tr_win
      ON m.MatchID = tr_win.MatchID
     AND m.Winner  = tr_win.TeamName
    JOIN team_runs tr_opp
      ON m.MatchID = tr_opp.MatchID
     AND m.Winner <> tr_opp.TeamName
)
SELECT *
FROM match_diff
ORDER BY margin ASC
LIMIT 1;

------------------------------------------------------------
-- Q11. Total runs scored by each team across all matches
------------------------------------------------------------
WITH team_runs AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        SUM(p.RunsScored) AS team_runs
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.MatchID, pl.TeamName
)
SELECT
    TeamName,
    SUM(team_runs) AS total_runs_across_matches
FROM team_runs
GROUP BY TeamName
ORDER BY total_runs_across_matches DESC, TeamName;

------------------------------------------------------------
-- Q12. Matches where winning team took > 2 wickets
------------------------------------------------------------
WITH team_wickets AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        SUM(p.WicketsTaken) AS total_wkts
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.MatchID, pl.TeamName
)
SELECT
    m.MatchID,
    m.MatchDate,
    m.Winner,
    tw.total_wkts
FROM Matches m
JOIN team_wickets tw
  ON m.MatchID = tw.MatchID
 AND m.Winner  = tw.TeamName
WHERE tw.total_wkts > 2
ORDER BY m.MatchID;

------------------------------------------------------------
-- Q13. Top 5 matches with highest individual scores
------------------------------------------------------------
SELECT
    p.MatchID,
    m.MatchDate,
    p.PlayerID,
    pl.PlayerName,
    p.RunsScored
FROM Performance p
JOIN Players  pl ON p.PlayerID = pl.PlayerID
JOIN Matches  m  ON p.MatchID  = m.MatchID
ORDER BY p.RunsScored DESC, p.MatchID, p.PlayerID
LIMIT 5;

------------------------------------------------------------
-- Q14. Bowlers with at least 5 wickets overall
------------------------------------------------------------
SELECT
    pl.PlayerID,
    pl.PlayerName,
    SUM(p.WicketsTaken) AS total_wickets
FROM Players pl
JOIN Performance p ON pl.PlayerID = p.PlayerID
WHERE pl.Role = 'Bowler'
GROUP BY pl.PlayerID, pl.PlayerName
HAVING SUM(p.WicketsTaken) >= 5
ORDER BY total_wickets DESC, pl.PlayerName;

------------------------------------------------------------
-- Q15. Total catches by winning team in each match
------------------------------------------------------------
SELECT
    m.MatchID,
    m.MatchDate,
    m.Winner,
    SUM(p.Catches) AS total_catches_by_winner
FROM Matches m
JOIN Performance p ON m.MatchID = p.MatchID
JOIN Players    pl ON p.PlayerID = pl.PlayerID
                  AND pl.TeamName = m.Winner
GROUP BY m.MatchID, m.MatchDate, m.Winner
ORDER BY m.MatchID;

------------------------------------------------------------
-- Q16. Player with highest total IMPACT (>= 3 matches)
--      impact = runs*1.5 + wickets*25 + catches*10 + stumpings*15 + runouts*10
------------------------------------------------------------
WITH player_imp AS (
    SELECT
        p.PlayerID,
        COUNT(DISTINCT p.MatchID) AS matches_played,
        SUM( p.RunsScored * 1.5
           + p.WicketsTaken * 25
           + p.Catches * 10
           + p.Stumpings * 15
           + p.RunOuts * 10 ) AS total_impact
    FROM Performance p
    GROUP BY p.PlayerID
),
eligible AS (
    SELECT * FROM player_imp WHERE matches_played >= 3
)
SELECT
    e.PlayerID,
    pl.PlayerName,
    e.matches_played,
    e.total_impact
FROM eligible e
JOIN Players pl ON e.PlayerID = pl.PlayerID
WHERE e.total_impact = (SELECT MAX(total_impact) FROM eligible);

------------------------------------------------------------
-- Q17. Match(es) where winning team had narrowest margin
------------------------------------------------------------
WITH team_runs AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        SUM(p.RunsScored) AS team_runs
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
    GROUP BY p.MatchID, pl.TeamName
),
match_diff AS (
    SELECT
        m.MatchID,
        m.MatchDate,
        m.Winner,
        tr_win.team_runs AS winner_runs,
        tr_opp.team_runs AS opponent_runs,
        (tr_win.team_runs - tr_opp.team_runs) AS margin
    FROM Matches m
    JOIN team_runs tr_win
      ON m.MatchID = tr_win.MatchID
     AND m.Winner  = tr_win.TeamName
    JOIN team_runs tr_opp
      ON m.MatchID = tr_opp.MatchID
     AND m.Winner <> tr_opp.TeamName
)
SELECT *
FROM match_diff
WHERE margin = (SELECT MIN(margin) FROM match_diff)
ORDER BY MatchID;

------------------------------------------------------------
-- Q18. Players who outperformed their teammates (highest
--      runs in team) in > 50% of matches they played
------------------------------------------------------------
WITH team_player_runs AS (
    SELECT
        p.MatchID,
        pl.TeamName,
        p.PlayerID,
        p.RunsScored
    FROM Performance p
    JOIN Players pl ON p.PlayerID = pl.PlayerID
),
team_max AS (
    SELECT
        MatchID,
        TeamName,
        MAX(RunsScored) AS max_runs
    FROM team_player_runs
    GROUP BY MatchID, TeamName
),
wins AS (
    SELECT
        tpr.PlayerID,
        COUNT(*) AS top_in_team
    FROM team_player_runs tpr
    JOIN team_max tm
      ON tpr.MatchID = tm.MatchID
     AND tpr.TeamName = tm.TeamName
     AND tpr.RunsScored = tm.max_runs
    GROUP BY tpr.PlayerID
),
player_counts AS (
    SELECT
        PlayerID,
        COUNT(DISTINCT MatchID) AS matches_played
    FROM Performance
    GROUP BY PlayerID
)
SELECT
    pc.PlayerID,
    pl.PlayerName,
    pc.matches_played,
    w.top_in_team,
    1.0 * w.top_in_team / pc.matches_played AS pct_matches_top
FROM player_counts pc
JOIN wins w ON pc.PlayerID = w.PlayerID
JOIN Players pl ON pc.PlayerID = pl.PlayerID
WHERE w.top_in_team > 0.5 * pc.matches_played
ORDER BY pct_matches_top DESC, pl.PlayerName;

------------------------------------------------------------
-- Q19. Rank players by AVG impact (>=3 matches)
--      Use DENSE_RANK so equal avgs share rank
------------------------------------------------------------
WITH player_imp AS (
    SELECT
        p.PlayerID,
        COUNT(DISTINCT p.MatchID) AS matches_played,
        SUM( p.RunsScored * 1.5
           + p.WicketsTaken * 25
           + p.Catches * 10
           + p.Stumpings * 15
           + p.RunOuts * 10 ) AS total_impact
    FROM Performance p
    GROUP BY p.PlayerID
),
eligible AS (
    SELECT
        pi.PlayerID,
        pi.matches_played,
        pi.total_impact,
        1.0 * pi.total_impact / pi.matches_played AS avg_impact
    FROM player_imp pi
    WHERE pi.matches_played >= 3
)
SELECT
    e.PlayerID,
    pl.PlayerName,
    e.matches_played,
    e.avg_impact,
    DENSE_RANK() OVER (ORDER BY e.avg_impact DESC) AS impact_rank
FROM eligible e
JOIN Players pl ON e.PlayerID = pl.PlayerID
ORDER BY impact_rank, e.avg_impact DESC, pl.PlayerName;

------------------------------------------------------------
-- Q20. Top 3 matches with highest total runs (both teams)
--      Use DENSE_RANK to handle ties
------------------------------------------------------------
WITH match_totals AS (
    SELECT
        MatchID,
        SUM(RunsScored) AS total_runs
    FROM Performance
    GROUP BY MatchID
),
ranked AS (
    SELECT
        m.MatchID,
        m.MatchDate,
        mt.total_runs,
        DENSE_RANK() OVER (ORDER BY mt.total_runs DESC) AS run_rank
    FROM match_totals mt
    JOIN Matches m ON mt.MatchID = m.MatchID
)
SELECT *
FROM ranked
WHERE run_rank <= 3
ORDER BY run_rank, MatchID;

------------------------------------------------------------
-- Q21. Running cumulative impact per player (>=3 matches)
------------------------------------------------------------
WITH perf_with_dates AS (
    SELECT
        p.MatchID,
        p.PlayerID,
        m.MatchDate,
        ( p.RunsScored * 1.5
        + p.WicketsTaken * 25
        + p.Catches * 10
        + p.Stumpings * 15
        + p.RunOuts * 10 ) AS impact
    FROM Performance p
    JOIN Matches m ON p.MatchID = m.MatchID
),
eligible_players AS (
    SELECT PlayerID
    FROM perf_with_dates
    GROUP BY PlayerID
    HAVING COUNT(*) >= 3
)
SELECT
    pwd.PlayerID,
    pl.PlayerName,
    pwd.MatchID,
    pwd.MatchDate,
    pwd.impact,
    SUM(pwd.impact) OVER (
        PARTITION BY pwd.PlayerID
        ORDER BY pwd.MatchDate, pwd.MatchID
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_cumulative_impact
FROM perf_with_dates pwd
JOIN eligible_players ep ON pwd.PlayerID = ep.PlayerID
JOIN Players pl ON pwd.PlayerID = pl.PlayerID
ORDER BY pwd.PlayerID, pwd.MatchDate, pwd.MatchID;
