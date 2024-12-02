CREATE DATABASE Bilbasentest;
CREATE TABLE vw_cars (
    car_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(100),
    details TEXT,
    description TEXT,
    location VARCHAR(100),
    dealer_id INT,
    dealer_name VARCHAR(100),
    dealer_address TEXT,
    dealer_cvr VARCHAR(20),
    car_link TEXT
);

CREATE TABLE vw_prices (
    price_id INT PRIMARY KEY AUTO_INCREMENT,
    car_id INT,
    price DECIMAL(10, 2),
    date DATE NOT NULL,
    sold BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (car_id) REFERENCES vw_cars(car_id)
);


----------------------------------
-- Solgte:
SELECT *
FROM Bilbasentest.Bilbasentest og
LEFT JOIN Bilbasentest.Bilbasentestsim sim ON sim.Carid = og.Carid
WHERE sim.Carid IS NULL;

-- Nye priser:
SELECT * 
FROM Bilbasentest.Bilbasentest og
INNER JOIN Bilbasentest.BilbasentestSim sim ON sim.Carid = og.Carid;

-- Nye:
SELECT *
FROM Bilbasentest.Bilbasentest sim
LEFT JOIN Bilbasentest.Bilbasentest og
ON sim.Carid = og.Carid
WHERE og.Carid IS NULL;

-- Sæt solgte bileder som TRUE
SELECT COUNT(*) AS unsold_cars
FROM Bilbasentest b
LEFT JOIN BilbasentestSim s
ON b.carid = s.carid
WHERE s.carid IS NULL;


-- Prøver at connecter relationerne imellem tabellerne
ALTER TABLE vw_prices
ADD CONSTRAINT fk_car_id
FOREIGN KEY (car_id)
REFERENCES vw_cars(car_id);
