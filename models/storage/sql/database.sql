CREATE DATABASE IF NOT EXISTS elite_tech;

USE elite_tech;

CREATE TABLE IF NOT EXISTS `type` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50) NOT NULL
);

INSERT INTO `type` (type) VALUES
('user'),
('purchase'),
('purchaseItem'),
('productRating'),
('case'),
('cpu'),
('cooler'),
('gpu'),
('ram'),
('storage'),
('motherboard'),
('powersupply'),
('monitor'),
('mice'),
('keyboard'),
('headphone');

CREATE TABLE IF NOT EXISTS `case` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    type VARCHAR(50),
    color VARCHAR(50),
    powerSupply VARCHAR(50),
    sidePanel VARCHAR(50),
    externalVolume VARCHAR(20),
    internalBays INT,
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `cpu` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    coreCount INT,
    performanceCoreClock VARCHAR(50),
    performanceBoostClock VARCHAR(50),
    tdp VARCHAR(50),
    integratedGraphics VARCHAR(50),
    smt VARCHAR(3),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `cooler` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    fanRPM VARCHAR(50),
    noiseLevel VARCHAR(50),
    color VARCHAR(50),
    radiatorSize VARCHAR(50),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `gpu` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    chipset VARCHAR(50),
    memory VARCHAR(30),
    coreClock VARCHAR(50),
    boostClock VARCHAR(50),
    color VARCHAR(50),
    length VARCHAR(30),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `headphone` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    type VARCHAR(50),
    frequencyResponse VARCHAR(30),
    microphone VARCHAR(3),
    wireless VARCHAR(3),
    enclosureType VARCHAR(30),
    color VARCHAR(50),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `keyboard` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    style VARCHAR(50),
    switchType VARCHAR(50),
    backlit VARCHAR(50),
    tenkeyless VARCHAR(3),
    connectionType VARCHAR(50),
    color VARCHAR(50),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `mice` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    trackingMethod VARCHAR(50),
    connectionType VARCHAR(50),
    maximumDPI INT,
    handOrientation VARCHAR(50),
    color VARCHAR(50),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `monitor` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    screenSize VARCHAR(30),
    resolution VARCHAR(30),
    refreshRate VARCHAR(20),
    responseTimeG2G VARCHAR(25),
    panelType VARCHAR(50),
    aspectRatio VARCHAR(30),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `motherboard` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    socketCPU VARCHAR(50),
    formFactor VARCHAR(50),
    memoryMax VARCHAR(30),
    memorySlots INT,
    color VARCHAR(50),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `powersupply` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    type VARCHAR(50),
    efficiencyRate VARCHAR(20),
    wattage VARCHAR(30),
    modular VARCHAR(30),
    color VARCHAR(50),
    rating DECIMAL(5, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `ram` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    speed VARCHAR(35),
    modules VARCHAR(35),
    pricePerGB DECIMAL(5, 3),
    color VARCHAR(50),
    firstWordLatency VARCHAR(20),
    casLatency INT,
    rating DECIMAL(5, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `storage` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    imageURL VARCHAR(255),
    name VARCHAR(255),
    capacity VARCHAR(35),
    pricePerGB DECIMAL(5, 3),
    type VARCHAR(50),
    cache VARCHAR(20),
    formFactor VARCHAR(20),
    interface VARCHAR(20),
    rating DECIMAL(2, 1) DEFAULT 0.0,
    price DECIMAL(10, 2),
    manufacturer VARCHAR(255),
    stock INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS `user` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `purchase` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    purchaseDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    totalAmount DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (userID) REFERENCES user(id)
);

CREATE TABLE IF NOT EXISTS `purchaseItem` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    purchaseID INT NOT NULL,
    productID INT NOT NULL,
    type INT NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (purchaseID) REFERENCES purchase(id),
    FOREIGN KEY (type) REFERENCES type(id)
);

CREATE TABLE IF NOT EXISTS `productRating` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    productID INT NOT NULL,
    type INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL,
    FOREIGN KEY (userID) REFERENCES user(id),
    FOREIGN KEY (type) REFERENCES type(id)
);
