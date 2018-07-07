
# Fast Algorithm for the 3-D DCT

2D Discrete Cosine Transform (2D-DCT) is well know and wide used algorithm for imgage compression. All logic behind jpeg compression is based on DCT. We can also implement DCT on 3D matrix such as videos. In that project, we reimplement some part of the paper which was on fast versions of 3D DCT and its inverse method named 3D IDCT. To show the accuracy of the code, we did test both standart and fast method of 3d DCT on random generated 32x32x32 matrix. To see that test please run following script;
```matlab
> main_test
```
Then the result will be something like that
```matlab
Time conpumstion for 32x32x32 matrix DCT with ordinary alg :81.6705 sec
Time conpumstion for 32x32x32 matrix DCT with fast alg :1.87874 sec
difference between fast and ordinary ones output: 9.58882e-13
```
 



![Alt Text](result.gif)
