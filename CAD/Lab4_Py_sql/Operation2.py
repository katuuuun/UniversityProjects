#2) Используя SQL-инструкцию CREATE TABLE cоздать новую таблицу с именем “Таблица” c
#полями “Компьютер”, “Модель”, “Цена”
import sqlite3

# создаем подключение
con = sqlite3.connect("operation2.db")
cursor = con.cursor()

# Создаем новую таблицу, если она не существует
cursor.execute("""
    CREATE TABLE IF NOT EXISTS Таблица (
        Компьютер INTEGER PRIMARY KEY AUTOINCREMENT,
        Модель TEXT,
        Цена INTEGER
    )
""")

# сохраняем изменения
con.commit()

# закрываем подключение
con.close()
