--What are the names of each album and the artist who created it?

SELECT 
    al.Title AS AlbumName,
    ar.Name AS ArtistName
FROM albums al
JOIN artists ar 
ON al.ArtistId = ar.ArtistId
ORDER BY ar.Name;