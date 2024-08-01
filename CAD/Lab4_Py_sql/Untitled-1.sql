
CREATE TABLE IF NOT EXISTS Персональные_Компьютеры (
    Модель TEXT PRIMARY KEY,
    Назначение TEXT,
    Вариант_Комплектации INTEGER,
    Цена REAL
);


CREATE TABLE IF NOT EXISTS Организации (
    Модель TEXT PRIMARY KEY,
    Производитель TEXT,
    Продавец TEXT,
    Поставщик_дополнительных_комплектующих TEXT
);


CREATE TABLE IF NOT EXISTS Комплектация (
    Вариант_Комплектации INTEGER PRIMARY KEY,
    Процессор TEXT,
    Оперативная_память TEXT,
    Жесткий_диск TEXT,
    Видеокарта TEXT,
    Монитор TEXT,
    Сетевая_карта TEXT,
    Мультимедийные_колонки TEXT,
    Звуковая_карта TEXT,
    DVD_RW_привод TEXT,
    Мышь TEXT,
    FOREIGN KEY (Вариант_Комплектации) REFERENCES Персональные_Компьютеры(Вариант_Комплектации)
);


CREATE TABLE IF NOT EXISTS Оперативная_память (
    Модель TEXT PRIMARY KEY,
    Объём INTEGER,
    Количество_микросхем INTEGER CHECK (Количество_микросхем IN (4, 8, 16)),
    Тип TEXT CHECK (Тип IN ('SDRAM', 'DDR'))
);


CREATE TABLE IF NOT EXISTS Мыши (
    Модель TEXT PRIMARY KEY,
    Производитель TEXT,
    Тип TEXT CHECK (Тип IN ('обычная', 'оптическая')),
    Вид TEXT CHECK (Вид IN ('обычная', 'беспроводная')),
    Количество_кнопок INTEGER
);