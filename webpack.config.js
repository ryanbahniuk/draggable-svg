'use strict'

var path = require("path");

module.exports = {
  entry: {
    app: [
      './build/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname),
    publicPath: "/assets/",
    filename: '[name].bundle.js',
  },

  module: {
    loaders: [
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file?name=[name].[ext]',
      },

      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack',
      }
    ],

    noParse: /\.elm$/,
  },
  devServer: {
    stats: { colors: true },
    contentBase: './'
  }
};
