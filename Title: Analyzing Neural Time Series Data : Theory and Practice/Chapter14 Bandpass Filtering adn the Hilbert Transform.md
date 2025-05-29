# Hilbert Transform 

EEG data have the form *Mcos(2Πft)* <br> 
The hilbert transform is another way to extractthe imaginary part. <br> 

* First, compute the Fourier transform of a signal and create a copy of the Fourier coefficients that have been multiplied by the complex operator (i). <br>
  This turns the `Mcos(2mf)` into `iMcos(2mt)`.
* Next, identify the positive and negative frequencies, The `positive frequencies` are those `between but not including the zero and the Nyquist frequencies`,<br>
  and the `negative frequencies` are those `above the Nyquist frequency` (throughout the Hilbert transform, the zero and Nyquist frequenciesare left untouched).
*  The next step is to convert the iMcos(2nf) to iMsin(2m). Remember that cosine and sine are related to each other by one-quarter cycle,<br>
  thus, to convert acosine to a sine, you rotate the positive-frequency coefficients one-quarter cycle counter.<br>
  clockwise in complex space (-90°or -/2)(think about the complex plane: rotating fromthe positive real axis to the positive imaginary axis turns a cosine into a sine).
* Thus, to convert a cosine to a sine in negative frequencies, you rotate the negative-frequency coefficients one-quarter cycle clockwise (90 or π/2). <br>
