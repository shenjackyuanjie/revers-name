const { JSDOM } = require('jsdom');
const chalk = require('chalk');
const path = require('path');
const fs = require('fs');


		
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

const config = JSON.parse(fs.readFileSync('./config.json'));
const testString = {
	QP: '!test!\n!\n\n$name',
	QD: '!test!\n!\n\n$name\n$name',
	PP: '!test!\n\n$name',
	PD: '!test!\n\n$name\n$name',
	CQD:'!test!\n\n$name1\n\n$name2',
}
const id = process.argv[2];
const cqd_name_list=[
	'VIMYKPJ@Stellar',
'29gvF!x@Miracle',
'Bishop ARFXGATH@Miracle',
'5UWSX0DGRE5pTA9@新纪元',
'YKOQFMNYLNPVWWD@SZ',
'余烬OYXo7e7y4@SZ',
'Mriiwm@frisk',
'AYdcjm@mwh_',
'公主 #07648027020@星光水晶焰',
'gnHHXmi@TigerStar',
'ddlezlmx@Helias',
'<input><br>ce0Y2rz@powerless',
'HQWWJYUHIGAVNP@霛雲',
'2EHKR7OYZ1JVY1@霛雲',
'vRuH:z@耗子尾汁',
'千矢 ZJUCVBFW@琪拉拉',
'大油包 #PXDHVJAT@暗黑突击',
'风史莱姆 #NQLTZLWD@暗黑突击',
'史莱德 #XPMTVPKY@暗黑突击',
'咲恋 ZPSFFQXQ@公主连结',
'Paloma SFCHPFOCH@Nostalgia',
'StezenFieven CPpISxdaSs@Nostalgia',
'光Yvxf2hGRv1Vf@fAIgFUL',
'RXuW4iX@fAIgFUL',
'm@fAIgFUL',
'飑Wcajsvb92asO@Squall',
'江DuDSKcYnD3nB@Squall',
'光YLqKf5rv9EU9lnc@Squall',
'对立IwncPEvanX1cFCl@Squall',
'风花雪月mrEm6W2F@酸橙',
'空 #b4WkVBd1t@酸橙',
'y_xbgL@酸橙',
'朔晖BLIPVEXGA@涵虚',
'星垂TTTNBWYUM@涵虚',
'月涌PDDYWVQSV@涵虚',
'震泽IZIGCSOIU@涵虚',
'iqYDJWy@cyclone',
'Iwn<Zo@nan',
'U>7D3Ol7uWKIfTC@XJ联队'
]
console.log(chalk`{gray child {bold ${id}} started.}`);
process.on('message', ([mode, name]) => {
	
	try {
		console.log(chalk`{magentaBright [${id}] ${name} ${mode} started.}`)
		if(mode != "CQD"){
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
					}
				}
			});
		}else if(mode == "CQD"){
			var results=[]
			for(i=0;i<cqd_name_list.length;i++){
				var opponent=cqd_name_list[i]
				new JSDOM(fs.readFileSync(path.join(__dirname, 'static/md5.html'), 'utf-8'), {
					url: 'file://' + path.join(__dirname, 'static/'),
					runScripts: 'dangerously',
					resources: 'usable',
					beforeParse(window) {
						window.FakelocalStorage = localStorageMock;
						window.config = config[mode].thresholds;
						window.name_input = testString[mode].replace(/\$name1/g, name).replace(/\$name2/g, opponent);
						window.stage = 0;
						window.skillData = [];
						window.resolve = (...args) => {
							console.log(results)
							results.push(args[2]);
							window.close();
						}
					}
				});
			}

			console.log(results)
		}
	} catch (e) {
		console.error(e);
	}
});
// dom.window.onload = () => {
// 	console.log(dom.window.document.body.outerHTML)
// }

// const window = await new Promise(resolve => dom.window.document.addEventListener('DOMContentLoaded', () => console.log(dom.window.document.body.outerHTML)));