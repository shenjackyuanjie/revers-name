# 某个游戏的 js 的逆向工程

## `md5.js`

- [ ] 清理所有空函数
  - `function [a-zA-Z0-9]*\(\) \{ \}`
  - 3/202
  
- 清理无用/兼容函数
  - `setFunctionNamesIfNecessary`
  - `convertAllToFastObject`
  - `convertToFastObject`

- 清理一些函数
  - [ ] `P.p` (svg 函数)
  - [x] `z` (检查环境函数)
  - [x] `H.ve` -> `H.printString`
  - [x] `P.H` - `P.Object_` 
    - `H.k(a)` -> `to_string_0(a)`
    - `$iH` -> `$isObject`
    - `H.aW` -> `H.equal_1`

- `H`
  - `iD` -> `find_type`
  - `iw` -> `universe_eval`
  - `aW` -> `equal_1`
  - `og` -> `parser_parse`
  - `aW` -> `Rti`
  - `u2`-> `universe_create_generic_function_rti`

- [ ] And more

## `index.dart.js`

- [ ] 清理所有空函数
  - `function [a-zA-Z0-9]*\(\) \{ \}`
  - 0/177

- [ ] And more
