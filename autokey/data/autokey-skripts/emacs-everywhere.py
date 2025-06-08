import subprocess
time.sleep(0.1)  # 100 ms delay
subprocess.Popen(['emacsclient', '--eval', '(emacs-everywhere)'])