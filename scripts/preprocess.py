countries_list = pd.read_csv('countries of the world.csv') #https://www.kaggle.com/fernandol/countries-of-the-world
for col in countries_list.columns:
    print(col)
countries_list = countries_list[['Country', 'GDP ($ per capita)']]
countries_list = countries_list.dropna()
countries_list['Country'] = countries_list['Country'].apply(lambda x: x.rstrip())
countries_list.rename(columns={'GDP ($ per capita)': 'GDP'}, inplace=True)

countries_code = pd.read_csv('countries_codes_and_coordinates.csv') # https://gist.github.com/tadast/8827699
countries_code = countries_code[['Country', 'Alpha-2 code', 'Latitude (average)', 'Longitude (average)']]
countries_code = countries_code.dropna()
countries_code.rename(columns={'Alpha-2 code': 'countryCode', 'Latitude (average)' : 'Latitude', 'Longitude (average)' : 'Longitude'}, inplace=True)
countries_code['Latitude'] = countries_code['Latitude'].apply(lambda x: x.replace('"', ''))
countries_code['Longitude'] = countries_code['Longitude'].apply(lambda x: x.replace('"', ''))
countries_code['countryCode'] = countries_code['countryCode'].apply(lambda x: x.replace('"', ''))

countries = countries_code.merge(countries_list, how = 'inner', on = ['Country'])

airports = pd.read_csv('Airports.csv') #https://github.com/tugraz-isds/datasets/blob/master/airports_airlines/Airports.csv
airports.drop(columns=[' ICAO', ' DST'], inplace = True)
airports = airports.dropna() #if contain any empty value
airports.rename(columns={'#Name': 'name', ' Country': 'countryName', ' City' : 'City', ' IATA' : 'IATA', ' Latitude': 'Latitude',
' Longtitude': 'Longtitude', ' Altitude': 'Altitude', ' Timezone': 'Timezone'}, inplace=True)
airports = airports[airports.countryName.isin(countries.Country)]

airlines = pd.read_csv('airlines.csv') #https://www.kaggle.com/open-flights/airline-database
airlines.drop(columns=['Alias','ICAO','Callsign', 'Airline ID'], inplace = True)
airlines = airlines.dropna() #if contain any empty value
airlines.rename(columns={'Country': 'countryName', 'Active': 'activeStatus'}, inplace=True)

routes = pd.read_csv('routes.csv') #https://www.kaggle.com/open-flights/flight-route-database
routes = routes[['airline', ' source airport', ' destination apirport']]
routes = routes.dropna() #if contain any empty value
routes.rename(columns={' source airport': 'departureCode', ' destination apirport': 'arrivalCode'}, inplace=True)

routes = routes[routes.departureCode.isin(airports.IATA)]
routes = routes[routes.arrivalCode.isin(airports.IATA)]
routes = routes[routes.airline.isin(airlines.IATA)]

airlines.to_csv('airlines_preprocessed.csv', index = False)
airports.to_csv('airports_preprocessed.csv', index = False)
routes.to_csv('routes_preprocessed.csv', index = False)
countries.to_csv('countries_preprocessed.csv', index = False)
