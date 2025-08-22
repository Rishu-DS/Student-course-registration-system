import psycopg2

conn = psycopg2.connect(
    dbname="student_registration", user="yourusername", password="yourpassword", host="localhost"
)
cur = conn.cursor()
cur.execute("""
SELECT c.course_name, COUNT(r.student_id) as num_students
FROM Courses c
LEFT JOIN Registrations r ON c.course_id = r.course_id
GROUP BY c.course_id, c.course_name;
""")
result = cur.fetchall()
for row in result:
    print(row)
cur.close()
conn.close()