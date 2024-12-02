##OLA 4 Opgave 2##

#Opgave 2.1 - Lad R driverende gøre arbejdet med at trække skemaet fra SQL i R
#Forbind til SQL databasen 
##MariaDB#
library(RMariaDB)

#Jeg har apply et schema i SQL, som jeg så vi dbConnect, kan få ind i R.
connw <- dbConnect(MariaDB(),
                   db = "Bilbasentest",
                   host = "localhost",
                   port = 3306,
                   user = "root",
                   password = "Password")


##########################
dbListTables(connw)
dbWriteTable(connw, "SabineTest", OLA4_Opgave_1)
sdvw_dfprøve2 <- as.data.frame(sdvw_dfprøve2)
dbWriteTable(connw, "SabineTestSimuleret", sdvw_dfprøve2)


#Jeg kan select og tage "select" fra SQL og kører det i R. Så kommer det ned i res
#og så kan jeg vise res i R

mq <- "select Carid from SabineTest"
res <- dbGetQuery(connw, mq)

###########Vores endelige kode############
#Jeg har apply et schema i SQL, som jeg så vi dbConnect, kan få ind i R.
connw <- dbConnect(MariaDB(),
                   db = "bilbasentest",
                   host = "localhost",
                   port = 3306,
                   user = "root",
                   password = "Password")


##########################
dbListTables(connw)
#Gem oprindelig data
OLA4_Opgave_1 <- as.data.frame(OLA4_Opgave_1)
dbWriteTable(connw, "Bilbasentest", OLA4_Opgave_1)
#Gem simuleret data
sdvw_dfprøve2 <- as.data.frame(sdvw_dfprøve2)
dbWriteTable(connw, "BilbasentestSim", sdvw_dfprøve2)


#Jeg kan select og tage "select" fra SQL og kører det i R. Så kommer det ned i res
#og så kan jeg vise res i R

#Se resultatet af solgte biler i R#
query_solgt <- "
SELECT og.*
FROM Bilbasentest og
LEFT JOIN BilbasentestSim sim
ON og.CarID = sim.CarID
WHERE sim.CarID IS NULL;
"

# Udfør forespørgslen og gem resultatet som en data frame
solgte_biler <- dbGetQuery(connw, query_solgt)

# Se resultatet
print(solgte_biler)

summary(solgte_biler)
##############################
#Se resultaterne af biler med nye priser
query_nye_priser <- "
SELECT og.*
FROM Bilbasentest og
INNER JOIN BilbasentestSim sim
ON sim.Carid = og.Carid;
"

# Hent data fra SQL og gem resultatet i en data frame
nye_priser <- dbGetQuery(connw, query_nye_priser)

# Se resultatet i R
print(nye_priser)
View(nye_priser)  # Åbn resultatet i en visuel tabel i RStudio
