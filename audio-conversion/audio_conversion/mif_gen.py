import numpy as np
from pydub import AudioSegment




def generate_mif_file(file_name, data_width, depth, datos):
    with open(file_name, 'w') as mif_file:
        mif_file.write(f"DEPTH = {depth};\n")
        mif_file.write(f"WIDTH = {data_width};\n")
        mif_file.write("ADDRESS_RADIX = HEX;\n")
        mif_file.write("DATA_RADIX = BIN;\n")
        mif_file.write("CONTENT\n")
        mif_file.write("BEGIN\n")
        dato = 0
        for address in range(depth):
            # Escribir la direccion
            mif_file.write(f"{address:05X} : ")
            # Escribir los 16 datos de la direccion
            for i in range(16):
                data = decimal_to_fixed_point(datos[dato])
                mif_file.write(f"{data}")
                dato = dato + 1
            mif_file.write("\n")
        mif_file.write("END;\n")



def decimal_to_fixed_point(num):
    # Multiplica por 2^8 para convertir la parte fraccionaria a 8 bits
    fixed_point = int(abs(num) * (2 ** 8))
    # Asegúrate de que esté dentro del rango permitido
    fixed_point = max(min(fixed_point, 2**15 - 1), -2**15)
    # Convierte a binario de 16 bits (8 bits enteros + 8 bits fraccionarios)
    if (num < 0):
        sign = '1'
    else:
        sign = '0'
    binary_str = sign + '{:015b}'.format(fixed_point)
    return binary_str

#Se genera el array con los datos del audio
entrada = AudioSegment.from_file('G:/Documentos/S2024/Arqui/Proyecto1/Audio/Audio.mp3')
audio_array = np.array(entrada.get_array_of_samples())



# Encontrar el valor máximo y mínimo en el arreglo
max_value = np.max(audio_array)
min_value = np.min(audio_array)

# Se esacala para que los valores esten entre -1 y 1
scaled_arr = 2 * (audio_array - min_value) / (max_value - min_value) - 1
#restored_arr = 0.5 * (scaled_arr + 1) * (max_value - min_value) + min_value

#Se define la informacion para el .mif
depth = int(audio_array.size/16)


file_name = "G:/Documentos/S2024/Arqui/Proyecto1/Mifgen/entrada.mif"
data_width = 256  # Width of each memory location in bits


generate_mif_file(file_name, data_width, depth,scaled_arr)

#print(decimal_to_fixed_point())