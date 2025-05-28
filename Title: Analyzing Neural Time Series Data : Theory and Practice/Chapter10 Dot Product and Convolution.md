## Chapter 10 Dot Product and Convolution 

## Convolution  

Once vector is considered as a `signal`  <br>
The other one is considered as a `kernal` <br> 

Convolution is performed by computing the dot product between two vectors, shifting one vector in time relative to the other vector <br>

![image](https://github.com/user-attachments/assets/2fe5a171-0f78-474c-bf22-46b237d7bd9c)

![image](https://github.com/user-attachments/assets/8b156246-df07-4733-b127-564e69c2b96b)


The square wave is the signal, and the five-point linear decay function is the kernal. <br> 
Taking the kernal,flipping it backward, and then dragging it forward in time so it passess over the signal.<br> 
As it passess over the signal, it drags on the signal and the result of the drag is something looks a bit like each of them <br> 

![image](https://github.com/user-attachments/assets/9756e72d-40d3-4a6a-b94f-07d41e05bb23)
![image](https://github.com/user-attachments/assets/25f1231f-f41f-47ec-83f8-32e79c578a54)
If line up kernal and the data that have leftmost points overlapping and continue computing dot products until the kernal and the signal have their rightmost points overlapping, the results of the convolution contains  fewer points than the signal. <br> 

In this case, zeros are added before the start of the signal. <br> 
The result of convolution is one-hal of the length of the kernal too long in the beginning and one-half of the length of the kernal too long at the end. <br> 
The result of the convolution will be  `length(signal)+length(kernal)-1` <br> 
The dot product is placed in a position corresponding to the center of the kernal. <br>

postconvolution scaling is not the same thing as mean-centering the kernal before convolution. <br> 
the mean-centered kernel will produce a different convolution result because it will have negative numbers. <br> 

![image](https://github.com/user-attachments/assets/cf1d2530-b06a-45cb-b003-7533fe35b95a)

`a` and `b` are the two vectors <br> 
*k* refers to the convolution at time point k <br>
*i* corresponds to the elements in the equal-length parts of vectors `a` and `b` <br> 
vector b is the kernal because it is flipped backward, which is the effect of `k-i` <br>
![image](https://github.com/user-attachments/assets/82619c9c-6c73-428f-91c6-4f88715397a9)




