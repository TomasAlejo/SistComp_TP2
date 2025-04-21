import requests
import subprocess

url = "https://api.worldbank.org/v2/en/country/AR/indicator/SI.POV.GINI?format=json&date=2011:2020&per_page=100"

response = requests.get(url)

if response.status_code == 200:
    data = response.json()

    if data and len(data) > 1:
        for entry in data[1]:
            gini_value = entry.get('value')
            year = entry.get('date')
            if gini_value is not None:
                print(f"Índice GINI para Argentina en {year}: {gini_value}")

                # Llamar a programa en C y pasarle el valor float
                result = subprocess.run(["./gini_process", str(gini_value)], capture_output=True, text=True)
                print(f"Resultado final procesado por C: {result.stdout.strip()}")
                break
        else:
            print("No se encontró ningún valor de índice GINI.")
    else:
        print("No se encontraron datos.")
else:
    print("Error al consultar la API.")