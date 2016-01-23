const fs = require('fs');
const screenshot = require('screenshot-stream');

const idx = 2;
const url = process.argv[idx + 0];

const size = process.argv[idx + 1];
const file = process.argv[idx + 2];

console.log('Make a screenshot of', url, 'with size', size, 'to', file);
const stream = screenshot(url, size, { format: 'png', delay: 10 });

stream.pipe(fs.createWriteStream(file));

console.log('Fininsh');
