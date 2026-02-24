--Creative addition: Define a new meaningful query using at least three tables, and some window function.
-- Explain clearly what your query achieves, and what the results mean



--THINKING NOTES

--New query: Units sold. What this query does is determine how many units of the specific album have been sold. 
--(using a window function) Divide these groups up

--Tables to use -> invoice_items, tracks, and albums

--The output is what songs are eligible for RIAA rankings (gold, platinum, multi-platinum, and diamond), 
--and depending on how many units are sold, it categorizes them according to what they should earn/have earned.

SELECT
    AlbumId,
    Title,
    UnitsSold,
    CASE --allows if then statements!
        WHEN UnitsSold >= 100 THEN 'Diamond'
        WHEN UnitsSold >= 20 THEN 'Multi-Platinum'
        WHEN UnitsSold >= 10 THEN 'Platinum'
        WHEN UnitsSold >= 5 THEN 'Gold'
        ELSE 'Not Certified'
    END AS RIAA_Ranking,
    RANK() OVER (ORDER BY UnitsSold DESC) AS SalesRank
FROM (
    SELECT
        a.AlbumId,
        a.Title,
        SUM(ii.Quantity) AS UnitsSold
    FROM invoice_items ii
    JOIN tracks t
        ON ii.TrackId = t.TrackId
    JOIN albums a
        ON t.AlbumId = a.AlbumId
    GROUP BY a.AlbumId
) AS TotalAlbums
ORDER BY UnitsSold DESC;
