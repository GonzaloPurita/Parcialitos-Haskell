data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

hab1 :: Habilidad
hab1 = Habilidad{fuerzaJugador=10, precisionJugador=25}

bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
-- between n m x = elem x [n .. m]

-- maximoSegun f = foldl1 (mayorSegun f)
-- mayorSegun f a b
--   | f a > f b = a
--   | otherwise = b

type Palo = Habilidad -> Tiro

putter :: Palo
putter habilidad = UnTiro{velocidad = 10, precision = precisionJugador habilidad * 2, altura = 0}
madera :: Palo
madera habilidad = UnTiro{velocidad = 100, precision = precisionJugador habilidad `div` 2, altura = 5}
hierro :: Int -> Palo
hierro n habilidad = UnTiro{velocidad = fuerzaJugador habilidad * n, precision = precisionJugador habilidad `div` n, altura = cambioAltura n}

cambioAltura :: Int -> Int
cambioAltura n
            | n < 3 = 0
            | otherwise = n-3

palos :: [Palo]
palos = [putter, madera, hierro 1, hierro 2, hierro 3, hierro 4, hierro 5, hierro 6, hierro 7, hierro 8, hierro 9, hierro 10]

golpe :: Jugador -> Palo -> Tiro
golpe player palo = (palo.habilidad) player

type Obstaculo = Tiro -> Bool

tiro1 :: Tiro
tiro1 = UnTiro 100 50 6

tunel :: Obstaculo
tunel tiro = precision tiro > 90 && altura tiro == 0
laguna :: Obstaculo
laguna tiro = velocidad tiro > 80 && altura tiro `elem` [1,2,3,4,5]
hoyo :: Obstaculo
hoyo tiro = velocidad tiro `elem` [5 .. 20] && altura tiro == 0 && precision tiro > 95

superarTunel :: Tiro -> Tiro
superarTunel tiro
            | tunel tiro = UnTiro (velocidad tiro *2) 100 0
            | otherwise = UnTiro 0 0 0 

superarLaguna :: Tiro -> Int -> Tiro
superarLaguna tiro largo
                    | laguna tiro = tiro{altura = altura tiro `div` largo}
                    | otherwise = UnTiro 0 0 0 

superarHoyo :: Tiro -> Tiro
superarHoyo tiro = tiro{velocidad=0, precision=0, altura=0}






