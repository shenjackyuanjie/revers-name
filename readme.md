# 某个游戏的 js 的逆向工程

## 一些交互结论

```text
h_(ll) -> HHbf -> 语言文件加载 session storage
h_(k) -> fYwD -> 名称输入 session storage
```

- `Z` -> `HtmlRenderer`
- `O`
  - `d` -> `get_obfuscated_value`
  - `eq` -> `obfuscate_str_h`

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

- `hunkHelpers`
  - `s` -> `mk_instance`
  - `r` -> `mk_static`

- `M`
  - `mB` -> `main_program`

- `H`
  - `iD` -> `find_type`
  - `iw` -> `universe_eval`
  - `aW` -> `equal_1`
  - `og` -> `parser_parse`
  - `aW` -> `Rti`
  - `u2`-> `universe_create_generic_function_rti`
  - `bN` -> `universe_install_type_tests`
  - `uk` -> `install_specialized_as_check`
  - `ul` -> `install_specialized_is_test`
  - `oi` -> `universe_lookup_function_rti`
  - `h` -> `throw_error`

- `T`
  - `X` -> str list

- `P`
  - `cu` -> `obfuscate_a_b`

- [ ] And more

## `index.dart.js`

- [ ] 清理所有空函数
  - `function [a-zA-Z0-9]*\(\) \{ \}`
  - 0/177

- `E`
  - `nu` -> `main_program`

- [ ] And more
