import orjson

reference_data_dict = {"Name": "Джон", "Age": 30, "город": "Нью-Йорк"}
reference_data_dict_sort = {"Name": "Джон", "Age": 30, "город": "Нью-Йорк"}
reference_json_bytes=b'{\n  "Age": 30,\n  "Name": "\xd0\x94\xd0\xb6\xd0\xbe\xd0\xbd",\n  "\xd0\xb3\xd0\xbe\xd1\x80\xd0\xbe\xd0\xb4": "\xd0\x9d\xd1\x8c\xd1\x8e-\xd0\x99\xd0\xbe\xd1\x80\xd0\xba"\n}'

def test_dumps():
    _json_bytes = orjson.dumps(reference_data_dict, option=orjson.OPT_SORT_KEYS | orjson.OPT_INDENT_2)
    assert _json_bytes == reference_json_bytes, "Fail test_dumps!"

def test_loads():
    _data_dict = orjson.loads(reference_json_bytes)
    print(_data_dict)
    assert _data_dict == reference_data_dict_sort, "Fail test_loads!"

if __name__ == "__main__":
    test_dumps()
    test_loads()
    print('OK')