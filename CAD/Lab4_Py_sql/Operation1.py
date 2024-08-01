# 1) Используя SQL-инструкции SELECT, FROM, WHERE отобрать все 
# компьютеры в диапазоне цен
# от (...) до (...) (SQL-запрос)
import sqlite3

# создаем подключение
con = sqlite3.connect("myDB.db")
cursor = con.cursor()

# Выполняем SQL-запрос
cursor.execute("""
    SELECT *
    FROM ПерсональныеКомпьютеры
    WHERE Цена BETWEEN 1000 AND 2000
""")

# Получаем результаты запроса
data = cursor.fetchall()

# Выводим результаты запроса
for text in data:
    print(text)

# закрываем подключение
con.close()
