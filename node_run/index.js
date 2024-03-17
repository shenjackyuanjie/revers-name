const child_process = require('child_process');
const chalk = require('chalk');
const path = require('path');
const fs = require('fs');

const low = require('lowdb');
const FileSync = require('lowdb/adapters/FileSync');

function replacer(_key, value) {
	if (value instanceof Set)
		return { dataType: 'Set', value: [...value] };
	return value;
}
function reviver(_key, value) {
	if (typeof value === 'object' && value !== null)
		if (value.dataType === 'Set') return new Set(value.value);
	return value;
}

const queueAdapter = new FileSync(path.resolve(__dirname, 'queue.json'), {
	serialize: obj => JSON.stringify(obj, replacer),
	deserialize: str => JSON.parse(str, reviver)
});
const queueDB = low(queueAdapter);
queueDB.defaults({ queue: new Set() }).write();

const dataAdapter = new FileSync(path.resolve(__dirname, 'data.json'));
const dataDB = low(dataAdapter);
dataDB.defaults({ data: {} }).write();

const fullQueue = queueDB.get('queue').value(); // remove after finished
const queue = new Set([...fullQueue]); // remove when processing

const config = JSON.parse(fs.readFileSync(path.resolve(__dirname, 'config.json')));
const idleThreads = new Set();
const threads = [];

var count = 0;
function addItem(name, mode) {
	if (dataDB.has(['data', name, mode]).value()) return;

	const item = [mode, name];
	dataDB.setWith(['data', name, mode], -1, Object).write();
	fullQueue.add(item);

	if (idleThreads.size) {
		var thread = idleThreads.values().next().value;

		item.processing = true;
		thread.item = item;
		thread.send(item);
		idleThreads.delete(thread);
	} else {
		queue.add(item);

		console.log(chalk`{cyanBright ${name} ${mode} pending.}`);
	}
	queueDB.write();
}

fs.readFileSync(path.resolve(__dirname, 'input.txt'), 'utf8').split('\n').forEach(name => {
	name = name.trim();
	if (name.length)
		for (var mode in config)
			if (config[mode].mode === 'preliminary') {
				if (dataDB.has(['data', name, mode]).value()) continue;

				dataDB.setWith(['data', name, mode], -1, Object).value();
				const item = [mode, name];
				fullQueue.add(item);
				queue.add(item);
			}
});
dataDB.write();
queueDB.write();

console.log(`queue size: ${fullQueue.size}`);

var it = queue.values();
for (var i = 0; i < config.threads; i++) {
	threads[i] = child_process.fork(path.resolve(__dirname, 'child.js'), [i]);
	threads[i].id = i;
	threads[i].on('message', function ([success, skills, score, last]) {
		const [mode, name] = this.item;
		fullQueue.delete(this.item);
		queueDB.write();

		count++;

		if (!success) {
			console.log(chalk`{redBright [${this.id}] ${name} ${mode} failed with score {bold ${score}} at {bold ${(last / 100).toFixed(2).replace(/\.?0+$/, '')}%}}`);

			dataDB.setWith(['data', name, mode], 0, Object).value();
			for (var [label, data] of skills)
				dataDB.setWith(['data', name, 'skills', label], data, Object).value();
			const obj = dataDB.get(['data', name]).value();
			
			var needDelete = true;
			for (var i in obj)
				if (i !== 'skills' && obj[i] !== 0) needDelete = false;
			if (needDelete)
				dataDB.unset(['data', name]).value();
		} else {
			console.log(chalk`{greenBright [${this.id}] ${name} ${mode} finished with score {bold ${score}}}.`);

			dataDB.setWith(['data', name, mode], score, Object).value();
			for (var [label, data] of skills)
				dataDB.setWith(['data', name, 'skills', label], data, Object).value();

			if (config[mode].mode === 'preliminary')
				for (var filteredMode in config)
					if (config[filteredMode].mode === 'filtered') addItem(name, filteredMode);
		}
		dataDB.write();

		if (queue.size) {
			var item = queue.values().next().value;
			item.processing = true;
			queue.delete(item);

			this.item = item;
			this.send(item);
		} else
			idleThreads.delete(this);

		console.log(chalk`{yellowBright {bold progress: ${count} / ${fullQueue.size + count}}}`);
		if (!fullQueue.size)
			console.log(chalk`{yellowBright {bold queue is empty.}}`);
	});

	idleThreads.add(threads[i]);

	var item = it.next().value;
	if (item) {
		item.processing = true;
		queue.delete(item);

		threads[i].item = item;
		threads[i].send(item);
		idleThreads.delete(threads[i]);
	}
}