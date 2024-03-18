const { JSDOM } = require('jsdom');
const chalk = require('chalk');
const path = require('path');
const fs = require('fs');

const config = JSON.parse(fs.readFileSync('./config.json'));
const testString = {
	QP: '!test!\n!\n\n$name',
	QD: '!test!\n!\n\n$name\n$name',
	PP: '!test!\n\n$name',
	PD: '!test!\n\n$name\n$name',
}
const id = process.argv[2];

console.log(chalk`{gray child {bold ${id}} started.}`);
process.on('message', ([mode, name]) => {
	try {
		console.log(chalk`{magentaBright [${id}] ${name} ${mode} started.}`)
		
		// 创建一个简单的localStorage模拟
		const localStorageMock = {
			setItem: function (key, value) {
			this[key] = value;
			},
			getItem: function (key) {
			return this[key] || null;
			},
			removeItem: function (key) {
			delete this[key];
			},
			clear: function () {
			for (const key in this) {
				if (this.hasOwnProperty(key) && key !== 'setItem' && key !== 'getItem' && key !== 'removeItem' && key !== 'clear') {
				delete this[key];
				}
			}
			}
		};

		new JSDOM(fs.readFileSync(path.join(__dirname, 'static/md5.html'), 'utf-8'), {
			url: 'file://' + path.join(__dirname, 'static/'),
			runScripts: 'dangerously',
			resources: 'usable',
			beforeParse(window) {
				window.FakelocalStorage = localStorageMock;
				window.config = config[mode].thresholds;
				window.name_input = testString[mode].replace(/\$name/g, name);
				window.stage = 0;
				window.skillData = [];
				window.resolve = (...args) => {
					process.send(args);
					window.close();
				};
				window.output = (...message) => {
					console.log('page:', message);
				};
			}
		});
	} catch (e) {
		console.error(e);
	}
});
// dom.window.onload = () => {
// 	console.log(dom.window.document.body.outerHTML)
// }

// const window = await new Promise(resolve => dom.window.document.addEventListener('DOMContentLoaded', () => console.log(dom.window.document.body.outerHTML)));