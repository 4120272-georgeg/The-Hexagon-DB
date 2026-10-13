
# Import os to read the database connection settings.
import os

# Import mysql.connector to connect Python to MySQL.
import mysql.connector

# Import Error to handle MySQL errors.
from mysql.connector import Error


# Function to connect to the database and run the queries.
def run_queries():

    connection = None
    cursor = None

    try:
        # Connect to the existing CSC312_DB database.
        connection = mysql.connector.connect(
            host=os.getenv("MYSQL_HOST", "172.21.12.21"),
            port=int(os.getenv("MYSQL_PORT", "25927")),
            user=os.getenv("MYSQL_USER", "4145927"),
            password=os.getenv("MYSQL_PASSWORD", "!St4145927"),
            database=os.getenv("MYSQL_DATABASE", "CSC312_DB")
        )

        # Check whether the connection was successful.
        if connection.is_connected():
            print("Connected to CSC312_DB successfully!")

            # Create a cursor to execute SQL commands.
            cursor = connection.cursor()


            # QUERY 1: Display vehicle models by year. (Newer vehicle years appear first.)

            print("\nQUERY 1: Vehicle Models by Year")

            query1 = """
                SELECT model_name, year
                FROM vehicle_model
                ORDER BY year DESC;
            """

            # Execute Query 1 in MySQL.
            cursor.execute(query1)

            # Retrieve all rows returned by the query.
            results = cursor.fetchall()

            # Display the column headings.
            print("Model Name | Year")

            # Display each vehicle model and its year.
            for row in results:
                print(row[0], "|", row[1])


            # QUERY 2: Display affordable parts. (Only parts priced below 15000 are shown.)
            # WHERE filters the parts by price.
            # ORDER BY ASC lists the cheapest parts first.

            print("\nQUERY 2: Parts Priced Below 15000")

            query2 = """
                SELECT part_name, category, price
                FROM part
                WHERE price < 15000
                ORDER BY price ASC;
            """

            # Execute Query 2.
            cursor.execute(query2)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Part Name | Category | Price")

            # Print each affordable part.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])


            # QUERY 3: Display vehicle models and manufacturers.(INNER JOIN connects each model to its manufacturer.)

            print("\nQUERY 3: Vehicle Models and Manufacturers")

            query3 = """
                SELECT
                    vm.model_name,
                    m.name AS manufacturer_name,
                    m.country,
                    vm.year
                FROM vehicle_model vm
                INNER JOIN manufacturer m
                    ON vm.manufacturer_id = m.manufacturer_id;
            """

            # Execute Query 3.
            cursor.execute(query3)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Model | Manufacturer | Country | Year")

            # Print each model with its manufacturer details.
            for row in results:
                print(row[0], "|", row[1], "|", row[2], "|", row[3])


            # QUERY 4: Summarize parts by category.
            # COUNT calculates the number of parts.
            # AVG calculates the average price per category.
            # GROUP BY groups parts with the same category.
            print("\nQUERY 4: Parts by Category")

            query4 = """
                SELECT
                    category,
                    COUNT(part_id) AS total_parts,
                    AVG(price) AS average_price
                FROM part
                GROUP BY category;
            """

            # Execute Query 4.
            cursor.execute(query4)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Category | Total Parts | Average Price")

            # Print each category, its part count and average price.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])


            # QUERY 5: Search for parts by name.
            # LIKE with % finds names containing the given text.
            # OR returns parts matching either AMG or Suspension.
            print("\nQUERY 5: Parts Matching AMG or Suspension")

            query5 = """
                SELECT part_name, brand, price
                FROM part
                WHERE part_name LIKE '%AMG%'
                    OR part_name LIKE '%Suspension%';
            """

            # Execute Query 5.
            cursor.execute(query5)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Part Name | Brand | Price")

            # Print each matching part.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])


            # QUERY 6: Find parts priced above the average.
            # The subquery calculates the average price of all parts.
            # The outer query returns parts that cost more than that average.
            # ORDER BY DESC lists the most expensive parts first.
            print("\nQUERY 6: Parts Priced Above Average")

            query6 = """
                SELECT part_name, brand, price
                FROM part
                WHERE price > (
                    SELECT AVG(price)
                    FROM part
                )
                ORDER BY price DESC;
            """

            # Execute Query 6.
            cursor.execute(query6)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Part Name | Brand | Price")

            # Print each above-average part.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])


            # QUERY 7: Find manufacturers with a high average performance rating.
            # JOIN connects manufacturers, models and performance specifications.
            # AVG calculates the average rating per manufacturer.
            # HAVING keeps only manufacturers with an average above 200.
            print("\nQUERY 7: Manufacturers with Average Rating Above 200")

            query7 = """
                SELECT
                    m.name AS manufacturer_name,
                    AVG(ps.perf_rating) AS avg_perf_rating
                FROM manufacturer m
                JOIN vehicle_model vm
                    ON m.manufacturer_id = vm.manufacturer_id
                JOIN performance_spec ps
                    ON vm.model_id = ps.model_id
                GROUP BY m.name
                HAVING AVG(ps.perf_rating) > 200;
            """

            # Execute Query 7.
            cursor.execute(query7)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Manufacturer | Average Performance Rating")

            # Print each manufacturer and its average rating.
            for row in results:
                print(row[0], "|", row[1])


            # QUERY 8: Find parts compatible with Mercedes-Benz.
            # The subquery finds Mercedes-Benz vehicle model IDs.
            # The outer query returns their compatible parts.
            # DISTINCT removes duplicate part records.
            print("\nQUERY 8: Mercedes-Benz Compatible Parts")

            query8 = """
                SELECT DISTINCT
                    p.part_name,
                    p.category,
                    p.price
                FROM part p
                JOIN model_part mp
                    ON p.part_id = mp.part_id
                WHERE mp.model_id IN (
                    SELECT vm.model_id
                    FROM vehicle_model vm
                    JOIN manufacturer m
                        ON vm.manufacturer_id = m.manufacturer_id
                    WHERE m.name = 'Mercedes-Benz'
                );
            """

            # Execute Query 8.
            cursor.execute(query8)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Part Name | Category | Price")

            # Print each compatible part.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])


            # QUERY 9: Count compatible parts for each vehicle model.
            # LEFT JOIN keeps every model, even if it has no parts.
            # COUNT calculates the number of compatible parts per model.
            # HAVING keeps only models with at least one compatible part.
            print("\nQUERY 9: Compatible Parts per Model")

            query9 = """
                SELECT
                    vm.model_name,
                    COUNT(mp.part_id) AS compatible_parts_count
                FROM vehicle_model vm
                LEFT JOIN model_part mp
                    ON vm.model_id = mp.model_id
                GROUP BY
                    vm.model_id,
                    vm.model_name
                HAVING COUNT(mp.part_id) >= 1
                ORDER BY compatible_parts_count DESC;
            """

            # Execute Query 9.
            cursor.execute(query9)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Model | Compatible Parts")

            # Print each model and its number of compatible parts.
            for row in results:
                print(row[0], "|", row[1])


            # QUERY 10: Calculate tuned performance ratings.
            # COALESCE replaces missing modifiers with zero.
            # SUM adds the modifiers of compatible parts.
            # The total is added to the original performance rating.

            print("\nQUERY 10: Tuned Performance Ratings")

            query10 = """
                SELECT
                    m.model_name,
                    s.perf_rating,
                    s.perf_rating
                        + SUM(COALESCE(mp.rating_modifier, 0))
                        AS tuned_rating
                FROM vehicle_model m
                JOIN performance_spec s
                    ON m.model_id = s.model_id
                LEFT JOIN model_part mp
                    ON m.model_id = mp.model_id
                GROUP BY
                    m.model_id,
                    m.model_name,
                    s.perf_rating
                ORDER BY tuned_rating DESC;
            """

            # Execute Query 10.
            cursor.execute(query10)

            # Retrieve the query results.
            results = cursor.fetchall()

            # Display the column headings.
            print("Model | Original Rating | Tuned Rating")

            # Print each model and its calculated ratings.
            for row in results:
                print(row[0], "|", row[1], "|", row[2])

    except Error as error:
        # Display any connection or SQL execution error.
        print("An error occurred:", error)

    finally:
        # Close the cursor if it was created.
        if cursor is not None:
            cursor.close()

        # Close the database connection if it was opened.
        if connection is not None and connection.is_connected():
            connection.close()
            print("\nDatabase connection closed.")


# Start the program when main.py is run directly.
if __name__ == "__main__":
    run_queries()
