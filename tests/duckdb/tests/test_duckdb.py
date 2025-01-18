import duckdb
import pandas as pd

def test_read_csv():
	result = duckdb.read_csv("data/test20.csv")
	print(result)

def test_select_from_pandas():
	pandas_df = pd.DataFrame({"a": [42]})
	result = duckdb.sql("SELECT * FROM pandas_df")
	print(result)


if __name__ == '__main__' :
	test_read_csv()
	test_select_from_pandas()