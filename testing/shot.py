import sys
from PIL import Image

src, out = sys.argv[1], sys.argv[2]
img = Image.open(src).convert("RGB")
scale = 0.4
img = img.resize((int(img.width * scale), int(img.height * scale)), Image.LANCZOS)
img.save(out)
print(out, img.size)
