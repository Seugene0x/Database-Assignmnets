--What is the total length of each playlist in hours? List the playlist id and name of only 
--those playlists that are longer than 2 hours, along with the length in hours rounded to two decimals.

SELECT 
    p.PlaylistId,
    p.Name,
    ROUND(SUM(t.Milliseconds) / 3600000, 2) AS LengthHours
FROM playlists p
JOIN playlist_track pt 
    ON p.PlaylistId = pt.PlaylistId
JOIN tracks t 
    ON pt.TrackId = t.TrackId
GROUP BY p.PlaylistId
HAVING SUM(t.Milliseconds) > 2 * 3600000
ORDER BY LengthHours DESC;