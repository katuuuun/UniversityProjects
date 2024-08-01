# 7) Используя SQL добавить (удалить) поля в табл. “Мыши” (запрос на добавление/удаление). При
# добавлении использовать дополнительную таблицу с такими же полями
import sqlite3

# Создаем подключение к базе данных
con = sqlite3.connect("myDB.db")
cursor = con.cursor()

# Выполняем запрос на удаление поля из таблицы "Мыши"
cursor.execute("""
    CREATE TABLE IF NOT EXISTS Мыши_temp (
        Модель TEXT,
        Производитель TEXT
    )
""")

cursor.execute("""
    INSERT INTO Мыши_temp SELECT Модель, Производитель FROM Мыши
""")

cursor.execute("""
    DROP TABLE Мыши
""")

cursor.execute("""
    ALTER TABLE Мыши_temp RENAME TO Мыши
""")

# Сохраняем изменения
con.commit()

# Закрываем подключение
con.close()
