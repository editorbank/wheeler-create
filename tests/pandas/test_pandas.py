import pandas as pd
import filecmp

def test_1(tmp_path):
  print(tmp_path)
  tmp_excel_filename = str(tmp_path / "test20.xlsx")
  tmp_csv_filename = str(tmp_path / "test20.csv")

  df = pd.read_csv("data/test20.csv")
  df.to_excel(tmp_excel_filename, index=False)
  df = pd.read_excel(tmp_excel_filename) 
  df.to_csv(tmp_csv_filename, index=False, lineterminator='\n')
  assert filecmp.cmp("data/test20.csv",tmp_csv_filename)

if __name__ == "__main__":
  import pathlib, os, shutil
  tmp_path = pathlib.Path(".tmp")
  os.makedirs(tmp_path, exist_ok=True)
  test_1(tmp_path=tmp_path)
  shutil.rmtree(tmp_path, ignore_errors=True)
