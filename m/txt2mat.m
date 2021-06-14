%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) Korolev M.S., Define RIDGES / Plot Delta Phase 2009/2012 DRPDP  %
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��� ��������� ������������ �������, ������ �������, ��������,       %
% ������� ����, �������������� ������ ��� ��������� Reader.           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [MatrixOfValues, LF, UF]= txt2mat(...
		InputFileName,...
		ChannelNames,...
		ChannelNamesSelectedByUser,...
		ChannelNumbersSelectedByUser,...
		SamplingRate0,...
		X84_WindowLengthInMinutes,...
		RequestedWindowLength,...
		TrailingZerosIntervalLength,...
		SpectraWindowOverlap,...
		NotchFilterQ,...
		DecimationFactor,...
		Low_Freq,...
		Step_Freq,...
		Upper_Freq,...
		Fb,...
		Fc,...
		ThresholdOfHalfWidthOfFrequencyInPoints,...
		threshold_of_half_width_of_frequency_in_Hz,...
		Number_of_periods,...
		Method,...
		Metrics,...
		ArrayOfLowerAndUpperBounds,...
		ArrayOfRangeNames,...
		plot_signals,...
		calc_spectra,...
		plot_spectra,...
		calc_wavelets,...
		plot_wavelets,...
		plot_flash_diagrams,...
		save_flash_diagrams,...
		save_wavelet_matrices,...
		Kol_stolb,...
		calc_histograms,...
		ViborHist,...
		plot_histograms,...
		save_figures,...
		MinFreq,...
		MaxFreq,...
		Minimal_Amplitude_Value_for_auc,...
		Maximal_Amplitude_Value_for_auc,...
		Check_Amplitude_Values,...
        eliminate_beta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Matrix,Time1]= readFile(InputFileName,SamplingRate0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MatrixOfValues= zeros(...
	length(ChannelNamesSelectedByUser),...
	length(ArrayOfRangeNames));

MatrixOfValues(:,:)= NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The start of circle on NumberOfChannel                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for m=1:length(ChannelNumbersSelectedByUser),
	%
	NumberOfChannel= ChannelNumbersSelectedByUser(m); 
	SelectedChannelName= ChannelNames{NumberOfChannel};
	%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SelectedVector= Matrix(:,NumberOfChannel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����� �� ����� �������                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_signals,
	plot_signal(...
		10001,...
		InputFileName,...
		SamplingRate0,...
		SelectedChannelName,...
		Time1,...
		SelectedVector,...
		save_figures);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����� �� ����� ������� �������                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if calc_spectra, 
	calc_and_plot_spectrum(...
		20001,...
		InputFileName,...
		SamplingRate0,...
		SelectedChannelName,...
		Time1,...
		SelectedVector,...
		RequestedWindowLength,...
		TrailingZerosIntervalLength,...
		SpectraWindowOverlap,...
		Metrics,...
		ArrayOfLowerAndUpperBounds,...
		ArrayOfRangeNames,...
		save_figures,...
		MinFreq,...
		MaxFreq,...
		plot_spectra);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ������������� �������                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[...
SelectedVector,...
SamplingRate1,...
LF,...
UF......
]= preprocess_signal(...
	SelectedVector,...
	SamplingRate0,...
	X84_WindowLengthInMinutes,...
	NotchFilterQ,...
	DecimationFactor,...
	SelectedChannelName,...
	Time1);

N_Points= length(SelectedVector);
Time2= [0:N_Points-1] / SamplingRate1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����� �� ����� �������                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_signals, 
	plot_signal(...
		10002,...
		InputFileName,...
		SamplingRate1,...
		SelectedChannelName,...
		Time2,...
		SelectedVector,...
		save_figures);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����� �� ����� ������� �������                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if calc_spectra,
	%
	Values= calc_and_plot_spectrum(...
		20002,...
		InputFileName,...
		SamplingRate1,...
		SelectedChannelName,...
		Time2,...
		SelectedVector,...
		RequestedWindowLength,...
		TrailingZerosIntervalLength,...
		SpectraWindowOverlap,...
		Metrics,...
		ArrayOfLowerAndUpperBounds,...
		ArrayOfRangeNames,...
		save_figures,...
		MinFreq,...
		MaxFreq,...
		plot_spectra);
	%
	if strcmp(Method,'FFT'),
		for r=1:length(ArrayOfRangeNames),
            MatrixOfValues(m,r)= Values(r);
		end;
	end;
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if calc_wavelets,
	%
	Values= calc_and_plot_wavelet(...
		50001,...
		InputFileName,...
		SamplingRate1,...
		SelectedChannelName,...
		Time2,...
		SelectedVector,...
		Metrics,...
		ArrayOfLowerAndUpperBounds,...
		ArrayOfRangeNames,...
		Low_Freq,...
		Step_Freq,...
		Upper_Freq,...
		Fb,...
		Fc,...
		ThresholdOfHalfWidthOfFrequencyInPoints,...
		threshold_of_half_width_of_frequency_in_Hz,...
		Number_of_periods,...
		plot_wavelets,...
		plot_flash_diagrams,...
		save_flash_diagrams,...
		save_wavelet_matrices,...
		Kol_stolb,...
		calc_histograms,...
		ViborHist,...
		plot_histograms,...
		save_figures,...
		MinFreq,...
		MaxFreq,...
		Minimal_Amplitude_Value_for_auc,...
		Maximal_Amplitude_Value_for_auc,...
		Check_Amplitude_Values,...
        eliminate_beta,...
		DecimationFactor...
		);
	%
	if strcmp(Method,'COMPLEX_MORLET'),
		for r=1:length(ArrayOfRangeNames),
            MatrixOfValues(m,r)= Values(r);
		end;
	end;
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The end of circle on NumberOfChannel 			              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
