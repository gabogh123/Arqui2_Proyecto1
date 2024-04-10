from pydub import AudioSegment
import numpy as np

def fir(audio, num_taps):
    # Convertir el AudioSegment a un array NumPy
    audio_array = np.array(audio.get_array_of_samples())

    # Crear un array para el efecto de reverberación con ceros
    salida = np.zeros_like(audio_array)
    coeficientes  = np.random.uniform(-1, 1, num_taps)
    cont = 0
    N = num_taps
    r2 = 0
    while cont < N-1:
        r1 = audio_array[cont]*coeficientes[cont]
        r2 = r2 + r1
        salida[cont] = r2
        cont = cont + 1

    while cont < len(audio_array):
        Ntemp = N-1
        r2 = 0
        while Ntemp>=0:
            r1 = coeficientes[Ntemp]*audio_array[cont - Ntemp]
            r2 = r2 + r1
            Ntemp = Ntemp - 1
        salida[cont] = r2
        cont = cont + 1
            
    print()
    # Crear un nuevo AudioSegment con el audio modificado
    audio_modificado = AudioSegment(
        salida.tobytes(),
        frame_rate=audio.frame_rate,
        sample_width=audio.sample_width,
        channels=audio.channels
    )
    np.savetxt('audio_array.txt', salida)
    return audio_modificado

# Cargar el archivo de audio de entrada
entrada = AudioSegment.from_file("./sample.mp3")

# Definir el retardo y la atenuación
n = 16  # Ajusta el numero de coeficientes

# Agregar reverberación al audio de entrada
audio_filtrado = fir(entrada, n)

# Guardar el audio con reverberación
audio_filtrado.export("AudioFiltrado.wav", format="wav")