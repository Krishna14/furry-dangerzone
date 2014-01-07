from PIL import Image
import numpy as np

def main():
	raw_input("give the name of the file ")
	original = Image.open("image.png")
	thresholding(original)

def thresholding(original):
	converted_img = original.convert('L')
	ndarr = np.array(converted_img)
	ndarr = ndarr<100
	ndarr = ndarr.astype(np.uint8)

	imported_img = Image.fromarray(ndarr)
	imported_img.show()

