#Simple Queries# 
#Querie 1#
SELECT model_name, year
FROM vehicle_model
ORDER BY year DESC;

#Querie 2#
SELECT part_name, category, price
FROM part
WHERE price < 15000
ORDER BY price ASC;

#Medium Queries#
#Querie 3#
SELECT vm.model_name, m.name AS manufacturer_name, m.country, vm.year
FROM vehicle_model vm
INNER JOIN manufacturer m ON vm.manufacturer_id = m.manufacturer_id;

#Querie 4#
SELECT category, COUNT(part_id) AS total_parts, AVG(price) AS average_price
FROM part
GROUP BY category;

#Querie 5#
SELECT part_name, brand, price
FROM part
WHERE part_name LIKE '%AMG%' OR part_name LIKE '%Suspension%';

#Querie 6#
SELECT part_name, brand, price
FROM part
WHERE price > (SELECT AVG(price) FROM part)
ORDER BY price DESC;

#Complex Queries#
#Querie 7#
SELECT m.name AS manufacturer_name, AVG(ps.perf_rating) AS avg_perf_rating
FROM manufacturer m
JOIN vehicle_model vm ON m.manufacturer_id = vm.manufacturer_id
JOIN performance_spec ps ON vm.model_id = ps.model_id
GROUP BY m.name
HAVING AVG(ps.perf_rating) > 200;

#Querie 8#
SELECT DISTINCT p.part_name, p.category, p.price
FROM part p
JOIN model_part mp ON p.part_id = mp.part_id
WHERE mp.model_id IN (
    SELECT vm.model_id
    FROM vehicle_model vm
    JOIN manufacturer m ON vm.manufacturer_id = m.manufacturer_id
    WHERE m.name = 'Mercedes-Benz'
);

#Querie 9#
SELECT vm.model_name, COUNT(mp.part_id) AS compatible_parts_count
FROM vehicle_model vm
LEFT JOIN model_part mp ON vm.model_id = mp.model_id
GROUP BY vm.model_id, vm.model_name
HAVING COUNT(mp.part_id) >= 1
ORDER BY compatible_parts_count DESC;

#Querie 10#
SELECT m.model_name, s.perf_rating,
       s.perf_rating + SUM(COALESCE(mp.rating_modifier, 0)) AS tuned_rating
FROM vehicle_model m
JOIN performance_spec s ON m.model_id = s.model_id
LEFT JOIN model_part mp ON m.model_id = mp.model_id
GROUP BY m.model_id, m.model_name, s.perf_rating
ORDER BY tuned_rating DESC;
