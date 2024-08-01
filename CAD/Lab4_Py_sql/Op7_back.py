import sqlite3

con = sqlite3.connect("myDB.db")
cursor = con.cursor()

# Создаем таблицу "Мыши", если её нет
cursor.execute("""
    CREATE TABLE IF NOT EXISTS Мыши (
        Модель TEXT,
        Производитель TEXT,
        Тип TEXT,
        Вид TEXT,
        КоличествоКнопок INTEGER
    )
""")

mice_data = [
    ("Logitech G102", "Logitech", "оптическая", "проводная", 5),
    ("Microsoft Basic Optical Mouse", "Microsoft", "обычная", "проводная", 3),
    ("HP Mouse 100", "HP", "оптическая", "проводная", 2),
    ("Acer Mouse", "Acer", "обычная", "проводная", 3),
    ("HP Wireless Mouse 220", "HP", "оптическая", "беспроводная", 2)
]

# Вставляем данные в таблицу "Мыши"
cursor.executemany("INSERT INTO Мыши (Модель, Производитель, Тип, Вид, КоличествоКнопок) VALUES (?, ?, ?, ?, ?)", mice_data)

# Сохраняем изменения
con.commit()

# Закрываем подключение
con.close()

