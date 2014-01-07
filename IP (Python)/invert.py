from PIL import Image
from pylab import *
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
img = array(Image.open('lena.jpeg').convert('L'))

img2 = 255 - img; #Invert the image
imshow(img2)
show()
raw_input("Enter something")
img3 = (100.0/255) * img + 100 #Clamping the interval from  100 to 200
imshow(img3)
show()
raw_input("Enter Something")
img4 = 255.0 * (img/255.0)**2 #Squaring the image
imshow(img4)
show()