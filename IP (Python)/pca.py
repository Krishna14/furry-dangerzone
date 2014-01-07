def pca(X):
	"""Principal Component Analysis
	   input: X,matrix with training data stored as flattened arrays in rows
	   return: projection matrix (with important dimensions first), variance and mean
	"""

	#Get dimensions
	num_data, dim = X.shape

	#center data
	mean_X = X.mean(axis=0)
	X = X - mean_X

	if dim>num_data:
		#PCA - compact trick used
		M = dot(X,X.T)#Covariance Matrix
		e, EV = linalg.eigh(M)#Eigenvalues and eigenvectors 
		tmp = dot(X.T,EV).T #this is the compact trick
		V = tmp[::-1] #Reverse since last eigenvectors are the ones we need
		S = sqrt(e)[::-1] #Reverse since eigenvaluesare n increasing order
		for i in range(V.shape[1]):
			V[:,i] /= S
	else:
		#PCA - SVD used
		U,S,V = linalg.svd(X)
		V = V[:num_data] #Only makes sense to return the first num_data

		#return the projection matrix,the variance and mean 
	return V,S,mean_X

