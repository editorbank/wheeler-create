def sh(cmd):
    import subprocess
    print(cmd)
    result = subprocess.run(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    print(result.stdout)
    if result.stderr:
        raise Exception(result.stderr)

def test_1():
    sh("python -B ./test_scikit-learn.py")

if __name__ == "__main__":
    test_1()