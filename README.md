# Wave-Train-Analysis
Using 2D and 3D AUC diagrams we provide improved detection accuracy of Parkinson's disease

There are the Matlab files to analyze electroencephalogram (EEG), electromyogram (EMG), and tremorogram data.

<b>The idea of the method of wave train electrical activity analysis</b> is that we consider the biomedical signal as a combination of the wave trains. The wave train is an increase of the power spectral density of the signal localized in time, frequency, and space. We detect the wave trains as the local maxima in the wavelet spectrograms. We do not consider wave trains as a special kind of signal. 

We investigate the following wave train parameters: <b>wave train central frequency, wave train maximal power spectral density, wave train duration in periods, and wave train bandwidth</b>. We have developed special graphical diagrams, named AUC diagrams, to determine what wave trains are characteristic of neurodegenerative diseases. 

You can read about our method here: <i>O.S. Sushkova, A.A. Morozov, A.V. Gabova, A.V. Karabanov. Investigation of Surface EMG and Acceleration Signals of Limbs’ Tremor in Parkinson’s Disease Patients Using the Method of Electrical Activity Analysis Based on Wave Trains // Advances in Artificial Intelligence: 16th Ibero-American Conference on AI, IBERAMIA 2018, Trujillo, Peru, November 13-16, 2018, Proceedings / G.R. Simari, F. Eduardo, F. Gutiérrez Segura, J.A. Rodríguez Melquiades (Eds.). – Springer Nature Switzerland AG, 2018. – V. 11238 LNAI. – P. 253-264. – DOI: 10.1007/978-3-030-03928-8_21, URL: https://link.springer.com/chapter/10.1007/978-3-030-03928-8_21</i> 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Run the <b>eegemg_allmetrics2mat.m</b> m-file to generate the files with wave train parameters of investigated data.

%%%

In "InputFolder" value please indicate your folder with data for analysis. This folder must contain a txt-file with a signal for analysis.

%%%

In the "Method" value you can choose the "COMPLEX_MORLET" or "FFT" method for processing. To reproduce our method please choose "COMPLEX_MORLET" and in "ListOfMetrics" value please choose "FLASHES_PER_SEC". 

%%%

Please select the "true" value in "plot_signals" value if you need to plot signals;<br>
<IMG SRC="https://sun9-19.userapi.com/impg/veVnrzSU8t1HUay60pA82jm-ckwDEcuaSuytsw/fRXeC8SlrD0.jpg?size=1920x903&quality=96&sign=2ce52b994f9484da9116186eb0350578&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>


Please select the "true" value in "calc_spectra" value if you need to calculate spectra (this option is available if the "FFT" method for processing is chosen);

Please select the "true" value in "plot_spectra" value if you need to plot spectra;

Please select the "true" value in "calc_wavelets" value if you need to calculate wavelets (this option is available if the "COMPLEX_MORLET" method for processing is chosen);

Please select the "true" value in "plot_wavelets" value if you need to plot wavelets;<br>
<IMG SRC="https://sun9-35.userapi.com/impg/UzGdCvuoz52mbCoHbNIVQ9j4cc2tIPVc04aoHA/rfYhNPoSdIE.jpg?size=1920x903&quality=96&sign=efb362c9412f0a8c10197ac924316dca&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center> 
  
Please select the "true" value in "plot_flash_diagrams" value if you need to plot wave train flash diagrams;

Please select the "true" value in "save_figures" value if you need to save figures;

Please select the "true" value in "save_flash_diagrams" value if you need to save wave train diagrams (this option must have "true" value to reproducing our method);

Please select the "true" value in "save_wavelet_matrices" value if you need to save wavelet matrices;

Please select the "true" value in "calc_histograms" value if you need to calc histograms;

Please select the "true" value in "eliminate_beta" value if you need to eliminate the beta range;

Please select the "true" value in "plot_histograms" value if you need to plot histograms.

%%%

Please note that the "ChannelNames" value contains the channel names that are presented in your file for analysis.

In the "ChannelNamesSelectedByUser" value you need to choose what channel name you want to analyze. Please note that if you choose a channel with the "EMG" prefix, a program will preprocess your signal with a 60-240 Hz filter and calculate an envelope of the signal. For other channels, a filter of 2-240 Hz will be applied. For modifying this preprocessing option please correct this in the "preprocess_signal" m-file.

At last when progam will finish the processing of files in your program you can repeat this procedure and process another files in another folder. For instance, you can process two folders with files and compare calculated data in next programs (calculate_auc_008_fast_phase_time_psi0.m and analyze_auc_fast_phase_time_psi0.m).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Run the <b>calculate_auc_008_fast_phase_time_psi0.m</b> m-file to calculate AUC values based on the files calculated by previuos program (eegemg_allmetrics2mat.m).

In "Names" value please indicate two your folders with data for analysis. These folders must contain a mat-files with parameters of wave trains calculated by previuos program (eegemg_allmetrics2mat.m). Using calculate_auc_008_fast_phase_time_psi0.m you can compare two datasets in these two folders.

In the "CName" value you need to choose what channel name you want to analyze. This name must be the same as in previous program (eegemg_allmetrics2mat.m).

%%%

Please select the "true" value in "calc_hole" value if you need to calculate only AUC values, where the statistical significant differences are observed.

Please select the "true" value in "plot_roc" value if you need to plot ROC curve.

%%%

Then you need to choose what type of AUC diagram you need to calculate.
If you need to calculate the Frequency AUC diagram, please indicate the range of minimal values of frequencies in "MinFreq" value. For instance "MinFreq= [1:1:50]" and please indicate the range of maximal values of frequencies in "MaxFreq" value. For instance "MaxFreq= [1:1:50]";
Other values (MinFreq, MaxFreq, MinAmpl, MaxAmpl, MinDurat, MaxDurat, MinDurat_in_Periods, MaxDurat_in_Periods, MinBandwidth, MaxBandwidth, MinPhase, MaxPhase, MinTime, MaxTime,MinPsi0,MaxPsi0) please left as constants. For instance, "MinAmpl = 0";

The same procedure works for other types of AUC diagrams. You need to indicate ranges of minimal amd maximal values for the AUC diagram, which you want to calculate. Other values you need to left as constants.

%%%

At last step you need to save the calculated AUC values in the mat-file. Please write the special name of your calculated AUC values. For instancem "save(	['Table_AUC_values_Frequencies']".

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Run the <b>analyze_auc_fast_phase_time_psi0.m</b> m-file to analyse calculated AUC values and plot 2D AUC diagrams.

In "FileName" value please indicate the file name with data for analysis. This mat-file must contain AUC values calculated by previuos program (calculate_auc_008_fast_phase_time_psi0.m).

Next you need to choose the dimension of the AUC diagram.
If in previous program you calculated AUC values for Frequency AUC diagram, you need to choose "Freq" value.<br>
<IMG SRC="https://sun9-14.userapi.com/impg/Aq639LipA1-lk7CR7PkLd9tIF6cYA7ZEc6EAEA/qlIFu_wCyN0.jpg?size=1920x903&quality=96&sign=990e40d05e42dab6277b1d46e64c1014&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>     
If in previous program you calculated AUC values for Amplitude AUC diagram, you need to choose "Ampl" value.<br>
<IMG SRC="https://sun9-16.userapi.com/impg/BIUDJRwGxAKXMmuCbykOSClTihvMBJ_UCXFLmA/ikgWR5Spuwk.jpg?size=1716x892&quality=96&sign=8c01a8eb2a4125de370fb8257f2a4461&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   
If in previous program you calculated AUC values for Duration AUC diagram, you need to choose "Durat" value.  
If in previous program you calculated AUC values for Duration in Periods AUC diagram, you need to choose "Durat_in_Periods" value.<br>
<IMG SRC="https://sun9-18.userapi.com/impg/HTQxjQ4tYPczFHitMHT_a_n31iwvW4oTl57WFw/irbtLua-1dw.jpg?size=1680x892&quality=96&sign=8c412e40141ab83610e057ad4250cdd1&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   
If in previous program you calculated AUC values for Bandwidth AUC diagram, you need to choose "Bandwidth" value.<br>
<IMG SRC="https://sun9-26.userapi.com/impg/W7AFvZcJVW2McQAhIFbej5e0L5wqeev0lQ7HvQ/Kh4LbXGReZQ.jpg?size=1680x892&quality=96&sign=a14752d4cbc821830d9f6a063e759da8&type=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   
If in previous program you calculated AUC values for Phase AUC diagram, you need to choose "Phase" value.<br>
<IMG SRC="https://sun9-35.userapi.com/impg/UzGdCvuoz52mbCoHbNIVQ9j4cc2tIPVc04aoHA/rfYhNPoSdIE.jpg?size=1920x903&quality=96&sign=efb362c9412f0a8c10197ac924316dca&type=albumtype=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   
If in previous program you calculated AUC values for Time AUC diagram, you need to choose "Time" value.<br>
<IMG SRC="https://sun9-35.userapi.com/impg/UzGdCvuoz52mbCoHbNIVQ9j4cc2tIPVc04aoHA/rfYhNPoSdIE.jpg?size=1920x903&quality=96&sign=efb362c9412f0a8c10197ac924316dca&type=albumtype=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   
If in previous program you calculated AUC values for Psi0 AUC diagram, you need to choose "Psi0" value.<br>
<IMG SRC="https://sun9-35.userapi.com/impg/UzGdCvuoz52mbCoHbNIVQ9j4cc2tIPVc04aoHA/rfYhNPoSdIE.jpg?size=1920x903&quality=96&sign=efb362c9412f0a8c10197ac924316dca&type=albumtype=album" alt="EMG" title="EMG" BORDER="1"   WIDTH=530 align=center>   

That's all
