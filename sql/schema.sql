PRAGMA foreign_keys = ON;

CREATE TABLE Units (
        uid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        Name TEXT,
        Position INTEGER
);

CREATE TABLE Aisles (
        uid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        Name TEXT,
        Color TEXT,
        Icon TEXT,
        Position INTEGER
);

CREATE TABLE Groceries (
        uid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        Name TEXT,
        Note TEXT,
        LastUsed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        AisleID INTEGER,
        UnitID INTEGER,
        FOREIGN KEY(AisleID) REFERENCES Aisles(uid),
        FOREIGN KEY(UnitID) REFERENCES Units(uid)
);

CREATE TABLE Lists (
        uid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
        Name TEXT,
        Position INTEGER 
);

CREATE TABLE GroceriesLists (
        Position INTEGER,
        ListID INTEGER,
        ProductID INTEGER,
        FOREIGN KEY(ListID) REFERENCES Lists(uid),
        FOREIGN KEY(ProductID) REFERENCES Groceries(uid)
);

CREATE TABLE InternalInformation (
        Version TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
