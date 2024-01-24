import requests

def obtener_precio_binance(base, quote):
    # Si la base y la cotización son la misma, el precio es siempre 1
    if base == quote:
        return 1.0

    # URL de la API de Binance para obtener precios
    url = f"https://api.binance.com/api/v3/ticker/price?symbol={base}{quote}"

    # Realizar la solicitud HTTP
    response = requests.get(url)

    # Convertir la respuesta a JSON
    data = response.json()

    # Comprobar si la clave 'price' existe en el diccionario
    if 'price' in data:
        return float(data['price'])
    else:
        return None

criptomonedas = ["BTC", "ETH", "USDT", "BNB", "SOL", "XRP", "USDC", "ADA", "DOGE", "LTC", "DAI"]

# Obtener el precio del dólar cripto en ARS
precio_dolar_cripto_ars = obtener_precio_binance("USDT", "ARS")

for criptomoneda in criptomonedas:
    # Obtener el precio de la criptomoneda en USDT
    precio_usdt = obtener_precio_binance(criptomoneda, "USDT")

    # Si el precio es None, la criptomoneda no está disponible en Binance
    if precio_usdt is None:
        print(f"La criptomoneda {criptomoneda} no está disponible en Binance.")
        continue

    # Convertir el precio de USDT a ARS
    precio_ars = precio_usdt * precio_dolar_cripto_ars

    # Formatear el precio como un número con dos decimales y comas como separadores de miles
    precio_ars_formateado = "{:,.2f}".format(precio_ars)

    print(f"{criptomoneda}: {precio_ars_formateado} ARS")

