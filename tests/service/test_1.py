def sh(cmd):
    import subprocess
    print(cmd.split())
    result = subprocess.run(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    print(f"Вывод: {result.stdout}")
    print(f"Ошибка: {result.stderr if result.stderr else 'Ошибок нет.'}")

def test_1():
    sh("python -B ./test_service.py start")
    sh("python -B ./test_service.py status")
    sh("python -B ./test_service.py stop")
    sh("python -B ./test_service.py status")

if __name__ == "__main__":
    test_1()