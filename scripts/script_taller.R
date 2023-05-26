
# Librerias ---------------------------------------------------------------

library(tidyverse)

# separate_* --------------------------------------------------------------

info_nombres <-
  tibble(nombres = c("maria-jose", "ema-paz", "sofia-ester"))

info_nombres %>% # version clasica
  separate(nombres,
           into = c("primer_nombre", "segundo_nombre"),
           sep = "-")

# Version mejoradas -------------------------------------------------------

## separate_*_delim()

info_nombres %>%
  separate_wider_delim(nombres,
                       names = c("primer_nombre", "segundo_nombre"),
                       delim = "-")

info_nombres %>%
  separate_longer_delim(nombres, delim = "-")

## separate_*_position()

# P = piso, D = departamento
info_deptos <- tibble(deptos = c("P3D2", "P4D6", "P4D1"))

info_deptos %>% 
  separate_wider_position(deptos, widths = c(piso = 2, numero = 2))

info_deptos %>% 
  separate_longer_position(deptos, width = 2)

# Unnesting ---------------------------------------------------------------

info_mascota <- tribble(
  ~mascota,  ~estado,  ~info,
  "gato", "sano",list(nombre = "isi", edad = 2, vacunas = c("a")),
  "gato", "enfermo", list(nombre = "oso", edad = 10, vacunas = c("a","b")),
  "perro","sano",list(nombre = "cuchi", edad = 6, vacunas = c("c"))
)

info_mascota

## Mejoras unnest_*() wide

info_mascota %>% 
  unnest_wider(info, names_sep = "_")

## Mejoras unnest_*() long

info_mascota %>% 
  unnest_longer(info)


# pivot_longer() ----------------------------------------------------------

mis_gatos <- tibble(nombre = c("cuchito", "minino", 
                               "bigotito"),
                    color = c("negro", "blanco",
                              "atigrado"),
                    "personalidad" = c("arisco","amoroso", "amoroso"))
mis_gatos


## pivot_longer() clasico

mis_gatos %>% 
  pivot_longer(everything(),
               names_to = "caracteristicas_gato",
               values_to = "caracteristica") 

## Mejora pivot_longer(), ordenado

mis_gatos %>% 
  pivot_longer(everything(),
               names_to = "caracteristicas_gato",
               values_to = "caracteristica",
               cols_vary = "slowest") 

# Mejora nest(.by) --------------------------------------------------------

## nest() clasico

info_mascota %>% 
  nest() # no es muy util

info_mascota %>% 
  group_by(mascota) %>% 
  nest() #asignamos el grupo antes


## Mejora nest: nest(.by)

info_mascota %>% 
  nest(.by = mascota) #agrupacion directa

info_mascota %>% 
  nest(.by = estado)

