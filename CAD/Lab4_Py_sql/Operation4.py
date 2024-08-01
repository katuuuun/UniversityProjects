# 4) Используя SQL отобрать все компьютеры, производимых (...) организацией
import sqlite3

# создаем подключение к базе данных
con = sqlite3.connect("myDB.db")
cursor = con.cursor()

# Выбираем организацию напрямую
selected_manufacturer = "Acer"  # выбираем нужную организацию

# Выполняем SQL-запрос для выбора всех компьютеров, производимых указанной организацией
cursor.execute(f"""
    SELECT Модель
    FROM ПерсональныеКомпьютеры
    WHERE Производитель_id IN (
        SELECT id
        FROM Организации
        WHERE Название = ?
    )
""", (selected_manufacturer,))

# Получаем результаты запроса
computers = cursor.fetchall()

# Выводим результаты запроса
print(f"\nКомпьютеры, производимые организацией {selected_manufacturer}:")
for computer in computers:
    print(computer[0])

con.close()
