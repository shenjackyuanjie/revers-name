const { JSDOM } = require('jsdom');
const jsdom=require('jsdom');
const fs = require('fs');
const path = require('path');

async function test(str){ 
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
    // 在你的 JSDOM 初始化代码之前
    let resolvePromise;

    // 创建一个 Promise，它会在 window.resolve 被调用时解决
    const resolver = new Promise(resolve => {
        resolvePromise = resolve;
    });
    const virtualConsole = new jsdom.VirtualConsole();
    const dom = new JSDOM(fs.readFileSync(path.join(__dirname, 'static/md5.html'), 'utf-8'), {
        url: 'file://' + path.join(__dirname, 'static/'),
        console:virtualConsole,
        runScripts: 'dangerously',
        resources: 'usable',
        beforeParse(window) {
            window.FakelocalStorage = localStorageMock;
            window.config =[{"count":5000,"score":10}];
            window.name_input = str;
            window.stage = 0;
            window.skillData = [];
            window.resolve = (...args) => {
                console.log(args);
                resolvePromise(args);
                window.close();
            }
        }
    });

    virtualConsole.on('log', (message) => {
        console.log('From the page:', message);
    });

    const result = await resolver
    console.log(result)
}


//str="!test!\n!\n\n11@qwerb\n\n1233";
str="!test!\n!\n\n11@qwerb\n\n1233";
test(str)

