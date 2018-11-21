


export async function searchCity(cityName) {
	const apiKey = 'c6c2fb6416c5daab3eb0b698b5404a88'
	const openWeatherSearchURL = 'https://api.openweathermap.org/data/2.5/weather?q=' + cityName
	+ '&appid=' + apiKey + '&units=imperial'

  try {
    let response = await fetch(
      openWeatherSearchURL
    );
    let responseJson = await response.json();
    console.log(responseJson)
    return responseJson['main'];
  } catch (error) {
    console.error(error);
  }
}