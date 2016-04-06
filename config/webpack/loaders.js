export default [
  {
    test: /\.woff(2)?(\?.*)?$/,
    loader: 'file-loader?limit=10000&minetype=application/font-woff&name=fonts/[name].[ext]?[hash]',
  },
  {
    test: /\.(ttf|eot|svg)(\?.*)?$/,
    loader: 'file-loader?name=fonts/[name].[ext]?[hash]',
  },
  {
    test: /\.jsx?$/,
    loader: 'babel',
    // include: [root],
  },
  {
    test: /\.jpg/,
    loader: 'file-loader?limit=10000!img&properties=true&name=[path][name].[ext]?[hash]',
  },
  {
    test: /\.gif$/,
    loader: 'file-loader?mimetype=image/png&name=[path][name].[ext]?[hash]',
  },
  {
    test: /\.coffee/,
    loader: 'coffee-loader',
  },
  {
    test: /\.json/,
    loader: 'json-loader',
  },
  {
    test: /\.css$/,
    loaders: ['style', 'css', 'postcss'],
    include: root,
  },
  {
    test: /\.s(a|c)ss$/,
    loaders: ['style', 'css', 'sass'],
  },
  {
    test: /\.less$/,
    loaders: ['style', 'css', 'less'],
  },
  {
    test: require.resolve('jquery'),
    loader: 'expose?jQuery',
  },
  {
    test: require.resolve('jquery'),
    loader: 'expose?$',
  },
  {
    test: require.resolve('i18next'),
    loader: 'expose?i18n',
  },
];


