%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2015 Olga S. Sushkova, Alexei A. Morozov                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Values = calc_and_plot_wavelet(...
		Fig,...
		InputFileName,...
		SamplingRate,...
		SelectedChannelName,...
		Time,...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[PathStr,ShortName,ext]= fileparts(InputFileName);
[FontName,FontSize,FontWeight]= fontAttr();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вычисляем вейвлет-спектрограммы.                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[...
Matrix,...
Frequencies...
]= calcWavelet(...
	InputFileName,...
	SelectedVector,...
	SamplingRate,...
	Low_Freq,...
	Step_Freq,...
	Upper_Freq,...
	Fb,...
	Fc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_wavelets,
	%
	plot_wavelet(...
		Fig,...
		InputFileName,...
		SamplingRate,...
		SelectedChannelName,...
		Time,...
		Frequencies,...
		Matrix,...
		save_figures);
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вычисляем вспышки на вейвлет-спектрограмме.                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TimeInterval= max(Time) - min(Time);

[...
Frequencies_of_flashes,...
Time_marks_of_flashes,...
Powers_of_flashes,...
Durations_of_flashes_in_seconds,...
Durations_of_flashes_in_periods,...
Bandwidthes_of_flashes_in_Hz,...
FractionalBandwidthes_of_flashes...
]= calc_flashes(...
	Fig,...
	InputFileName,...
	SamplingRate,...
	SelectedChannelName,...
	Time,...
	Frequencies,...
	Step_Freq,...
	ThresholdOfHalfWidthOfFrequencyInPoints,...
	threshold_of_half_width_of_frequency_in_Hz,...
	Number_of_periods,...
	Matrix,...
	save_flash_diagrams,...
	save_wavelet_matrices,...
	Minimal_Amplitude_Value_for_auc,...
	Maximal_Amplitude_Value_for_auc,...
	Check_Amplitude_Values,...
    eliminate_beta,...
	Fb,...
	Fc,...
	DecimationFactor...
	);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Построение вспышек

if plot_flash_diagrams,
	plot_flashes(...
		100002,...
		ShortName,...
		SelectedChannelName,...
		SamplingRate,...
		Time_marks_of_flashes,...
		Frequencies_of_flashes);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Values= zeros(length(ArrayOfRangeNames),1);

Values(:)= NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for r=1:length(ArrayOfRangeNames),
	%
	LowerFreq= ArrayOfLowerAndUpperBounds(r,1);
	UpperFreq= ArrayOfLowerAndUpperBounds(r,2);
	%
%/////////////////////////////////////////////////////////////////////%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вычисляем метрики по значениям вейвлет-спектрограмм.               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Summa= 0;
Kol_vo= 0;

Max= - Inf;

Freq= NaN;

N_Time= length(SelectedVector);
N_Frequencies= length(Frequencies);

for i=1:N_Frequencies,
	CurrentFrequency= Frequencies(i);
	for j=1:N_Time,
		if	LowerFreq <= CurrentFrequency && ...
			CurrentFrequency < UpperFreq,
          	Summa= Summa + (abs(Matrix(i,j))).^2;
			Kol_vo= Kol_vo + 1;
			if (abs(Matrix(i,j))).^2 > Max,
				Max= (abs(Matrix(i,j))).^2;
				Freq= CurrentFrequency;
			end;
		end;
	end;
end;

Vectors= zeros(Kol_vo,1);

Vectors(:)= NaN;

cValues= 0;

for i=1:N_Frequencies,
	CurrentFrequency= Frequencies(i);
	for j=1:N_Time,
		if	LowerFreq <= CurrentFrequency && ...
			CurrentFrequency < UpperFreq,
			cValues= cValues + 1;
			Vectors(cValues)= (abs(Matrix(i,j))).^2; 
		end;
	end;
end;

if strcmp(Metrics,'AVERAGE'),
	Value= Summa / Kol_vo;
elseif strcmp(Metrics,'MAXIMUM'),
	Value= Max;
elseif strcmp(Metrics,'FREQUENCY'),
	Value= Freq;
elseif strcmp(Metrics,'MEDIAN'),
	Value= median(Vectors);
elseif strcmp(Metrics,'SIGMA'),
	Value= std(Vectors);
elseif strcmp(Metrics,'AVERAGE_div_MEDIAN'),
	Value= (Summa / Kol_vo) / median(Vectors);
elseif strcmp(Metrics,'MAXIMUM_div_MEDIAN'),
	Value= Max / median(Vectors);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N_Flashes= length(Frequencies_of_flashes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Summa= 0;
Kol_vo= 0;

Max= - Inf;

Freq= NaN;

for a=1:N_Flashes,
	CurrentFrequency= Frequencies_of_flashes(a);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		Summa= Summa + Powers_of_flashes(a);
		Kol_vo= Kol_vo + 1;
		if Powers_of_flashes(a) > Max,
			Max= Powers_of_flashes(a);
			Freq= CurrentFrequency;
		end;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VectorOfFrequencies= zeros(Kol_vo,1);

VectorOfFrequencies(:)= NaN;

VectorOfDurationsInSeconds= zeros(Kol_vo,1);

VectorOfDurationsInSeconds(:)= NaN;

VectorOfDurationsInPeriods= zeros(Kol_vo,1);

VectorOfDurationsInPeriods(:)= NaN;

VectorOfPowers= zeros(Kol_vo,1);

VectorOfPowers(:)= NaN;

VectorOfBandwidthes_of_flashes_in_Hz= zeros(Kol_vo,1);

VectorOfBandwidthes_of_flashes_in_Hz(:)= NaN;

SummaOfDurations= 0;

SummaOfBandwidthes= 0;

cValues= 0;

Summa= 0;
Kol_vo= 0;

for a=1:N_Flashes,
	CurrentFrequency= Frequencies_of_flashes(a);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		cValues= cValues + 1;
		VectorOfFrequencies(cValues)= CurrentFrequency;
		VectorOfDurationsInSeconds(cValues)= ...
			Durations_of_flashes_in_seconds(a);
		VectorOfDurationsInPeriods(cValues)= ...
			Durations_of_flashes_in_periods(a);
		VectorOfPowers(cValues)= Powers_of_flashes(a);
		VectorOfBandwidthes_of_flashes_in_Hz(cValues)= ...
			Bandwidthes_of_flashes_in_Hz(a);
		Summa= Summa + Durations_of_flashes_in_seconds(a);
		Kol_vo= Kol_vo + 1;
		SummaOfDurations= ...
			SummaOfDurations + ...
			Durations_of_flashes_in_seconds(a);
		SummaOfBandwidthes= ...
			SummaOfBandwidthes + ...
			Bandwidthes_of_flashes_in_Hz(a);
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(Metrics,'FLASHES_PER_SEC'),
	Value= cValues / TimeInterval;
elseif strcmp(Metrics,'FLASH_POWER_AVERAGE'),
	Value= mean(VectorOfPowers);
elseif strcmp(Metrics,'FLASH_POWER_MEDIAN'),
	Value= median(VectorOfPowers);
elseif strcmp(Metrics,'FLASH_POWER_SIGMA'),
	Value= std(VectorOfPowers);
elseif strcmp(Metrics,'FLASH_FREQUENCY_AVERAGE'),
	Value= mean(VectorOfFrequencies);
elseif strcmp(Metrics,'FLASH_FREQUENCY_MEDIAN'),
	Value= median(VectorOfFrequencies);
elseif strcmp(Metrics,'FLASH_FREQUENCY_SIGMA'),
	Value= std(VectorOfFrequencies);
elseif strcmp(Metrics,'FLASH_DURATION_AVERAGE'),
	Value=  Summa / Kol_vo;
elseif strcmp(Metrics,'FLASH_DURATION_MEDIAN'),
	Value= median(VectorOfDurationsInSeconds);
elseif strcmp(Metrics,'FLASH_DURATION_SIGMA'),
	Value= std(VectorOfDurationsInSeconds);
elseif strcmp(Metrics,'FLASH_PERIOD_QUANTITY_AVERAGE'),
	Value= mean(VectorOfDurationsInPeriods);
elseif strcmp(Metrics,'FLASH_PERIOD_QUANTITY_MEDIAN'),
	Value= median(VectorOfDurationsInPeriods);
elseif strcmp(Metrics,'FLASH_PERIOD_QUANTITY_SIGMA'),
	Value= std(VectorOfDurationsInPeriods);
elseif strcmp(Metrics,'FLASH_POWER_AVERAGE_div_MEDIAN'),
	Value= ...
		mean(VectorOfPowers) / ...
		median(VectorOfPowers);
elseif strcmp(Metrics,'FLASH_FREQUENCY_AVERAGE_div_MEDIAN'),
	Value= ...
		mean(VectorOfFrequencies) / ...
		median(VectorOfFrequencies);
elseif strcmp(Metrics,'FLASH_DURATION_AVERAGE_div_MEDIAN'),
	Value= ...
        (Summa / Kol_vo) / ...
		median(VectorOfDurationsInSeconds);
elseif strcmp(Metrics,'FLASH_SUMM_OF_DURATIONS'),
	Value= SummaOfDurations / TimeInterval;
elseif strcmp(Metrics,'FLASH_BANDWIDTH_AVERAGE'),
	Value=  SummaOfBandwidthes / Kol_vo;
elseif strcmp(Metrics,'FLASH_BANDWIDTH_MEDIAN'),
	Value= median(VectorOfBandwidthes_of_flashes_in_Hz);
elseif strcmp(Metrics,'FLASH_BANDWIDTH_SIGMA'),
	Value= std(VectorOfBandwidthes_of_flashes_in_Hz);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вычисляем гистограммы количества вспышек на вейвлет-спектрограмме. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xmin= Low_Freq;
xmax= Upper_Freq;

sh= (xmax-xmin)/Kol_stolb;
Pol= sh/2;
x= [Pol:sh:xmax];

Title= 'A very special Histogram';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Standard - стандартизированная гистограмма                         %
% Summa - сумма элементов в столбце                                  %
% Simple - количество элементов в столбце, она же должна             %
% соответствовать обычной hist                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if calc_histograms,
	[...
	Matrix2,...
	x...
	]= o_hist(...
		Powers_of_flashes,...
		Frequencies_of_flashes,...
		Kol_stolb,...
		xmin,...
		xmax,...
		TimeInterval,...
		Title,...
		ViborHist);
%end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_histograms,
	plot_hist(x,Matrix2,SelectedChannelName);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вычисляем метрики по значениям из гистограмм. Гистограммы были     %
% построены на основе количества вспышек на вейвлет-спектрограмме.   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Summa= 0;
Kol_vo= 0;

Max= - Inf;

Freq= NaN;

for i=1:Kol_stolb,
	CurrentFrequency= x(i);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		Summa= Summa + Matrix2(i);
		Kol_vo= Kol_vo + 1;
		if Matrix2(i) > Max,
			Max= Matrix2(i);
			Freq= CurrentFrequency;
		end;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vectors= zeros(Kol_vo,1);

Vectors(:)= NaN;

cValues= 0;

for i=1:Kol_stolb,
	CurrentFrequency= x(i);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		cValues= cValues + 1;
		Vectors(cValues)= Matrix2(i);
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(Metrics,'HIST_AVERAGE'),
	Value= Summa / Kol_vo;
elseif strcmp(Metrics,'HIST_MAXIMUM'),
	Value= Max;
elseif strcmp(Metrics,'HIST_FREQUENCY'),
	Value= Freq;
elseif strcmp(Metrics,'HIST_MEDIAN'),
	Value= median(Vectors);
elseif strcmp(Metrics,'HIST_AVERAGE_div_MEDIAN'),
	Value= (Summa / Kol_vo) / median(Vectors);
elseif strcmp(Metrics,'HIST_MAXIMUM_div_MEDIAN'),
	Value= Max / median(Vectors);
end;

end; %2021-05-31

Values(r)= Value;

%/////////////////////////////////////////////////////////////////////%
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
