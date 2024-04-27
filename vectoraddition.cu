%%writefile cuda_example.cu
#include <bits/stdc++.h>
using namespace std;

__global__ void add(int *x, int *y, int *z)
{
    int id = blockIdx.x;
    z[id] = x[id] + y[id];
}

int main()
{
    int a[6]={1,2,3,4,5,6}, b[6]={1,2,3,4,5,6}, c[6], *d,*e,*f;

    int n=6;
   


    cudaMalloc((void**)&d,6*sizeof(int));
    cudaMalloc((void**)&e,6*sizeof(int));
    cudaMalloc((void**)&f,6*sizeof(int));

    cudaMemcpy(d,a,6*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(e,b,6*sizeof(int),cudaMemcpyHostToDevice);

    add<<<6,1>>>(d,e,f);

    cudaMemcpy(c,f,6*sizeof(int),cudaMemcpyDeviceToHost);

    for (int i = 0; i < n; i++)
    {
        cout<<c[i]<<" ";
    }

    cudaFree(d);
    cudaFree(e);
    cudaFree(f);


    return 0;

}

// % % writefile cuda_example.cu
// #include <iostream>
//     using namespace std;

// __global__ void add(int *A, int *B, int *C, int size)
// {
//     int tid = blockIdx.x * blockDim.x + threadIdx.x;

//     if (tid < size)
//     {
//         C[tid] = A[tid] + B[tid];
//     }
// }

// void initialize(int *vector, int size)
// {
//     for (int i = 0; i < size; i++)
//     {
//         vector[i] = rand() % 10;
//     }
// }

// void print(int *vector, int size)
// {
//     for (int i = 0; i < size; i++)
//     {
//         cout << vector[i] << " ";
//     }
//     cout << endl;
// }

// int main()
// {
//     int N = 4;
//     int *A, *B, *C;

//     int vectorSize = N;
//     size_t vectorBytes = vectorSize * sizeof(int);

//     A = new int[vectorSize];
//     B = new int[vectorSize];
//     C = new int[vectorSize];

//     initialize(A, vectorSize);
//     initialize(B, vectorSize);

//     cout << "Vector A: ";
//     print(A, N);
//     cout << "Vector B: ";
//     print(B, N);

//     int *X, *Y, *Z;
//     cudaMalloc(&X, vectorBytes);
//     cudaMalloc(&Y, vectorBytes);
//     cudaMalloc(&Z, vectorBytes);

//     cudaMemcpy(X, A, vectorBytes, cudaMemcpyHostToDevice);
//     cudaMemcpy(Y, B, vectorBytes, cudaMemcpyHostToDevice);

//     int threadsPerBlock = 256;
//     int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock;

//     add<<<blocksPerGrid, threadsPerBlock>>>(X, Y, Z, N);

//     cudaMemcpy(C, Z, vectorBytes, cudaMemcpyDeviceToHost);

//     cout << "Addition: ";
//     print(C, N);

//     delete[] A;
//     delete[] B;
//     delete[] C;

//     cudaFree(X);
//     cudaFree(Y);
//     cudaFree(Z);

//     return 0;
// }