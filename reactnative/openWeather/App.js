import React from 'react';
import { StyleSheet, Text, View, TextInput, Button, TouchableHighlight} from 'react-native';
import WeatherInfo from './WeatherInfo';


export default class App extends React.Component {

  render() {
    return (
     <View style ={styles.container}> 

      <WeatherInfo />

     </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
