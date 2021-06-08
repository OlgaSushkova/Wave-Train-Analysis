# Wave-Train-Analysis
Using 2D and 3D AUC diagrams we provide improved detection accuracy of Parkinson's disease

There are the Matlab files to analyze electroencephalogram (EEG), electromyogram (EMG), and tremorogram data.

<b>The idea of the method of wave train electrical activity analysis</b> is that we consider the biomedical signal as a combination of the wave trains. The wave train is an increase of the power spectral density of the signal localized in time, frequency, and space. We detect the wave trains as the local maxima in the wavelet spectrograms. We do not consider wave trains as a special kind of signal. 

We investigate the following wave train parameters: <b>wave train central frequency, wave train maximal power spectral density, wave train duration in periods, and wave train bandwidth</b>. We have developed special graphical diagrams, named AUC diagrams, to determine what wave trains are characteristic of neurodegenerative diseases. 

You can read about our method here: <i>O.S. Sushkova, A.A. Morozov, A.V. Gabova, A.V. Karabanov. Investigation of Surface EMG and Acceleration Signals of Limbs’ Tremor in Parkinson’s Disease Patients Using the Method of Electrical Activity Analysis Based on Wave Trains // Advances in Artificial Intelligence: 16th Ibero-American Conference on AI, IBERAMIA 2018, Trujillo, Peru, November 13-16, 2018, Proceedings / G.R. Simari, F. Eduardo, F. Gutiérrez Segura, J.A. Rodríguez Melquiades (Eds.). – Springer Nature Switzerland AG, 2018. – V. 11238 LNAI. – P. 253-264. – DOI: 10.1007/978-3-030-03928-8_21, URL: https://link.springer.com/chapter/10.1007/978-3-030-03928-8_21</i> 

Run the <b>eegemg_allmetrics2mat.m</b> to generate the files with wave train parameters of investigated data.
In "InputFolder" value write your folder for analysis.
In "Method" value you can choose "COMPLEX_MORLET" or "FFT" method for processing. For reproduce our method please choose "COMPLEX_MORLET" and in "ListOfMetrics" please choose "FLASHES_PER_SEC". 
Please select "true" value in "plot_signals" if you need to plot signals;
Please select "true" value in "calc_spectra" if you need to calculate spectra (this option is available if "FFT" method for processing is chosen);
Please select "true" value in "plot_spectra" if you need to plot spectra;
Please select "true" value in "calc_wavelets" if you need to calculate wavelets (this option is available if "COMPLEX_MORLET" method for processing is chosen);
Please select "true" value in "plot_flash_diagrams" if you need to plot wave train flash diagrams;
Please select "true" value in "save_figures" if you need to save figures;
Please select "true" value in "save_figures" if you need to save figures;
Please select "true" value in "save_flash_diagrams" if you need to save wave train diagrams (this option must have "true" value to reproducing our method);
Please select "true" value in "save_wavelet_matrices" if you need to save wavelet matrices;
Please select "true" value in "calc_histograms" if you need to calc histograms;
Please select "true" value in "eliminate_beta" if you need to eliminate beta range;
