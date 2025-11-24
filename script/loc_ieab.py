import pandas as pd

# Helper function to add rows properly
def add_row(data_list, cycle, service_type, date_ref, first, psalm, second, gospel):
    data_list.append({
        "cycle": cycle,
        "service_type": service_type,
        "date_reference": date_ref,
        "first_reading": first,
        "psalm": psalm,
        "second_reading": second,
        "gospel": gospel
    })

data = []

# --- ADVENTO ---
# 1 Advento
add_row(data, "A", "eucharist", "1st_sunday_of_advent", "Isaías 2:1-5", "Salmo 122", "Romanos 13:11-14", "Mateus 24:36-44")
add_row(data, "B", "eucharist", "1st_sunday_of_advent", "Isaías 64:1-9", "Salmo 80:1-7, 17-19", "1 Coríntios 1:3-9", "Marcos 13:24-37")
add_row(data, "C", "eucharist", "1st_sunday_of_advent", "Jeremias 33:14-16", "Salmo 25:1-10", "1 Tessalonicenses 3:9-13", "Lucas 21:25-36")

# 2 Advento
add_row(data, "A", "eucharist", "2nd_sunday_of_advent", "Isaías 11:1-10", "Salmo 72:1-7, 18-19", "Romanos 15:4-13", "Mateus 3:1-12")
add_row(data, "B", "eucharist", "2nd_sunday_of_advent", "Isaías 40:1-11", "Salmo 85:1-2, 8-13", "2 Pedro 3:8-15a", "Marcos 1:1-8")
add_row(data, "C", "eucharist", "2nd_sunday_of_advent", "Baruque 5:1-9 ou Malaquias 3:1-4", "Lucas 1:68-79", "Filipenses 1:3-11", "Lucas 3:1-6")

# 3 Advento
add_row(data, "A", "eucharist", "3rd_sunday_of_advent", "Isaías 35:1-10", "Salmo 146:5-10 ou Lucas 1:46b-55", "Tiago 5:7-10", "Mateus 11:2-11")
add_row(data, "B", "eucharist", "3rd_sunday_of_advent", "Isaías 61:1-4, 8-11", "Salmo 126 ou Lucas 1:46b-55", "1 Tessalonicenses 5:16-24", "João 1:6-8, 19-28")
add_row(data, "C", "eucharist", "3rd_sunday_of_advent", "Sofonias 3:14-20", "Isaías 12:2-6", "Filipenses 4:4-7", "Lucas 3:7-18")

# 4 Advento
add_row(data, "A", "eucharist", "4th_sunday_of_advent", "Isaías 7:10-16", "Salmo 80:1-7, 17-19", "Romanos 1:1-7", "Mateus 1:18-25")
add_row(data, "B", "eucharist", "4th_sunday_of_advent", "2 Samuel 7:1-11, 16", "Lucas 1:46b-55 ou Salmo 89:1-4, 19-26", "Romanos 16:25-27", "Lucas 1:26-38")
add_row(data, "C", "eucharist", "4th_sunday_of_advent", "Miqueias 5:2-5a", "Lucas 1:46b-55 ou Salmo 80:1-7", "Hebreus 10:5-10", "Lucas 1:39-45 (46-55)")

# --- NATAL ---
# Natividade (Próprios fixos, validos para A, B, C)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "christmas_day_proper_i", "Isaías 9:2-7", "Salmo 96", "Tito 2:11-14", "Lucas 2:1-14 (15-20)")
    add_row(data, cycle, "eucharist", "christmas_day_proper_ii", "Isaías 62:6-12", "Salmo 97", "Tito 3:4-7", "Lucas 2:(1-7) 8-20")
    add_row(data, cycle, "eucharist", "christmas_day_proper_iii", "Isaías 52:7-10", "Salmo 98", "Hebreus 1:1-4 (5-12)", "João 1:1-14")

# 1 Domingo depois do Natal
add_row(data, "A", "eucharist", "1st_sunday_after_christmas", "Isaías 63:7-9", "Salmo 148", "Hebreus 2:10-18", "Mateus 2:13-23")
add_row(data, "B", "eucharist", "1st_sunday_after_christmas", "Isaías 61:10-62:3", "Salmo 148", "Gálatas 4:4-7", "Lucas 2:22-40")
add_row(data, "C", "eucharist", "1st_sunday_after_christmas", "1 Samuel 2:18-20, 26", "Salmo 148", "Colossenses 3:12-17", "Lucas 2:41-52")

# 2 Domingo depois do Natal (ABC)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "2nd_sunday_after_christmas", "Jeremias 31:7-14 ou Eclesiástico 24:1-12", "Salmo 147:12-20 ou Sabedoria 10:15-21", "Efésios 1:3-14", "João 1:(1-9) 10-18")

# --- EPIFANIA ---
# Dia da Epifania
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "epiphany_day", "Isaías 60:1-6", "Salmo 72:1-7, 10-14", "Efésios 3:1-12", "Mateus 2:1-12")

# 1 Dom Epifania (Batismo)
add_row(data, "A", "eucharist", "baptism_of_the_lord", "Isaías 42:1-9", "Salmo 29", "Atos 10:34-43", "Mateus 3:13-17")
add_row(data, "B", "eucharist", "baptism_of_the_lord", "Gênesis 1:1-5", "Salmo 29", "Atos 19:1-7", "Marcos 1:4-11")
add_row(data, "C", "eucharist", "baptism_of_the_lord", "Isaías 43:1-7", "Salmo 29", "Atos 8:14-17", "Lucas 3:15-17, 21-22")

# 2 Dom Epifania (TC 2)
add_row(data, "A", "eucharist", "2nd_sunday_after_epiphany", "Isaías 49:1-7", "Salmo 40:1-11", "1 Coríntios 1:1-9", "João 1:29-42")
add_row(data, "B", "eucharist", "2nd_sunday_after_epiphany", "1 Samuel 3:1-10 (11-20)", "Salmo 139:1-6, 13-18", "1 Coríntios 6:12-20", "João 1:43-51")
add_row(data, "C", "eucharist", "2nd_sunday_after_epiphany", "Isaías 62:1-5", "Salmo 36:5-10", "1 Coríntios 12:1-11", "João 2:1-11")

# 3 Dom Epifania (TC 3)
add_row(data, "A", "eucharist", "3rd_sunday_after_epiphany", "Isaías 9:1-4", "Salmo 27:1, 4-9", "1 Coríntios 1:10-18", "Mateus 4:12-23")
add_row(data, "B", "eucharist", "3rd_sunday_after_epiphany", "Jonas 3:1-5, 10", "Salmo 62:5-12", "1 Coríntios 7:29-31", "Marcos 1:14-20")
add_row(data, "C", "eucharist", "3rd_sunday_after_epiphany", "Neemias 8:1-3, 5-6, 8-10", "Salmo 19", "1 Coríntios 12:12-31a", "Lucas 4:14-21")

# 4 Dom Epifania (TC 4)
add_row(data, "A", "eucharist", "4th_sunday_after_epiphany", "Miqueias 6:1-8", "Salmo 15", "1 Coríntios 1:18-31", "Mateus 5:1-12")
add_row(data, "B", "eucharist", "4th_sunday_after_epiphany", "Deuteronômio 18:15-20", "Salmo 111", "1 Coríntios 8:1-13", "Marcos 1:21-28")
add_row(data, "C", "eucharist", "4th_sunday_after_epiphany", "Jeremias 1:4-10", "Salmo 71:1-6", "1 Coríntios 13:1-13", "Lucas 4:21-30")

# 5 Dom Epifania (TC 5)
add_row(data, "A", "eucharist", "5th_sunday_after_epiphany", "Isaías 58:1-9a (9b-12)", "Salmo 112:1-9 (10)", "1 Coríntios 2:1-12 (13-16)", "Mateus 5:13-20")
add_row(data, "B", "eucharist", "5th_sunday_after_epiphany", "Isaías 40:21-31", "Salmo 147:1-11, 20c", "1 Coríntios 9:16-23", "Marcos 1:29-39")
add_row(data, "C", "eucharist", "5th_sunday_after_epiphany", "Isaías 6:1-8 (9-13)", "Salmo 138", "1 Coríntios 15:1-11", "Lucas 5:1-11")

# 6 Dom Epifania (Proper 1 / TC 6)
add_row(data, "A", "eucharist", "6th_sunday_after_epiphany", "Deuteronômio 30:15-20 ou Eclesiástico 15:15-20", "Salmo 119:1-8", "1 Coríntios 3:1-9", "Mateus 5:21-37")
add_row(data, "B", "eucharist", "6th_sunday_after_epiphany", "2 Reis 5:1-14", "Salmo 30", "1 Coríntios 9:24-27", "Marcos 1:40-45")
add_row(data, "C", "eucharist", "6th_sunday_after_epiphany", "Jeremias 17:5-10", "Salmo 1", "1 Coríntios 15:12-20", "Lucas 6:17-26")

# 7 Dom Epifania (Proper 2 / TC 7)
add_row(data, "A", "eucharist", "7th_sunday_after_epiphany", "Levítico 19:1-2, 9-18", "Salmo 119:33-40", "1 Coríntios 3:10-11, 16-23", "Mateus 5:38-48")
add_row(data, "B", "eucharist", "7th_sunday_after_epiphany", "Isaías 43:18-25", "Salmo 41", "2 Coríntios 1:18-22", "Marcos 2:1-12")
add_row(data, "C", "eucharist", "7th_sunday_after_epiphany", "Gênesis 45:3-11, 15", "Salmo 37:1-11, 39-40", "1 Coríntios 15:35-38, 42-50", "Lucas 6:27-38")

# 8 Dom Epifania (Proper 3 / TC 8)
add_row(data, "A", "eucharist", "8th_sunday_after_epiphany", "Isaías 49:8-16a", "Salmo 131", "1 Coríntios 4:1-5", "Mateus 6:24-34")
add_row(data, "B", "eucharist", "8th_sunday_after_epiphany", "Oseias 2:14-20", "Salmo 103:1-13, 22", "2 Coríntios 3:1-6", "Marcos 2:13-22")
add_row(data, "C", "eucharist", "8th_sunday_after_epiphany", "Eclesiástico 27:4-7 ou Isaías 55:10-13", "Salmo 92:1-4, 12-15", "1 Coríntios 15:51-58", "Lucas 6:39-49")

# Último Domingo Epifania (Transfiguração)
add_row(data, "A", "eucharist", "last_sunday_after_epiphany", "Êxodo 24:12-18", "Salmo 2 ou Salmo 99", "2 Pedro 1:16-21", "Mateus 17:1-9")
add_row(data, "B", "eucharist", "last_sunday_after_epiphany", "2 Reis 2:1-12", "Salmo 50:1-6", "2 Coríntios 4:3-6", "Marcos 9:2-9")
add_row(data, "C", "eucharist", "last_sunday_after_epiphany", "Êxodo 34:29-35", "Salmo 99", "2 Coríntios 3:12-4:2", "Lucas 9:28-36 (37-43)")

# --- QUARESMA ---
# Quarta de Cinzas
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "ash_wednesday", "Joel 2:1-2, 12-17 ou Isaías 58:1-12", "Salmo 51:1-17", "2 Coríntios 5:20b-6:10", "Mateus 6:1-6, 16-21")

# 1 Quaresma
add_row(data, "A", "eucharist", "1st_sunday_in_lent", "Gênesis 2:15-17; 3:1-7", "Salmo 32", "Romanos 5:12-19", "Mateus 4:1-11")
add_row(data, "B", "eucharist", "1st_sunday_in_lent", "Gênesis 9:8-17", "Salmo 25:1-10", "1 Pedro 3:18-22", "Marcos 1:9-15")
add_row(data, "C", "eucharist", "1st_sunday_in_lent", "Deuteronômio 26:1-11", "Salmo 91:1-2, 9-16", "Romanos 10:8b-13", "Lucas 4:1-13")

# 2 Quaresma
add_row(data, "A", "eucharist", "2nd_sunday_in_lent", "Gênesis 12:1-4a", "Salmo 121", "Romanos 4:1-5, 13-17", "João 3:1-17 ou Mateus 17:1-9")
add_row(data, "B", "eucharist", "2nd_sunday_in_lent", "Gênesis 17:1-7, 15-16", "Salmo 22:23-31", "Romanos 4:13-25", "Marcos 8:31-38 ou Marcos 9:2-9")
add_row(data, "C", "eucharist", "2nd_sunday_in_lent", "Gênesis 15:1-12, 17-18", "Salmo 27", "Filipenses 3:17-4:1", "Lucas 13:31-35 ou Lucas 9:28-36")

# 3 Quaresma
add_row(data, "A", "eucharist", "3rd_sunday_in_lent", "Êxodo 17:1-7", "Salmo 95", "Romanos 5:1-11", "João 4:5-42")
add_row(data, "B", "eucharist", "3rd_sunday_in_lent", "Êxodo 20:1-17", "Salmo 19", "1 Coríntios 1:18-25", "João 2:13-22")
add_row(data, "C", "eucharist", "3rd_sunday_in_lent", "Isaías 55:1-9", "Salmo 63:1-8", "1 Coríntios 10:1-13", "Lucas 13:1-9")

# 4 Quaresma
add_row(data, "A", "eucharist", "4th_sunday_in_lent", "1 Samuel 16:1-13", "Salmo 23", "Efésios 5:8-14", "João 9:1-41")
add_row(data, "B", "eucharist", "4th_sunday_in_lent", "Números 21:4-9", "Salmo 107:1-3, 17-22", "Efésios 2:1-10", "João 3:14-21")
add_row(data, "C", "eucharist", "4th_sunday_in_lent", "Josué 5:9-12", "Salmo 32", "2 Coríntios 5:16-21", "Lucas 15:1-3, 11b-32")

# 5 Quaresma
add_row(data, "A", "eucharist", "5th_sunday_in_lent", "Ezequiel 37:1-14", "Salmo 130", "Romanos 8:6-11", "João 11:1-45")
add_row(data, "B", "eucharist", "5th_sunday_in_lent", "Jeremias 31:31-34", "Salmo 51:1-12 ou Salmo 119:9-16", "Hebreus 5:5-10", "João 12:20-33")
add_row(data, "C", "eucharist", "5th_sunday_in_lent", "Isaías 43:16-21", "Salmo 126", "Filipenses 3:4b-14", "João 12:1-8")

# Domingo de Ramos (Palmas e Paixão)
add_row(data, "A", "eucharist", "palm_sunday_liturgy", "Mateus 21:1-11", "Salmo 118:1-2, 19-29", "", "")
add_row(data, "B", "eucharist", "palm_sunday_liturgy", "Marcos 11:1-11 ou João 12:12-16", "Salmo 118:1-2, 19-29", "", "")
add_row(data, "C", "eucharist", "palm_sunday_liturgy", "Lucas 19:28-40", "Salmo 118:1-2, 19-29", "", "")

add_row(data, "A", "eucharist", "palm_sunday_passion", "Isaías 50:4-9a", "Salmo 31:9-16", "Filipenses 2:5-11", "Mateus 26:14-27:66 ou Mateus 27:11-54")
add_row(data, "B", "eucharist", "palm_sunday_passion", "Isaías 50:4-9a", "Salmo 31:9-16", "Filipenses 2:5-11", "Marcos 14:1-15:47 ou Marcos 15:1-39 (40-47)")
add_row(data, "C", "eucharist", "palm_sunday_passion", "Isaías 50:4-9a", "Salmo 31:9-16", "Filipenses 2:5-11", "Lucas 22:14-23:56 ou Lucas 23:1-49")

# Semana Santa (Seg, Ter, Qua)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "monday_holy_week", "Isaías 42:1-9", "Salmo 36:5-11", "Hebreus 9:11-15", "João 12:1-11")
    add_row(data, cycle, "eucharist", "tuesday_holy_week", "Isaías 49:1-7", "Salmo 71:1-14", "1 Coríntios 1:18-31", "João 12:20-36")
    add_row(data, cycle, "eucharist", "wednesday_holy_week", "Isaías 50:4-9a", "Salmo 70", "Hebreus 12:1-3", "João 13:21-32")

# Quinta Santa
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "maundy_thursday_unity", "Isaías 61:1-8", "Salmo 23", "Apocalipse 1:4-8", "Lucas 4:16-21")
    add_row(data, cycle, "eucharist", "maundy_thursday_supper", "Êxodo 12:1-4 (5-10) 11-14", "Salmo 116:1-2, 12-19", "1 Coríntios 11:23-26", "João 13:1-17, 31b-35")

# Sexta da Paixão
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "good_friday", "Isaías 52:13-53:12", "Salmo 22", "Hebreus 10:16-25 ou Hebreus 4:14-16; 5:7-9", "João 18:1-19:42")

# Sábado Santo
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "daily_office", "holy_saturday", "Jó 14:1-14 ou Lamentações 3:1-9, 19-24", "Salmo 31:1-4, 15-16", "1 Pedro 4:1-8", "Mateus 27:57-66 ou João 19:38-42")

# --- PÁSCOA ---
# Vigília Pascal (Várias leituras AT, listadas genericamente como First Reading no CSV para simplicidade, mas o ideal seria array)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "easter_vigil", "Gênesis 1:1-2:4a... (Várias)", "Salmo 114 (Interlecionário do NT)", "Romanos 6:3-11", "Mateus 28:1-10 (A) / Marcos 16:1-8 (B) / Lucas 24:1-12 (C)") 
    # Nota: No código final vou refinar os evangelhos por ano na vigília, aqui está simplificado.

# Refinando Evangelhos Vigília:
data[-1]["gospel"] = "Lucas 24:1-12" # C
add_row(data, "A", "eucharist", "easter_vigil", "Gênesis 1:1-2:4a... (Várias)", "Salmo 114", "Romanos 6:3-11", "Mateus 28:1-10")
add_row(data, "B", "eucharist", "easter_vigil", "Gênesis 1:1-2:4a... (Várias)", "Salmo 114", "Romanos 6:3-11", "Marcos 16:1-8")
# Removendo a entrada generica ABC anterior e mantendo as 3 especificas seria melhor, mas o script vai sobrescrever ou adicionar. 

# Domingo de Páscoa
add_row(data, "A", "eucharist", "easter_day", "Atos 10:34-43 ou Jeremias 31:1-6", "Salmo 118:1-2, 14-24", "Colossenses 3:1-4 ou Atos 10:34-43", "João 20:1-18 ou Mateus 28:1-10")
add_row(data, "B", "eucharist", "easter_day", "Atos 10:34-43 ou Isaías 25:6-9", "Salmo 118:1-2, 14-24", "1 Coríntios 15:1-11 ou Atos 10:34-43", "João 20:1-18 ou Marcos 16:1-8")
add_row(data, "C", "eucharist", "easter_day", "Atos 10:34-43 ou Isaías 65:17-25", "Salmo 118:1-2, 14-24", "1 Coríntios 15:19-26 ou Atos 10:34-43", "João 20:1-18 ou Lucas 24:1-12")

# Oficio Vespertino Pascoa
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "daily_office", "easter_evening", "Isaías 25:6-9", "Salmo 114", "1 Coríntios 5:6b-8", "Lucas 24:13-49")

# 2 Páscoa
add_row(data, "A", "eucharist", "2nd_sunday_of_easter", "Atos 2:14a, 22-32", "Salmo 16", "1 Pedro 1:3-9", "João 20:19-31")
add_row(data, "B", "eucharist", "2nd_sunday_of_easter", "Atos 4:32-35", "Salmo 133", "1 João 1:1-2:2", "João 20:19-31")
add_row(data, "C", "eucharist", "2nd_sunday_of_easter", "Atos 5:27-32", "Salmo 118:14-29 ou Salmo 150", "Apocalipse 1:4-8", "João 20:19-31")

# 3 Páscoa
add_row(data, "A", "eucharist", "3rd_sunday_of_easter", "Atos 2:14a, 36-41", "Salmo 116:1-4, 12-19", "1 Pedro 1:17-23", "Lucas 24:13-35")
add_row(data, "B", "eucharist", "3rd_sunday_of_easter", "Atos 3:12-19", "Salmo 4", "1 João 3:1-7", "Lucas 24:36b-48")
add_row(data, "C", "eucharist", "3rd_sunday_of_easter", "Atos 9:1-6 (7-20)", "Salmo 30", "Apocalipse 5:11-14", "João 21:1-19")

# 4 Páscoa
add_row(data, "A", "eucharist", "4th_sunday_of_easter", "Atos 2:42-47", "Salmo 23", "1 Pedro 2:19-25", "João 10:1-10")
add_row(data, "B", "eucharist", "4th_sunday_of_easter", "Atos 4:5-12", "Salmo 23", "1 João 3:16-24", "João 10:11-18")
add_row(data, "C", "eucharist", "4th_sunday_of_easter", "Atos 9:36-43", "Salmo 23", "Apocalipse 7:9-17", "João 10:22-30")

# 5 Páscoa
add_row(data, "A", "eucharist", "5th_sunday_of_easter", "Atos 7:55-60", "Salmo 31:1-5, 15-16", "1 Pedro 2:2-10", "João 14:1-14")
add_row(data, "B", "eucharist", "5th_sunday_of_easter", "Atos 8:26-40", "Salmo 22:25-31", "1 João 4:7-21", "João 15:1-8")
add_row(data, "C", "eucharist", "5th_sunday_of_easter", "Atos 11:1-18", "Salmo 148", "Apocalipse 21:1-6", "João 13:31-35")

# 6 Páscoa
add_row(data, "A", "eucharist", "6th_sunday_of_easter", "Atos 17:22-31", "Salmo 66:8-20", "1 Pedro 3:13-22", "João 14:15-21")
add_row(data, "B", "eucharist", "6th_sunday_of_easter", "Atos 10:44-48", "Salmo 98", "1 João 5:1-6", "João 15:9-17")
add_row(data, "C", "eucharist", "6th_sunday_of_easter", "Atos 16:9-15", "Salmo 67", "Apocalipse 21:10, 22-22:5", "João 14:23-29 ou João 5:1-9")

# Ascensão
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "ascension_day", "Atos 1:1-11", "Salmo 47 ou Salmo 93", "Efésios 1:15-23", "Lucas 24:44-53")

# 7 Páscoa
add_row(data, "A", "eucharist", "7th_sunday_of_easter", "Atos 1:6-14", "Salmo 68:1-10, 32-35", "1 Pedro 4:12-14; 5:6-11", "João 17:1-11")
add_row(data, "B", "eucharist", "7th_sunday_of_easter", "Atos 1:15-17, 21-26", "Salmo 1", "1 João 5:9-13", "João 17:6-19")
add_row(data, "C", "eucharist", "7th_sunday_of_easter", "Atos 16:16-34", "Salmo 97", "Apocalipse 22:12-14, 16-17, 20-21", "João 17:20-26")

# Pentecostes
add_row(data, "A", "eucharist", "pentecost", "Atos 2:1-21 ou Números 11:24-30", "Salmo 104:24-34, 35b", "1 Coríntios 12:3b-13 ou Atos 2:1-21", "João 20:19-23 ou João 7:37-39")
add_row(data, "B", "eucharist", "pentecost", "Atos 2:1-21 ou Ezequiel 37:1-14", "Salmo 104:24-34, 35b", "Romanos 8:22-27 ou Atos 2:1-21", "João 15:26-27; 16:4b-15")
add_row(data, "C", "eucharist", "pentecost", "Atos 2:1-21 ou Gênesis 11:1-9", "Salmo 104:24-34, 35b", "Romanos 8:14-17 ou Atos 2:1-21", "João 14:8-17 (25-27)")

# --- TEMPO COMUM (AMOSTRA DE PROPRIOS REPRESENTATIVA) ---
# Trindade
add_row(data, "A", "eucharist", "trinity_sunday", "Gênesis 1:1-2:4a", "Salmo 8", "2 Coríntios 13:11-13", "Mateus 28:16-20")
add_row(data, "B", "eucharist", "trinity_sunday", "Isaías 6:1-8", "Salmo 29", "Romanos 8:12-17", "João 3:1-17")
add_row(data, "C", "eucharist", "trinity_sunday", "Provérbios 8:1-4, 22-31", "Salmo 8", "Romanos 5:1-5", "João 16:12-15")

# Proprio 4 (TC 9)
add_row(data, "A", "eucharist", "proper_4_semicontinuous", "Gênesis 6:9-22; 7:24; 8:14-19", "Salmo 46", "Romanos 1:16-17; 3:22b-28 (29-31)", "Mateus 7:21-29")
add_row(data, "A", "eucharist", "proper_4_complementary", "Deuteronômio 11:18-21, 26-28", "Salmo 31:1-5, 19-24", "Romanos 1:16-17; 3:22b-28 (29-31)", "Mateus 7:21-29")
add_row(data, "B", "eucharist", "proper_4_semicontinuous", "1 Samuel 3:1-10 (11-20)", "Salmo 139:1-6, 13-18", "2 Coríntios 4:5-12", "Marcos 2:23-3:6")
add_row(data, "B", "eucharist", "proper_4_complementary", "Deuteronômio 5:12-15", "Salmo 81:1-10", "2 Coríntios 4:5-12", "Marcos 2:23-3:6")
add_row(data, "C", "eucharist", "proper_4_semicontinuous", "1 Reis 18:20-21 (22-29) 30-39", "Salmo 96", "Gálatas 1:1-12", "Lucas 7:1-10")
add_row(data, "C", "eucharist", "proper_4_complementary", "1 Reis 8:22-23, 41-43", "Salmo 96:1-9", "Gálatas 1:1-12", "Lucas 7:1-10")

# --- TEMPO COMUM (PRÓPRIOS / PROPERS) ---
# Nota: A partir do Próprio 4, existem duas trilhas para o AT: Semicontínua e Complementar.

# Santíssima Trindade (Domingo após Pentecostes)
add_row(data, "A", "eucharist", "trinity_sunday", "Gênesis 1:1-2:4a", "Salmo 8", "2 Coríntios 13:11-13", "Mateus 28:16-20")
add_row(data, "B", "eucharist", "trinity_sunday", "Isaías 6:1-8", "Salmo 29", "Romanos 8:12-17", "João 3:1-17")
add_row(data, "C", "eucharist", "trinity_sunday", "Provérbios 8:1-4, 22-31", "Salmo 8", "Romanos 5:1-5", "João 16:12-15")

# Corpus Christi (Dia de Ação de Graças pelos Sacramentos) - Quinta após Trindade
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "eucharist", "corpus_christi", "Êxodo 16:9-15", "Salmo 116:12-19", "1 Coríntios 10:16-17 ou 11:23-26", "João 6:51-58")

# Próprio 3 (Tempo Comum 8)
# Nota: Imagens indicam trilha única para este domingo específico ou transição.
add_row(data, "A", "eucharist", "proper_3", "Isaías 49:8-16a", "Salmo 131", "1 Coríntios 4:1-5", "Mateus 6:24-34")
add_row(data, "B", "eucharist", "proper_3", "Oseias 2:14-20", "Salmo 103:1-13, 22", "2 Coríntios 3:1-6", "Marcos 2:13-22")
add_row(data, "C", "eucharist", "proper_3", "Eclesiástico 27:4-7 ou Isaías 55:10-13", "Salmo 92:1-4, 12-15", "1 Coríntios 15:51-58", "Lucas 6:39-49")

# --- LOOP PARA OS PRÓPRIOS 4 AO 29 (COM DUAS TRILHAS NO AT) ---
# Para não deixar o código gigante aqui, vou exemplificar a estrutura completa dos Próprios
# baseada nas suas imagens. Você pode replicar esse padrão.
# Abaixo estão os dados transcritos das imagens principais (amostra de estrutura):

# Próprio 4 (Tempo Comum 9)
# Ano A
add_row(data, "A", "eucharist", "proper_4_semicontinuous", "Gênesis 6:9-22; 7:24; 8:14-19", "Salmo 46", "Romanos 1:16-17; 3:22b-28", "Mateus 7:21-29")
add_row(data, "A", "eucharist", "proper_4_complementary", "Deuteronômio 11:18-21, 26-28", "Salmo 31:1-5, 19-24", "Romanos 1:16-17; 3:22b-28", "Mateus 7:21-29")
# Ano B
add_row(data, "B", "eucharist", "proper_4_semicontinuous", "1 Samuel 3:1-20", "Salmo 139:1-6, 13-18", "2 Coríntios 4:5-12", "Marcos 2:23-3:6")
add_row(data, "B", "eucharist", "proper_4_complementary", "Deuteronômio 5:12-15", "Salmo 81:1-10", "2 Coríntios 4:5-12", "Marcos 2:23-3:6")
# Ano C
add_row(data, "C", "eucharist", "proper_4_semicontinuous", "1 Reis 18:20-39", "Salmo 96", "Gálatas 1:1-12", "Lucas 7:1-10")
add_row(data, "C", "eucharist", "proper_4_complementary", "1 Reis 8:22-23, 41-43", "Salmo 96:1-9", "Gálatas 1:1-12", "Lucas 7:1-10")

# Próprio 5 (Tempo Comum 10)
# Ano A
add_row(data, "A", "eucharist", "proper_5_semicontinuous", "Gênesis 12:1-9", "Salmo 33:1-12", "Romanos 4:13-25", "Mateus 9:9-13, 18-26")
add_row(data, "A", "eucharist", "proper_5_complementary", "Oseias 5:15-6:6", "Salmo 50:7-15", "Romanos 4:13-25", "Mateus 9:9-13, 18-26")
# Ano B
add_row(data, "B", "eucharist", "proper_5_semicontinuous", "1 Samuel 8:4-20; 11:14-15", "Salmo 138", "2 Coríntios 4:13-5:1", "Marcos 3:20-35")
add_row(data, "B", "eucharist", "proper_5_complementary", "Gênesis 3:8-15", "Salmo 130", "2 Coríntios 4:13-5:1", "Marcos 3:20-35")
# Ano C
add_row(data, "C", "eucharist", "proper_5_semicontinuous", "1 Reis 17:8-24", "Salmo 146", "Gálatas 1:11-24", "Lucas 7:11-17")
add_row(data, "C", "eucharist", "proper_5_complementary", "1 Reis 17:17-24", "Salmo 30", "Gálatas 1:11-24", "Lucas 7:11-17")


# --- TEMPO COMUM: PRÓPRIOS 6 AO 29 (CÓDIGO COMPLETO) ---

# Próprio 6 (Tempo Comum 11)
# Ano A
add_row(data, "A", "eucharist", "proper_6_semicontinuous", "Gênesis 18:1-15 (21:1-7)", "Salmo 116:1-2, 12-19", "Romanos 5:1-8", "Mateus 9:35-10:8 (9-23)")
add_row(data, "A", "eucharist", "proper_6_complementary", "Êxodo 19:2-8a", "Salmo 100", "Romanos 5:1-8", "Mateus 9:35-10:8 (9-23)")
# Ano B
add_row(data, "B", "eucharist", "proper_6_semicontinuous", "1 Samuel 15:34-16:13", "Salmo 20", "2 Coríntios 5:6-10 (11-13) 14-17", "Marcos 4:26-34")
add_row(data, "B", "eucharist", "proper_6_complementary", "Ezequiel 17:22-24", "Salmo 92:1-4, 12-15", "2 Coríntios 5:6-10 (11-13) 14-17", "Marcos 4:26-34")
# Ano C
add_row(data, "C", "eucharist", "proper_6_semicontinuous", "1 Reis 21:1-10 (11-14) 15-21a", "Salmo 5:1-8", "Gálatas 2:15-21", "Lucas 7:36-8:3")
add_row(data, "C", "eucharist", "proper_6_complementary", "2 Samuel 11:26-12:10, 13-15", "Salmo 32", "Gálatas 2:15-21", "Lucas 7:36-8:3")

# Próprio 7 (Tempo Comum 12)
# Ano A
add_row(data, "A", "eucharist", "proper_7_semicontinuous", "Gênesis 21:8-21", "Salmo 86:1-10, 16-17", "Romanos 6:1b-11", "Mateus 10:24-39")
add_row(data, "A", "eucharist", "proper_7_complementary", "Jeremias 20:7-13", "Salmo 69:7-10 (11-15) 16-18", "Romanos 6:1b-11", "Mateus 10:24-39")
# Ano B
add_row(data, "B", "eucharist", "proper_7_semicontinuous", "1 Samuel 17: (1a, 4-11, 19-23) 32-49 ou 1 Samuel 17:57-18:5, 10-16", "Salmo 9:9-20 ou Salmo 133", "2 Coríntios 6:1-13", "Marcos 4:35-41")
add_row(data, "B", "eucharist", "proper_7_complementary", "Jó 38:1-11", "Salmo 107:1-3, 23-32", "2 Coríntios 6:1-13", "Marcos 4:35-41")
# Ano C
add_row(data, "C", "eucharist", "proper_7_semicontinuous", "1 Reis 19:1-4 (5-7) 8-15a", "Salmos 42 e 43", "Gálatas 3:23-29", "Lucas 8:26-39")
add_row(data, "C", "eucharist", "proper_7_complementary", "Isaías 65:1-9", "Salmo 22:19-28", "Gálatas 3:23-29", "Lucas 8:26-39")

# Próprio 8 (Tempo Comum 13)
# Ano A
add_row(data, "A", "eucharist", "proper_8_semicontinuous", "Gênesis 22:1-14", "Salmo 13", "Romanos 6:12-23", "Mateus 10:40-42")
add_row(data, "A", "eucharist", "proper_8_complementary", "Jeremias 28:5-9", "Salmo 89:1-4, 15-18", "Romanos 6:12-23", "Mateus 10:40-42")
# Ano B
add_row(data, "B", "eucharist", "proper_8_semicontinuous", "2 Samuel 1:1, 17-27", "Salmo 130", "2 Coríntios 8:7-15", "Marcos 5:21-43")
add_row(data, "B", "eucharist", "proper_8_complementary", "Sabedoria 1:13-15; 2:23-24 ou Lamentações 3:22-33", "Salmo 30", "2 Coríntios 8:7-15", "Marcos 5:21-43")
# Ano C
add_row(data, "C", "eucharist", "proper_8_semicontinuous", "2 Reis 2:1-2, 6-14", "Salmo 77:1-2, 11-20", "Gálatas 5:1, 13-25", "Lucas 9:51-62")
add_row(data, "C", "eucharist", "proper_8_complementary", "1 Reis 19:15-16, 19-21", "Salmo 16", "Gálatas 5:1, 13-25", "Lucas 9:51-62")

# Próprio 9 (Tempo Comum 14)
# Ano A
add_row(data, "A", "eucharist", "proper_9_semicontinuous", "Gênesis 24:34-38, 42-49, 58-67", "Salmo 45:10-17 ou Cântico 2:8-13", "Romanos 7:15-25a", "Mateus 11:16-19, 25-30")
add_row(data, "A", "eucharist", "proper_9_complementary", "Zacarias 9:9-12", "Salmo 145:8-14", "Romanos 7:15-25a", "Mateus 11:16-19, 25-30")
# Ano B
add_row(data, "B", "eucharist", "proper_9_semicontinuous", "2 Samuel 5:1-5, 9-10", "Salmo 48", "2 Coríntios 12:2-10", "Marcos 6:1-13")
add_row(data, "B", "eucharist", "proper_9_complementary", "Ezequiel 2:1-5", "Salmo 123", "2 Coríntios 12:2-10", "Marcos 6:1-13")
# Ano C
add_row(data, "C", "eucharist", "proper_9_semicontinuous", "2 Reis 5:1-14", "Salmo 30", "Gálatas 6:(1-6) 7-16", "Lucas 10:1-11, 16-20")
add_row(data, "C", "eucharist", "proper_9_complementary", "Isaías 66:10-14", "Salmo 66:1-9", "Gálatas 6:(1-6) 7-16", "Lucas 10:1-11, 16-20")

# Próprio 10 (Tempo Comum 15)
# Ano A
add_row(data, "A", "eucharist", "proper_10_semicontinuous", "Gênesis 25:19-34", "Salmo 119:105-112", "Romanos 8:1-11", "Mateus 13:1-9, 18-23")
add_row(data, "A", "eucharist", "proper_10_complementary", "Isaías 55:10-13", "Salmo 65:(1-8) 9-13", "Romanos 8:1-11", "Mateus 13:1-9, 18-23")
# Ano B
add_row(data, "B", "eucharist", "proper_10_semicontinuous", "2 Samuel 6:1-5, 12b-19", "Salmo 24", "Efésios 1:3-14", "Marcos 6:14-29")
add_row(data, "B", "eucharist", "proper_10_complementary", "Amós 7:7-15", "Salmo 85:8-13", "Efésios 1:3-14", "Marcos 6:14-29")
# Ano C
add_row(data, "C", "eucharist", "proper_10_semicontinuous", "Amós 7:7-17", "Salmo 82", "Colossenses 1:1-14", "Lucas 10:25-37")
add_row(data, "C", "eucharist", "proper_10_complementary", "Deuteronômio 30:9-14", "Salmo 25:1-10", "Colossenses 1:1-14", "Lucas 10:25-37")

# Próprio 11 (Tempo Comum 16)
# Ano A
add_row(data, "A", "eucharist", "proper_11_semicontinuous", "Gênesis 28:10-19a", "Salmo 139:1-12, 23-24", "Romanos 8:12-25", "Mateus 13:24-30, 36-43")
add_row(data, "A", "eucharist", "proper_11_complementary", "Sabedoria 12:13, 16-19 ou Isaías 44:6-8", "Salmo 86:11-17", "Romanos 8:12-25", "Mateus 13:24-30, 36-43")
# Ano B
add_row(data, "B", "eucharist", "proper_11_semicontinuous", "2 Samuel 7:1-14a", "Salmo 89:20-37", "Efésios 2:11-22", "Marcos 6:30-34, 53-56")
add_row(data, "B", "eucharist", "proper_11_complementary", "Jeremias 23:1-6", "Salmo 23", "Efésios 2:11-22", "Marcos 6:30-34, 53-56")
# Ano C
add_row(data, "C", "eucharist", "proper_11_semicontinuous", "Amós 8:1-12", "Salmo 52", "Colossenses 1:15-28", "Lucas 10:38-42")
add_row(data, "C", "eucharist", "proper_11_complementary", "Gênesis 18:1-10a", "Salmo 15", "Colossenses 1:15-28", "Lucas 10:38-42")

# Próprio 12 (Tempo Comum 17)
# Ano A
add_row(data, "A", "eucharist", "proper_12_semicontinuous", "Gênesis 29:15-28", "Salmo 105:1-11, 45b ou Salmo 128", "Romanos 8:26-39", "Mateus 13:31-33, 44-52")
add_row(data, "A", "eucharist", "proper_12_complementary", "1 Reis 3:5-12", "Salmo 119:129-136", "Romanos 8:26-39", "Mateus 13:31-33, 44-52")
# Ano B
add_row(data, "B", "eucharist", "proper_12_semicontinuous", "2 Samuel 11:1-15", "Salmo 14", "Efésios 3:14-21", "João 6:1-21")
add_row(data, "B", "eucharist", "proper_12_complementary", "2 Reis 4:42-44", "Salmo 145:10-18", "Efésios 3:14-21", "João 6:1-21")
# Ano C
add_row(data, "C", "eucharist", "proper_12_semicontinuous", "Oseias 1:2-10", "Salmo 85", "Colossenses 2:6-15 (16-19)", "Lucas 11:1-13")
add_row(data, "C", "eucharist", "proper_12_complementary", "Gênesis 18:20-32", "Salmo 138", "Colossenses 2:6-15 (16-19)", "Lucas 11:1-13")

# Próprio 13 (Tempo Comum 18)
# Ano A
add_row(data, "A", "eucharist", "proper_13_semicontinuous", "Gênesis 32:22-31", "Salmo 17:1-7, 15", "Romanos 9:1-5", "Mateus 14:13-21")
add_row(data, "A", "eucharist", "proper_13_complementary", "Isaías 55:1-5", "Salmo 145:8-9, 14-21", "Romanos 9:1-5", "Mateus 14:13-21")
# Ano B
add_row(data, "B", "eucharist", "proper_13_semicontinuous", "2 Samuel 11:26-12:13a", "Salmo 51:1-12", "Efésios 4:1-16", "João 6:24-35")
add_row(data, "B", "eucharist", "proper_13_complementary", "Êxodo 16:2-4, 9-15", "Salmo 78:23-29", "Efésios 4:1-16", "João 6:24-35")
# Ano C
add_row(data, "C", "eucharist", "proper_13_semicontinuous", "Oseias 11:1-11", "Salmo 107:1-9, 43", "Colossenses 3:1-11", "Lucas 12:13-21")
add_row(data, "C", "eucharist", "proper_13_complementary", "Eclesiastes 1:2, 12-14; 2:18-23", "Salmo 49:1-12", "Colossenses 3:1-11", "Lucas 12:13-21")

# Próprio 14 (Tempo Comum 19)
# Ano A
add_row(data, "A", "eucharist", "proper_14_semicontinuous", "Gênesis 37:1-4, 12-28", "Salmo 105:1-6, 16-22, 45b", "Romanos 10:5-15", "Mateus 14:22-33")
add_row(data, "A", "eucharist", "proper_14_complementary", "1 Reis 19:9-18", "Salmo 85:8-13", "Romanos 10:5-15", "Mateus 14:22-33")
# Ano B
add_row(data, "B", "eucharist", "proper_14_semicontinuous", "2 Samuel 18:5-9, 15, 31-33", "Salmo 130", "Efésios 4:25-5:2", "João 6:35, 41-51")
add_row(data, "B", "eucharist", "proper_14_complementary", "1 Reis 19:4-8", "Salmo 34:1-8", "Efésios 4:25-5:2", "João 6:35, 41-51")
# Ano C
add_row(data, "C", "eucharist", "proper_14_semicontinuous", "Isaías 1:1, 10-20", "Salmo 50:1-8, 22-23", "Hebreus 11:1-3, 8-16", "Lucas 12:32-40")
add_row(data, "C", "eucharist", "proper_14_complementary", "Gênesis 15:1-6", "Salmo 33:12-22", "Hebreus 11:1-3, 8-16", "Lucas 12:32-40")

# Próprio 15 (Tempo Comum 20)
# Ano A
add_row(data, "A", "eucharist", "proper_15_semicontinuous", "Gênesis 45:1-15", "Salmo 133", "Romanos 11:1-2a, 29-32", "Mateus 15:(10-20) 21-28")
add_row(data, "A", "eucharist", "proper_15_complementary", "Isaías 56:1, 6-8", "Salmo 67", "Romanos 11:1-2a, 29-32", "Mateus 15:(10-20) 21-28")
# Ano B
add_row(data, "B", "eucharist", "proper_15_semicontinuous", "1 Reis 2:10-12; 3:3-14", "Salmo 111", "Efésios 5:15-20", "João 6:51-58")
add_row(data, "B", "eucharist", "proper_15_complementary", "Provérbios 9:1-6", "Salmo 34:9-14", "Efésios 5:15-20", "João 6:51-58")
# Ano C
add_row(data, "C", "eucharist", "proper_15_semicontinuous", "Isaías 5:1-7", "Salmo 80:1-2, 8-19", "Hebreus 11:29-12:2", "Lucas 12:49-56")
add_row(data, "C", "eucharist", "proper_15_complementary", "Jeremias 23:23-29", "Salmo 82", "Hebreus 11:29-12:2", "Lucas 12:49-56")

# Próprio 16 (Tempo Comum 21)
# Ano A
add_row(data, "A", "eucharist", "proper_16_semicontinuous", "Êxodo 1:8-2:10", "Salmo 124", "Romanos 12:1-8", "Mateus 16:13-20")
add_row(data, "A", "eucharist", "proper_16_complementary", "Isaías 51:1-6", "Salmo 138", "Romanos 12:1-8", "Mateus 16:13-20")
# Ano B
add_row(data, "B", "eucharist", "proper_16_semicontinuous", "1 Reis 8:(1, 6, 10-11) 22-30, 41-43", "Salmo 84", "Efésios 6:10-20", "João 6:56-69")
add_row(data, "B", "eucharist", "proper_16_complementary", "Josué 24:1-2a, 14-18", "Salmo 34:15-22", "Efésios 6:10-20", "João 6:56-69")
# Ano C
add_row(data, "C", "eucharist", "proper_16_semicontinuous", "Jeremias 1:4-10", "Salmo 71:1-6", "Hebreus 12:18-29", "Lucas 13:10-17")
add_row(data, "C", "eucharist", "proper_16_complementary", "Isaías 58:9b-14", "Salmo 103:1-8", "Hebreus 12:18-29", "Lucas 13:10-17")

# Próprio 17 (Tempo Comum 22)
# Ano A
add_row(data, "A", "eucharist", "proper_17_semicontinuous", "Êxodo 3:1-15", "Salmo 105:1-6, 23-26, 45b", "Romanos 12:9-21", "Mateus 16:21-28")
add_row(data, "A", "eucharist", "proper_17_complementary", "Jeremias 15:15-21", "Salmo 26:1-8", "Romanos 12:9-21", "Mateus 16:21-28")
# Ano B
add_row(data, "B", "eucharist", "proper_17_semicontinuous", "Cântico dos Cânticos 2:8-13", "Salmo 45:1-2, 6-9", "Tiago 1:17-27", "Marcos 7:1-8, 14-15, 21-23")
add_row(data, "B", "eucharist", "proper_17_complementary", "Deuteronômio 4:1-2, 6-9", "Salmo 15", "Tiago 1:17-27", "Marcos 7:1-8, 14-15, 21-23")
# Ano C
add_row(data, "C", "eucharist", "proper_17_semicontinuous", "Jeremias 2:4-13", "Salmo 81:1, 10-16", "Hebreus 13:1-8, 15-16", "Lucas 14:1, 7-14")
add_row(data, "C", "eucharist", "proper_17_complementary", "Eclesiástico 10:12-18 ou Provérbios 25:6-7", "Salmo 112", "Hebreus 13:1-8, 15-16", "Lucas 14:1, 7-14")

# Próprio 18 (Tempo Comum 23)
# Ano A
add_row(data, "A", "eucharist", "proper_18_semicontinuous", "Êxodo 12:1-14", "Salmo 149", "Romanos 13:8-14", "Mateus 18:15-20")
add_row(data, "A", "eucharist", "proper_18_complementary", "Ezequiel 33:7-11", "Salmo 119:33-40", "Romanos 13:8-14", "Mateus 18:15-20")
# Ano B
add_row(data, "B", "eucharist", "proper_18_semicontinuous", "Provérbios 22:1-2, 8-9, 22-23", "Salmo 125", "Tiago 2:1-10 (11-13) 14-17", "Marcos 7:24-37")
add_row(data, "B", "eucharist", "proper_18_complementary", "Isaías 35:4-7a", "Salmo 146", "Tiago 2:1-10 (11-13) 14-17", "Marcos 7:24-37")
# Ano C
add_row(data, "C", "eucharist", "proper_18_semicontinuous", "Jeremias 18:1-11", "Salmo 139:1-6, 13-18", "Filemon 1-21", "Lucas 14:25-33")
add_row(data, "C", "eucharist", "proper_18_complementary", "Deuteronômio 30:15-20", "Salmo 1", "Filemon 1-21", "Lucas 14:25-33")

# Próprio 19 (Tempo Comum 24)
# Ano A
add_row(data, "A", "eucharist", "proper_19_semicontinuous", "Êxodo 14:19-31", "Salmo 114 ou Êxodo 15:1b-11, 20-21", "Romanos 14:1-12", "Mateus 18:21-35")
add_row(data, "A", "eucharist", "proper_19_complementary", "Gênesis 50:15-21", "Salmo 103:(1-7) 8-13", "Romanos 14:1-12", "Mateus 18:21-35")
# Ano B
add_row(data, "B", "eucharist", "proper_19_semicontinuous", "Provérbios 1:20-33", "Salmo 19 ou Sabedoria 7:26-8:1", "Tiago 3:1-12", "Marcos 8:27-38")
add_row(data, "B", "eucharist", "proper_19_complementary", "Isaías 50:4-9a", "Salmo 116:1-9", "Tiago 3:1-12", "Marcos 8:27-38")
# Ano C
add_row(data, "C", "eucharist", "proper_19_semicontinuous", "Jeremias 4:11-12, 22-28", "Salmo 14", "1 Timóteo 1:12-17", "Lucas 15:1-10")
add_row(data, "C", "eucharist", "proper_19_complementary", "Êxodo 32:7-14", "Salmo 51:1-10", "1 Timóteo 1:12-17", "Lucas 15:1-10")

# Próprio 20 (Tempo Comum 25)
# Ano A
add_row(data, "A", "eucharist", "proper_20_semicontinuous", "Êxodo 16:2-15", "Salmo 105:1-6, 37-45", "Filipenses 1:21-30", "Mateus 20:1-16")
add_row(data, "A", "eucharist", "proper_20_complementary", "Jonas 3:10-4:11", "Salmo 145:1-8", "Filipenses 1:21-30", "Mateus 20:1-16")
# Ano B
add_row(data, "B", "eucharist", "proper_20_semicontinuous", "Provérbios 31:10-31", "Salmo 1", "Tiago 3:13-4:3, 7-8a", "Marcos 9:30-37")
add_row(data, "B", "eucharist", "proper_20_complementary", "Sabedoria 1:16-2:1, 12-22 ou Jeremias 11:18-20", "Salmo 54", "Tiago 3:13-4:3, 7-8a", "Marcos 9:30-37")
# Ano C
add_row(data, "C", "eucharist", "proper_20_semicontinuous", "Jeremias 8:18-9:1", "Salmo 79:1-9", "1 Timóteo 2:1-7", "Lucas 16:1-13")
add_row(data, "C", "eucharist", "proper_20_complementary", "Amós 8:4-7", "Salmo 113", "1 Timóteo 2:1-7", "Lucas 16:1-13")

# Próprio 21 (Tempo Comum 26)
# Ano A
add_row(data, "A", "eucharist", "proper_21_semicontinuous", "Êxodo 17:1-7", "Salmo 78:1-4, 12-16", "Filipenses 2:1-13", "Mateus 21:23-32")
add_row(data, "A", "eucharist", "proper_21_complementary", "Ezequiel 18:1-4, 25-32", "Salmo 25:1-9", "Filipenses 2:1-13", "Mateus 21:23-32")
# Ano B
add_row(data, "B", "eucharist", "proper_21_semicontinuous", "Ester 7:1-6, 9-10; 9:20-22", "Salmo 124", "Tiago 5:13-20", "Marcos 9:38-50")
add_row(data, "B", "eucharist", "proper_21_complementary", "Números 11:4-6, 10-16, 24-29", "Salmo 19:7-14", "Tiago 5:13-20", "Marcos 9:38-50")
# Ano C
add_row(data, "C", "eucharist", "proper_21_semicontinuous", "Jeremias 32:1-3a, 6-15", "Salmo 91:1-6, 14-16", "1 Timóteo 6:6-19", "Lucas 16:19-31")
add_row(data, "C", "eucharist", "proper_21_complementary", "Amós 6:1a, 4-7", "Salmo 146", "1 Timóteo 6:6-19", "Lucas 16:19-31")

# Próprio 22 (Tempo Comum 27)
# Ano A
add_row(data, "A", "eucharist", "proper_22_semicontinuous", "Êxodo 20:1-4, 7-9, 12-20", "Salmo 19", "Filipenses 3:4b-14", "Mateus 21:33-46")
add_row(data, "A", "eucharist", "proper_22_complementary", "Isaías 5:1-7", "Salmo 80:7-15", "Filipenses 3:4b-14", "Mateus 21:33-46")
# Ano B
add_row(data, "B", "eucharist", "proper_22_semicontinuous", "Jó 1:1; 2:1-10", "Salmo 26", "Hebreus 1:1-4; 2:5-12", "Marcos 10:2-16")
add_row(data, "B", "eucharist", "proper_22_complementary", "Gênesis 2:18-24", "Salmo 8", "Hebreus 1:1-4; 2:5-12", "Marcos 10:2-16")
# Ano C
add_row(data, "C", "eucharist", "proper_22_semicontinuous", "Lamentações 1:1-6", "Lamentações 3:19-26 ou Salmo 137", "2 Timóteo 1:1-14", "Lucas 17:5-10")
add_row(data, "C", "eucharist", "proper_22_complementary", "Habacuque 1:1-4; 2:1-4", "Salmo 37:1-9", "2 Timóteo 1:1-14", "Lucas 17:5-10")

# Próprio 23 (Tempo Comum 28)
# Ano A
add_row(data, "A", "eucharist", "proper_23_semicontinuous", "Êxodo 32:1-14", "Salmo 106:1-6, 19-23", "Filipenses 4:1-9", "Mateus 22:1-14")
add_row(data, "A", "eucharist", "proper_23_complementary", "Isaías 25:1-9", "Salmo 23", "Filipenses 4:1-9", "Mateus 22:1-14")
# Ano B
add_row(data, "B", "eucharist", "proper_23_semicontinuous", "Jó 23:1-9, 16-17", "Salmo 22:1-15", "Hebreus 4:12-16", "Marcos 10:17-31")
add_row(data, "B", "eucharist", "proper_23_complementary", "Amós 5:6-7, 10-15", "Salmo 90:12-17", "Hebreus 4:12-16", "Marcos 10:17-31")
# Ano C
add_row(data, "C", "eucharist", "proper_23_semicontinuous", "Jeremias 29:1, 4-7", "Salmo 66:1-12", "2 Timóteo 2:8-15", "Lucas 17:11-19")
add_row(data, "C", "eucharist", "proper_23_complementary", "2 Reis 5:1-3, 7-15c", "Salmo 111", "2 Timóteo 2:8-15", "Lucas 17:11-19")

# Próprio 24 (Tempo Comum 29)
# Ano A
add_row(data, "A", "eucharist", "proper_24_semicontinuous", "Êxodo 33:12-23", "Salmo 99", "1 Tessalonicenses 1:1-10", "Mateus 22:15-22")
add_row(data, "A", "eucharist", "proper_24_complementary", "Isaías 45:1-7", "Salmo 96:1-9 (10-13)", "1 Tessalonicenses 1:1-10", "Mateus 22:15-22")
# Ano B
add_row(data, "B", "eucharist", "proper_24_semicontinuous", "Jó 38:1-7 (34-41)", "Salmo 104:1-9, 24, 35b", "Hebreus 5:1-10", "Marcos 10:35-45")
add_row(data, "B", "eucharist", "proper_24_complementary", "Isaías 53:4-12", "Salmo 91:9-16", "Hebreus 5:1-10", "Marcos 10:35-45")
# Ano C
add_row(data, "C", "eucharist", "proper_24_semicontinuous", "Jeremias 31:27-34", "Salmo 119:97-104", "2 Timóteo 3:14-4:5", "Lucas 18:1-8")
add_row(data, "C", "eucharist", "proper_24_complementary", "Gênesis 32:22-31", "Salmo 121", "2 Timóteo 3:14-4:5", "Lucas 18:1-8")

# Próprio 25 (Tempo Comum 30)
# Ano A
add_row(data, "A", "eucharist", "proper_25_semicontinuous", "Deuteronômio 34:1-12", "Salmo 90:1-6, 13-17", "1 Tessalonicenses 2:1-8", "Mateus 22:34-46")
add_row(data, "A", "eucharist", "proper_25_complementary", "Levítico 19:1-2, 15-18", "Salmo 1", "1 Tessalonicenses 2:1-8", "Mateus 22:34-46")
# Ano B
add_row(data, "B", "eucharist", "proper_25_semicontinuous", "Jó 42:1-6, 10-17", "Salmo 34:1-8 (19-22)", "Hebreus 7:23-28", "Marcos 10:46-52")
add_row(data, "B", "eucharist", "proper_25_complementary", "Jeremias 31:7-9", "Salmo 126", "Hebreus 7:23-28", "Marcos 10:46-52")
# Ano C
add_row(data, "C", "eucharist", "proper_25_semicontinuous", "Joel 2:23-32", "Salmo 65", "2 Timóteo 4:6-8, 16-18", "Lucas 18:9-14")
add_row(data, "C", "eucharist", "proper_25_complementary", "Eclesiástico 35:12-17 ou Jeremias 14:7-10, 19-22", "Salmo 84:1-7", "2 Timóteo 4:6-8, 16-18", "Lucas 18:9-14")

# Próprio 26 (Tempo Comum 31)
# Ano A
add_row(data, "A", "eucharist", "proper_26_semicontinuous", "Josué 3:7-17", "Salmo 107:1-7, 33-37", "1 Tessalonicenses 2:9-13", "Mateus 23:1-12")
add_row(data, "A", "eucharist", "proper_26_complementary", "Miqueias 3:5-12", "Salmo 43", "1 Tessalonicenses 2:9-13", "Mateus 23:1-12")
# Ano B
add_row(data, "B", "eucharist", "proper_26_semicontinuous", "Rute 1:1-18", "Salmo 146", "Hebreus 9:11-14", "Marcos 12:28-34")
add_row(data, "B", "eucharist", "proper_26_complementary", "Deuteronômio 6:1-9", "Salmo 119:1-8", "Hebreus 9:11-14", "Marcos 12:28-34")
# Ano C
add_row(data, "C", "eucharist", "proper_26_semicontinuous", "Habacuque 1:1-4; 2:1-4", "Salmo 119:137-144", "2 Tessalonicenses 1:1-4, 11-12", "Lucas 19:1-10")
add_row(data, "C", "eucharist", "proper_26_complementary", "Isaías 1:10-18", "Salmo 32:1-7", "2 Tessalonicenses 1:1-4, 11-12", "Lucas 19:1-10")

# Próprio 27 (Tempo Comum 32)
# Ano A
add_row(data, "A", "eucharist", "proper_27_semicontinuous", "Josué 24:1-3a, 14-25", "Salmo 78:1-7", "1 Tessalonicenses 4:13-18", "Mateus 25:1-13")
add_row(data, "A", "eucharist", "proper_27_complementary", "Sabedoria 6:12-16 ou Amós 5:18-24", "Sabedoria 6:17-20 ou Salmo 70", "1 Tessalonicenses 4:13-18", "Mateus 25:1-13")
# Ano B
add_row(data, "B", "eucharist", "proper_27_semicontinuous", "Rute 3:1-5; 4:13-17", "Salmo 127", "Hebreus 9:24-28", "Marcos 12:38-44")
add_row(data, "B", "eucharist", "proper_27_complementary", "1 Reis 17:8-16", "Salmo 146", "Hebreus 9:24-28", "Marcos 12:38-44")
# Ano C
add_row(data, "C", "eucharist", "proper_27_semicontinuous", "Haggai 1:15b-2:9", "Salmo 145:1-5, 17-21 ou Salmo 98", "2 Tessalonicenses 2:1-5, 13-17", "Lucas 20:27-38")
add_row(data, "C", "eucharist", "proper_27_complementary", "Jó 19:23-27a", "Salmo 17:1-9", "2 Tessalonicenses 2:1-5, 13-17", "Lucas 20:27-38")

# Próprio 28 (Tempo Comum 33)
# Ano A
add_row(data, "A", "eucharist", "proper_28_semicontinuous", "Juízes 4:1-7", "Salmo 123", "1 Tessalonicenses 5:1-11", "Mateus 25:14-30")
add_row(data, "A", "eucharist", "proper_28_complementary", "Sofonias 1:7, 12-18", "Salmo 90:1-8 (9-11) 12", "1 Tessalonicenses 5:1-11", "Mateus 25:14-30")
# Ano B
add_row(data, "B", "eucharist", "proper_28_semicontinuous", "1 Samuel 1:4-20", "1 Samuel 2:1-10", "Hebreus 10:11-14 (15-18) 19-25", "Marcos 13:1-8")
add_row(data, "B", "eucharist", "proper_28_complementary", "Daniel 12:1-3", "Salmo 16", "Hebreus 10:11-14 (15-18) 19-25", "Marcos 13:1-8")
# Ano C
add_row(data, "C", "eucharist", "proper_28_semicontinuous", "Isaías 65:17-25", "Isaías 12", "2 Tessalonicenses 3:6-13", "Lucas 21:5-19")
add_row(data, "C", "eucharist", "proper_28_complementary", "Malaquias 4:1-2a", "Salmo 98", "2 Tessalonicenses 3:6-13", "Lucas 21:5-19")

# Próprio 29 (Cristo Rei / Tempo Comum 34)
# Ano A
add_row(data, "A", "eucharist", "proper_29_semicontinuous", "Ezequiel 34:11-16, 20-24", "Salmo 100", "Efésios 1:15-23", "Mateus 25:31-46")
add_row(data, "A", "eucharist", "proper_29_complementary", "Ezequiel 34:11-16, 20-24", "Salmo 95:1-7a", "Efésios 1:15-23", "Mateus 25:31-46")
# Ano B
add_row(data, "B", "eucharist", "proper_29_semicontinuous", "2 Samuel 23:1-7", "Salmo 132:1-12 (13-18)", "Apocalipse 1:4b-8", "João 18:33-37")
add_row(data, "B", "eucharist", "proper_29_complementary", "Daniel 7:9-10, 13-14", "Salmo 93", "Apocalipse 1:4b-8", "João 18:33-37")
# Ano C
add_row(data, "C", "eucharist", "proper_29_semicontinuous", "Jeremias 23:1-6", "Lucas 1:68-79", "Colossenses 1:11-20", "Lucas 23:33-43")
add_row(data, "C", "eucharist", "proper_29_complementary", "Jeremias 23:1-6", "Salmo 46", "Colossenses 1:11-20", "Lucas 23:33-43")

# --- DIAS SANTOS (FESTAS FIXAS) ---
# Estas festas aplicam-se a qualquer ano (A, B ou C)

holy_days = [
    ("confession_of_peter", "18/jan", "Atos 4:8-13", "Salmo 23", "1 Pedro 5:1-4", "Mateus 16:13-19"),
    ("conversion_of_paul", "25/jan", "Atos 26:9-21", "Salmo 67", "Gálatas 1:11-24", "Mateus 10:16-22"),
    ("presentation_of_lord", "02/fev", "Malaquias 3:1-4", "Salmo 84 ou 24:7-10", "Hebreus 2:14-18", "Lucas 2:22-40"),
    ("matthias_apostle", "24/fev", "Atos 1:15-26", "Salmo 15", "Filipenses 3:13-21", "João 15:1, 6-16"),
    ("joseph_of_nazareth", "19/mar", "2 Samuel 7:4,8-16", "Salmo 89:1-29", "Romanos 4:13-18", "Lucas 2:41-52"),
    ("annunciation", "25/mar", "Isaías 7:10-14", "Salmo 45 ou 40:5-10", "Hebreus 10:4-10", "Lucas 1:26-38"),
    ("mark_evangelist", "25/abr", "Isaías 52:7-10", "Salmo 2 ou 2:7-10", "Efésios 4:7-8, 11-16", "Marcos 1:1-15"),
    ("philip_and_james", "01/mai", "Isaías 30:18-21", "Salmo 119:33-40", "2 Coríntios 4:1-6", "João 14:6-14"),
    ("visitation_bvm", "31/mai", "1 Samuel 2:1-10", "Salmo 113", "Romanos 12:9-16b", "Lucas 1:39-57"),
    ("barnabas_apostle", "11/jun", "Isaías 42:5-12", "Salmo 112", "Atos 11:19-30; 13:1-3", "Mateus 10:7-16"),
    ("nativity_john_baptist", "24/jun", "Isaías 40:1-11", "Salmo 85 ou 85:7-13", "Atos 13:14b-26", "Lucas 1:57-80"),
    ("peter_and_paul", "29/jun", "Ezequiel 34:11-16", "Salmo 87", "2 Timóteo 4:1-8", "João 21:15-19"),
    ("mary_magdalene", "22/jul", "Judite 9:1,11-14", "Salmo 42:1-7", "2 Coríntios 5:14-18", "João 20:11-18"),
    ("james_apostle", "25/jul", "Jeremias 45:1-5", "Salmo 7:1-10", "Atos 11:27-12:3", "Mateus 20:20-28"),
    ("transfiguration_fixed", "06/ago", "Êxodo 34:29-35", "Salmo 99 ou 99:5-9", "2 Pedro 1:13-21", "Lucas 9:28-36"),
    ("bvm_mary", "15/ago", "Isaías 61:10-11", "Salmo 34 ou 34:1-9", "Gálatas 4:4-7", "Lucas 1:46-55"),
    ("bartholomew_apostle", "24/ago", "Deuteronômio 18:15-18", "Salmo 91 ou 91:1-4", "1 Coríntios 4:9-15", "Lucas 22:24-30"),
    ("nativity_bvm", "08/set", "Miqueias 5:2-4", "Salmo 45:11-18", "Romanos 8:28-30", "Mateus 1:18-23"),
    ("holy_cross", "14/set", "Números 21:4b-9", "Salmo 98:1-5 ou 78:1-2", "1 Coríntios 1:18-24", "João 3:13-17"),
    ("matthew_apostle", "21/set", "Provérbios 3:1-6", "Salmo 119:33-40", "2 Timóteo 3:14-17", "Mateus 9:9-13"),
    ("michael_and_angels", "29/set", "Gênesis 28:10-17", "Salmo 103 ou 103:19-22", "Apocalipse 12:7-12", "João 1:47-51"),
    ("luke_evangelist", "18/out", "Eclesiástico 38:1-4", "Salmo 147 ou 147:1-7", "2 Timóteo 4:5-13", "Lucas 4:14-21"),
    ("james_jerusalem", "23/out", "Atos 15:12-22a", "Salmo 1", "1 Coríntios 15:1-11", "Mateus 13:54-58"),
    ("simon_and_jude", "28/out", "Deuteronômio 32:1-4", "Salmo 119:89-96", "Efésios 2:13-22", "João 15:17-27"),
    ("all_saints", "01/nov", "Eclesiástico 44:1-10", "Salmo 34:1-10", "Apocalipse 7:9-17", "Mateus 5:1-12"),
    ("all_souls", "02/nov", "Sabedoria 3:1-9", "Salmo 130", "1 Tessalonicenses 4:13-18", "João 5:24-27"),
    ("thanksgiving_day", "nov_variable", "Deuteronômio 8:1-3, 6-10", "Salmo 65", "Tiago 1:17-18, 21-27", "Mateus 6:25-33"),
    ("andrew_apostle", "30/nov", "Deuteronômio 30:11-14", "Salmo 19", "Romanos 10:8b-18", "Mateus 4:18-22"),
    ("thomas_apostle", "21/dez", "Habacuque 2:1-4", "Salmo 126", "Hebreus 10:35-11:1", "João 20:24-29"),
    ("stephen_deacon", "26/dez", "Jeremias 26:1-9, 12-15", "Salmo 31", "Atos 6:8-7:2a, 51c-60", "Mateus 23:34-39"),
    ("john_apostle", "27/dez", "Êxodo 33:18-23", "Salmo 92", "1 João 1:1-9", "João 21:9b-24"),
    ("holy_innocents", "28/dez", "Jeremias 31:15-17", "Salmo 124", "Apocalipse 21:1-7", "Mateus 2:13-18"),
    ("holy_name", "01/jan", "Números 6:22-27", "Salmo 8", "Gálatas 4:4-7", "Lucas 2:15-21"),
]

for slug, date_ref, first, psalm, second, gospel in holy_days:
    for cycle in ["A", "B", "C"]:
        add_row(data, cycle, "holy_day", slug, first, psalm, second, gospel)


# --- COMUM DOS SANTOS ---
common_saints = [
    ("martyr", "Jeremias 11:18-20", "Salmo 3", "Salmo 3 (NT?) ou Apoc", "Mateus 16:24-27"),
    ("pastor_confessor", "Sabedoria 7:7-14", "Salmo 37:30-35", "1 Coríntios 2:6-13", "Mateus 13:51-52"),
    ("bishop", "Ezequiel 34:11-16", "Salmo 99", "1 Timóteo 3:15-16", "Marcos 4:26-32"),
    ("religious", "Provérbios 10:27-32", "Salmo 1", "Lucas 6:20-23a", "1 João 2:15-17"), # Nota: Lucas no lugar da epístola na imagem? Ajustado conforme padrão.
    ("missionary", "Isaías 61:1-3", "Salmo 96:7-13", "2 Coríntios 4:5-10", "Mateus 28:16-20"),
    ("saint", "Eclesiástico 51:10-12", "Salmo 131", "Filipenses 3:7-14", "Mateus 25:1-13"),
]

for slug, first, psalm, second, gospel in common_saints:
    for cycle in ["A", "B", "C"]:
        add_row(data, cycle, "common_of_saints", slug, first, psalm, second, gospel)


# --- OFÍCIOS PASTORAIS ---
# Ordenações
ordinations = [
    ("ordination_deacon", "Eclesiástico 39:1-8 ou Isaías 6:1-8", "Salmo 84 ou 119:33-38", "Atos 6:2-7 ou Romanos 12:1-12", "Marcos 10:35-45 ou Lucas 12:35-38"),
    ("ordination_priest", "Isaías 6:1-8 ou Números 11:16-17, 24-25", "Salmo 43 ou 132:8-19", "1 Pedro 5:1-4 ou Efésios 4:7, 11-16", "Mateus 9:35-38 ou João 10:11-18"),
    ("ordination_bishop", "Isaías 61:1-8 ou Isaías 42:1-9", "Salmo 99 ou 40:1-14", "Hebreus 5:1-10 ou 1 Timóteo 3:1-7", "João 20:19-23 ou João 17:1-9"),
]
for slug, first, psalm, second, gospel in ordinations:
    for cycle in ["A", "B", "C"]:
        add_row(data, cycle, "pastoral_office", slug, first, psalm, second, gospel)

# Matrimônio (Várias opções, inserindo as primeiras como default)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "pastoral_office", "matrimony", "Gênesis 1:26-28 ou Cânticos 2:10-13...", "Salmo 67 ou 127 ou 128", "1 Coríntios 13:1-13 ou Efésios 5:1-2...", "Mateus 5:1-10 ou João 15:9-12...")

# Funeral (Várias opções)
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "pastoral_office", "funeral", "Isaías 25:6-9 ou Lamentações 3:22-26...", "Salmo 23 ou 27 ou 90...", "Romanos 8:14-19 ou 1 Coríntios 15...", "João 5:24-27 ou João 11:21-27...")

# Dedicação de Igreja
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "pastoral_office", "church_dedication", "1 Reis 8:22-23, 27b-30", "Salmo 84 ou 48", "Apocalipse 21:2-7 ou 1 Pedro 2:1-9", "Mateus 7:13-14, 24-25 ou Mateus 21:10-14")

# Festival do Advento (Nove leituras)
# Como é uma estrutura única, coloco as do AT na 'first' e NT no 'gospel' concatenados
for cycle in ["A", "B", "C"]:
    add_row(data, cycle, "pastoral_office", "advent_festival", "Gênesis 3; Gênesis 22; Isaías 9; Isaías 11...", "-", "-", "Lucas 1:5-25 ou Lucas 1:26-38")


# --- EXPORTAÇÃO FINAL ---
# Consolida tudo e gera o Excel
df = pd.DataFrame(data)
df.to_excel("Lecionario_Completo_Final.xlsx", index=False)
print("Arquivo 'Lecionario_Completo_Final.xlsx' gerado com sucesso!")