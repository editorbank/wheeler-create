import pandas as pd
import filecmp
import os

def setup_module(module):
    os.makedirs(".tmp", exist_ok=True)

def test_1():
	df = pd.read_csv("data/test20.csv")
	df.to_excel(".tmp/test20.xlsx", index=False)
	df = pd.read_excel(".tmp/test20.xlsx") 
	df.to_csv(".tmp/test20.csv", index=False)
	assert filecmp.cmp("data/test20.csv",".tmp/test20.csv")
