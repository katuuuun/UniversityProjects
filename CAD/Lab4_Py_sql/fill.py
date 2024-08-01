# import sqlite3

# # создаем подключение к базе данных
# con = sqlite3.connect("myDB.db")
# cursor = con.cursor()

# # Удаляем таблицы, если они уже существуют
# cursor.execute("DROP TABLE IF EXISTS ПерсональныеКомпьютеры")
# cursor.execute("DROP TABLE IF EXISTS Организации")

# # Создаем таблицу "Организации"
# cursor.execute("""
#     CREATE TABLE Организации (
#         id INTEGER PRIMARY KEY,
#         Название TEXT,
#         Продавец TEXT,
#         ПоставщикДополнительныхКомплектующих TEXT
#     )
# """)

# # Добавляем данные в таблицу Организации
# organizations_data = [
#     ("ASUS", "ASUS Store", "ASUS"),
#     ("Lenovo", "Lenovo Store", "Lenovo"),
#     ("HP", "HP Store", "HP"),
#     ("Dell", "Dell Store", "Dell"),
#     ("Acer", "Acer Store", "Acer")
# ]
# cursor.executemany("INSERT INTO Организации (Название, Продавец, ПоставщикДополнительныхКомплектующих) VALUES (?, ?, ?)", organizations_data)

# # Создаем таблицу "ПерсональныеКомпьютеры" с внешним ключом на таблицу "Организации"
# cursor.execute("""
#     CREATE TABLE ПерсональныеКомпьютеры (
#         id INTEGER PRIMARY KEY,
#         Модель TEXT,
#         Цена INTEGER,
#         Производитель_id INTEGER,
#         FOREIGN KEY (Производитель_id) REFERENCES Организации(id)
#     )
# """)

# # Добавляем данные в таблицу ПерсональныеКомпьютеры
# computers_data = [
#     ("Геймерский", 2000, 1),
#     ("Офисный", 1000, 2),
#     ("Рабочая станция", 3000, 3),
#     ("Домашний ПК", 800, 4),
#     ("Мультимедийная станция", 1500, 5)
# ]
# cursor.executemany("INSERT INTO ПерсональныеКомпьютеры (Модель, Цена, Производитель_id) VALUES (?, ?, ?)", computers_data)

# # Фиксируем изменения и закрываем соединение
# con.commit()
# con.close()



import sqlite3

# создаем подключение
con = sqlite3.connect("myDB.db")

# получаем курсор
cursor = con.cursor()

# Добавляем данные в таблицу ПерсональныеКомпьютеры
computers_data = [
    ("Геймерский", "игровой", 1, 2000),
    ("Офисный", "офисный", 2, 1000),
    ("Рабочая станция", "рабочая станция", 3, 3000),
    ("Домашний ПК", "для дома", 4, 800),
    ("Мультимедийная станция", "мультимедийный", 5, 1500)
]
cursor.executemany("INSERT INTO ПерсональныеКомпьютеры (Модель, Назначение, ВариантКомплектации, Цена) VALUES (?, ?, ?, ?)", computers_data)

# Добавляем данные в таблицу Организации
organizations_data = [
    ("ASUS", "ASUS", "ASUS Store", "ASUS"),
    ("Lenovo", "Lenovo", "Lenovo Store", "Lenovo"),
    ("HP", "HP", "HP Store", "HP"),
    ("Dell", "Dell", "Dell Store", "Dell"),
    ("Acer", "Acer", "Acer Store", "Acer")
]
cursor.executemany("INSERT INTO Организации (Модель, Производитель, Продавец, ПоставщикДополнительныхКомплектующих) VALUES (?, ?, ?, ?)", organizations_data)

# Добавляем данные в таблицу Комплектация
configuration_data = [
    (1, "Intel Core i9", "Corsair Vengeance LPX", "Samsung 970 EVO", "NVIDIA GeForce RTX 3080", "ASUS ROG Strix XG279Q", "TP-Link TG-3468", "Logitech Z906", "Creative Sound Blaster AE-9", "ASUS BC-12D2HT", "Logitech G Pro"),
    (2, "Intel Core i5", "Kingston HyperX Fury", "Seagate Barracuda", "AMD Radeon RX 560", "Dell P2419H", "NETGEAR GA311", "Bose Companion 2 Series III", "Realtek ALC892", "LG GH24NSC0B", "Microsoft Basic Optical Mouse"),
    (3, "AMD Ryzen 9", "Crucial Ballistix", "Western Digital WD Black", "NVIDIA Quadro RTX 6000", "HP Z27", "Intel I210-T1", "Edifier R1280DB", "Creative Sound Blaster Z", "HP DVD600s", "HP Mouse 100"),
    (4, "Intel Core i3", "ADATA XPG", "Toshiba X300", "Intel UHD Graphics 630", "Acer R240HY", "ASUS XG-C100C", "JBL Professional 305P MkII", "Realtek ALC887", "ASUS SDRW-08U7M-U", "Acer Mouse"),
    (5, "AMD Ryzen 7", "G.Skill Ripjaws V", "Crucial BX500", "AMD Radeon RX 580", "Lenovo L24q", "TP-Link Archer T6E", "Harman Kardon SoundSticks III", "ASUS Xonar AE", "LG GP65NB60", "HP Wireless Mouse 220")
]
cursor.executemany("INSERT INTO Комплектация (ВариантКомплектации, МодельПроцессора, МодельОперативнойПамяти, МодельЖесткогоДиска, МодельВидеокарты, МодельМонитора, МодельСетевойКарты, МодельМультимедийныхКолонок, МодельЗвуковойКарты, МодельDVD_RW_привода, МодельМыши) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", configuration_data)

# Добавляем данные в таблицу ОперативнаяПамять
ram_data = [
    ("Corsair Vengeance LPX", 16, 8, "DDR4"),
    ("Kingston HyperX Fury", 8, 4, "DDR4"),
    ("Crucial Ballistix", 32, 16, "DDR4"),
    ("ADATA XPG", 4, 4, "DDR4"),
    ("G.Skill Ripjaws V", 16, 8, "DDR4")
]
cursor.executemany("INSERT INTO ОперативнаяПамять (Модель, Объем, КоличествоМикросхем, Тип) VALUES (?, ?, ?, ?)", ram_data)

# Добавляем данные в таблицу Мыши
mice_data = [
    ("Logitech G102", "Logitech", "оптическая", "проводная", 5),
    ("Microsoft Basic Optical Mouse", "Microsoft", "обычная", "проводная", 3),
    ("HP Mouse 100", "HP", "оптическая", "проводная", 2),
    ("Acer Mouse", "Acer", "обычная", "проводная", 3),
    ("HP Wireless Mouse 220", "HP", "оптическая", "беспроводная", 2)
]
cursor.executemany("INSERT INTO Мыши (Модель, Производитель, Тип, Вид, КоличествоКнопок) VALUES (?, ?, ?, ?, ?)", mice_data)

con.commit()

con.close()