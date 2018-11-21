import React from 'react';
import { StyleSheet, Text, TextInput, View, Button } from 'react-native';
import {searchCity} from './OpenWeatherAPI'

export default class WeatherInfo extends React.Component {
 
 constructor(props) {
  super(props)
  this.state = {
    results: [],
    cityName: '',
    temperature: '',
    humidity: '', 
    pressure: '',
  }
 }

  search = (cityName) => {
    searchCity(cityName) 
    .then(results => {
      console.log(results)
      this.setState({
        results:results,
        temperature: results.temp,
        humidity: results.humidity,
        pressure:results.pressure
   
      })
    })
  }

  searchButtonPressed = () => {
    this.search(this.state.text)
  }


  render() {
    return (
      <View style = {styles.container}>
           <TextInput
          style={styles.input}
          placeholder='enter a city'
          clearButtonMode='while-editing'
          textAlign={'center'}
          autoCapitalize='none'
          autoCorrect={false}
          onChangeText={(text) => this.setState({
                                    text: text
                                  })}
        />

      <Button
      title="Search"
      style={styles.button}
      onPress={() => this.searchButtonPressed()}

      />

      <Text style={styles.response}> Temp: {this.state.temperature} </Text>
      <Text style={styles.response}> Humidity: {this.state.humidity} </Text>
      <Text style={styles.response}> Pressure: {this.state.pressure} </Text>

      </View>

    );
  }
}

const styles = StyleSheet.create({

  title: {
    fontSize: 25,
    fontWeight: '900',
    color: 'black'
  },

  input: {
    backgroundColor: 'white',
    height: 64,
    width: 150,
    fontSize: 20,
  },

  response:{
    fontSize: 30,
    fontFamily: 'Avenir',
    paddingTop: 10
  },

  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
