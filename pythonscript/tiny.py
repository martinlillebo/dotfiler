import requests

def tinyurl(url, ref):
	base_url = 'http://tinyurl.com/api-create.php?url='
	url = base_url + url
	r = requests.get(url)
	url = r.text
	print(f"[{ref}]({url})")
