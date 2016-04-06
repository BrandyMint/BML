import path from 'path';
import webpack from 'webpack';
import StatsPlugin from 'stats-webpack-plugin';

// must match config.webpack.dev_server.port
const devServerPort = 3000;

// set TARGET=production on the environment to add asset fingerprints
const production = process.env.TARGET === 'production';

const root = path.join(__dirname, '..', 'app/assets/javascripts/');

const loaders = [
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

const config = {
  entry: {
    // Sources are expected to live in $app_root/webpack
		'vendors':     './app/assets/javascripts/vendor.js'
    // 'application': './app/assets/javascripts/application.coffee'
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, '..', 'public', 'assets'),
    publicPath: '/assets/',

    // filename: '[name]-bundle-[hash].js',
    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

	module: {
		preLoaders: [
			{
				test: /\.jsx?$/,
				loader: "eslint-loader",
				exclude: /node_modules|vendor\/components/,
			},
		],
		loaders: loaders,
	},

  resolve: {
    root: root,
		modulesDirectories: ["web_modules", "node_modules", "vendor/components"],
		extensions: ['', '.js', '.jsx'],
  },

  plugins: [
		new webpack.ProvidePlugin({
			$: 'jquery',
			jQuery: 'jquery',
		}),
		new webpack.HotModuleReplacementPlugin(),
		new webpack.ResolverPlugin([
			new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('.bower.json', ['main'])
		]),
		new webpack.DefinePlugin({
			// __VERSION__: `"${VERSION}"`,
			__CLIENT__: true,
			__SERVER__: false,
			__FAKE_API__: false,
			__ENV__: '"development"',
		}),
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    })]
};

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'cheap-module-eval-source-map';
}

module.exports = config;
