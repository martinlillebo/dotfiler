import time
cb = clipboard.get_clipboard()
clipboard.fill_clipboard("👍")
keyboard.send_keys("<ctrl>+v")

time.sleep(.1)
clipboard.fill_clipboard(cb)
