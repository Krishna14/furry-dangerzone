import scipy.signal
import numpy as np 
import matplotlib.pyplot as plt 

img = plt.imread('image.png')
img /= 255

#making some kind of a kernel 
t = 1 - np.abs(np.linspace(-1, 1, 21))
kernel = t.reshape(21, 1) * t.reshape(1,21)
kernel /= kernel.sum()

#convolve 2d the kernel with each channel
r = scipy.signal.convolve2d(img[:, :, 0], kernel, mode = 'same')
g = scipy.signal.convolve2d(img[:, :, 1], kernel, mode = 'same')
b = scipy.signal.convolve2d(img[:, :, 2], kernel, mode = 'same')

#Stack the channels back into a 8bit colour depth image and plot it 
img_out = np.dstack([r , g, b])
img_out = (img_out*255).astype(np.uint8)

plot.subplot(2,1,1)
plt.imshow(img)
plt.subplot(2,1,2)
plt.imshow(img_out)
plt.show()
