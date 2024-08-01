# 5) Используя SQL запрос, выводящий число компьютеров с (...) комплектацией (группировка)

import sqlite3

# Создаем подключение к базе данных
con = sqlite3.connect("myDB.db")
cursor = con.cursor()

# Комплектация, которую мы хотим подсчитать
selected_configuration = "2"

# Выполняем SQL-запрос для подсчета числа компьютеров с выбранной комплектацией
cursor.execute(f"""
    SELECT COUNT(*)
    FROM Комплектация
    WHERE ВариантКомплектации = ?
""", (selected_configuration,))

# Получаем результат запроса
count = cursor.fetchone()[0]

# Выводим результат запроса
print(f"\nЧисло компьютеров с комплектацией '{selected_configuration}': {count}")

# Закрываем подключение
con.close()
