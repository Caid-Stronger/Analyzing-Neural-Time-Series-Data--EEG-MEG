% two vectors of random numbers (10 rows, 1 column)
a = randn(10, 1); 
b = randn(10,1);

%%  dot products 

pointwise_result = zeros(size(a));

for i=1:length(a)
    pointwise_result(i) = a(i) * b(i);
end 

dotproduct = sum(pointwise_result);

%% dotproduct

% multiply each element in vector a and b 
dotproduct = sum(a.* b);

%Take the transpose of vector a.

dotproduct = a'* b; 

% This requires the first vector to be a row vector and the 
% second vector to be a column vector. Otherwise, it will 
% either crash (a*b) or give you the outer product (a*b'). 
% When in doubt, use sum(a.*b).  

%% figure 10.2
% impulse function (all zeros; 1 in the middle) 
impfun = zeros(1,100); 
% wider boxcar function rather than strictly an impulse function.
impfun(45:55)=1; 

kernel = [1 .8 .6 .4 .2]; 
%'same' means return output with the same length of the input signal
matlab_conv_result = conv(impfun, kernel, 'same'); 

%draw picture
%open a window
figure 
%3 rows 1 column, and narrow down to the first one
%gca get the current axes
subplot(311) 
plot(impfun) 

% plot the kernel 
subplot(312) 
plot(kernel, '.-') 
set(gca,'xlim',[0 100], 'ylim', [-0.1 1.1]) 

% plot the result of convolution 
subplot(313) 
plot(matlab_conv_result) 
set(gca, 'xlim', [0 100], 'ylim', [-0.1 3.6]) 

%% figure 10.4 
% data that we'll use for convolution (must be zero-padded).
dat4conv = [zeros(1,length(kernel)-1) impfun zeros(1,length(kernel)-1) ];

% used for cutting the result of convolution
half_of_kernel_size = ceil((length(kernel)-1)/2);

% initialize convolution output
convolution_result = zeros(1,length(impfun)+length(kernel)-1);

% run convolution (note that kernel is flipped backwards)
for ti=1:length(convolution_result)-half_of_kernel_size
    convolution_result(ti) = sum(dat4conv(ti:ti+length(kernel)-1).*kernel(end:-1:1));
end

% cut off edges
convolution_result = convolution_result(half_of_kernel_size+1:end-half_of_kernel_size);
% Note: In the book figure there was a bug on the previous line ("+1" was typed 
%       as "-1"), which incorrectly showed the convolution as being a few points
%       too far to the right. Thanks to Thijs Perenboom for catching that!

figure
plot(impfun)
hold on
plot(convolution_result,'g')
plot(convolution_result./sum(kernel),'r')
plot(matlab_conv_result./sum(kernel),'ko')
set(gca,'xlim',[0 100],'ylim',[-.1 3.1])
legend({'original timeseries';'unscaled convolution';'manual wavelet convolution';'matlab conv function'})

%% end