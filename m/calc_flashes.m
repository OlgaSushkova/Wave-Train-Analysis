%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2015-2018 Olga S. Sushkova, Alexei A. Morozov                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ...
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
		ThresholdOfHalfOfFullWidthOfFrequencyInPoints,...
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

coefficientOfProbe= sqrt(1/2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Power=(abs(Matrix)).^2; %13-05-2021

[...
NumberOfRows,...
NumberOfColumns,...
]= size(Power);

if false,
for i=1:NumberOfRows, % если это включено, то вспышек в бета становится больше
 	Frequency= Frequencies(i);
 	HalfRate= SamplingRate / 2; %частота Найквиста
 	UF= Frequency;
 	W2= UF / HalfRate;
 	HalfOrder= 2;
 	SourceSignal= Power(i,:);
 	% DetrendedSignal= detrend(SourceSignal,'linear');
 	% Trend= SourceSignal - DetrendedSignal;
 	% Make order HalfOrder bandpass digital filter:
 	% [b,a]= butter(HalfOrder,[W1,W2],'bandpass');
 	[b,a]= butter(HalfOrder,W2,'low');
 	% FilteredSignal= filtfilt(b,a,DetrendedSignal);
 	% TargetSignal= FilteredSignal + Trend;
 	TargetSignal= filtfilt(b,a,SourceSignal);
 	Power(i,:)= TargetSignal;
end;
end;

VectorOf_Width_time_in_Dots= zeros(length(Frequencies),1);
VectorOf_Width_frequency_in_Dots= zeros(length(Frequencies),1);
VectorOf_Windows= cell(length(Frequencies),1);

for a=1:NumberOfRows,
	Frequency= Frequencies(a);
	% disp(['Frequency: ',num2str(Frequency)]);
	s= Fc ./ Frequency;
	Halfwidth_time= s * sqrt( - Fb * log(1/sqrt(2))); % время вывел Алексей
	% disp(['Halfwidth_time: ',num2str(Halfwidth_time)]);
	Halfwidth_frequency= (Frequency / (pi * Fc)) * sqrt( log(2) / (2*Fb) ); % частота из формулы 2005
	% disp(['Halfwidth_frequency: ',num2str(Halfwidth_frequency)]);
	% Halfwidth_time_in_Dots= Halfwidth_time*SamplingRate / DecimationFactor;
	% Halfwidth_time_in_Dots= Halfwidth_time * SamplingRate;%
	Halfwidth_time_in_Dots= Halfwidth_time * SamplingRate / 2; % !!!
	% disp(['Halfwidth_time_in_Dots: ',num2str(Halfwidth_time_in_Dots)]);
	% Halfwidth_frequency_in_Dots= Halfwidth_frequency/Step_Freq; 
	Halfwidth_frequency_in_Dots= Halfwidth_frequency/Step_Freq / 2; % !!!
	% disp(['Halfwidth_frequency_in_Dots: ',num2str(Halfwidth_frequency_in_Dots)]);
	Width_time_in_Dots= fix(1 * Halfwidth_time_in_Dots);
	Width_frequency_in_Dots= fix(1 * Halfwidth_frequency_in_Dots);
	VectorOf_Width_time_in_Dots(a)= Width_time_in_Dots;
	VectorOf_Width_frequency_in_Dots(a)= Width_frequency_in_Dots;
	FullWidth_time_in_Dots= Width_time_in_Dots*2+1;

	FullWidth_frequency_in_Dots= Width_frequency_in_Dots*2+1;

	Window= gauss2b(FullWidth_time_in_Dots,FullWidth_frequency_in_Dots);
	VectorOf_Windows{a}= Window;
end;

OldPower= Power;

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
for j=1:1:NumberOfRows, % частота
	FrequencyWidth= VectorOf_Width_frequency_in_Dots(j);
	TimeWidth= VectorOf_Width_time_in_Dots(j);
	Window= VectorOf_Windows{j};
	for i=1:1:NumberOfColumns, % время
		count= 0;
		Summa= 0;
		for localK= 1:TimeWidth*2+1,
			globalK= i-TimeWidth-1+localK;
			if globalK < 1 || globalK > NumberOfColumns,
				continue;
			end;
			for localM=1:FrequencyWidth*2+1,
				globalM= j-FrequencyWidth-1+localM;
				if globalM < 1 || globalM > NumberOfRows,
					continue;
				end;
				W= Window(localK,localM);
				count= count + W;
				% Summa= Summa + OldPower(m,k);
				Summa= Summa + W * OldPower(globalM,globalK);
			end;
		end;
		Power(j,i)= Summa / count;
	end;
end;
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[PathStr,ShortName,ext]= fileparts(InputFileName);
[FontName,FontSize,FontWeight]= fontAttr();

% ExpectedNumberOfFlashes= NumberOfRows*NumberOfColumns;
ExpectedNumberOfFlashes= round(NumberOfRows*NumberOfColumns / 10);

Frequencies_of_flashes= zeros(ExpectedNumberOfFlashes,1);
Time_marks_of_flashes= zeros(ExpectedNumberOfFlashes,1);
Powers_of_flashes= zeros(ExpectedNumberOfFlashes,1);
Durations_of_flashes_in_seconds= zeros(ExpectedNumberOfFlashes,1);
Durations_of_flashes_in_periods= zeros(ExpectedNumberOfFlashes,1);
LeftLimitsOfFlashes= zeros(ExpectedNumberOfFlashes,1);
RightLimitsOfFlashes= zeros(ExpectedNumberOfFlashes,1);
Bandwidthes_of_flashes_in_Hz= zeros(ExpectedNumberOfFlashes,1);
FractionalBandwidthes_of_flashes= zeros(ExpectedNumberOfFlashes,1);
TopLimitsOfFlashes= zeros(ExpectedNumberOfFlashes,1);
BottomLimitsOfFlashes= zeros(ExpectedNumberOfFlashes,1);

Number_of_peaks= 0;

Frequencies_of_flashes(:)= NaN;
Time_marks_of_flashes(:)= NaN;
Powers_of_flashes(:)= NaN;
Durations_of_flashes_in_seconds(:)= NaN;
Durations_of_flashes_in_periods(:)= NaN;
LeftLimitsOfFlashes(:)= NaN;
RightLimitsOfFlashes(:)= NaN;
Bandwidthes_of_flashes_in_Hz(:)= NaN;
FractionalBandwidthes_of_flashes(:)= NaN;
TopLimitsOfFlashes(:)= NaN;
BottomLimitsOfFlashes(:)= NaN;

for i=2:NumberOfRows-1,
	%% 2016.06.28: ПЕРЕНЕСЕНО:
	OnePeriodWidth_Seconds= 1 / Frequencies(i);
	OnePeriodWidth_Points= ...
		OnePeriodWidth_Seconds * SamplingRate;
	%%
	for j=2:NumberOfColumns-1,
		%
		if Check_Amplitude_Values, 
			if	Power(i,j) < ...
					Minimal_Amplitude_Value_for_auc ||...
				Power(i,j) > ...
					Maximal_Amplitude_Value_for_auc,
				continue;
			end;
		end;
		%
		% Выбор точки-кандидата
		%
		if	Power(i,j-1) < Power(i,j) && ...
			Power(i,j) > Power(i,j+1) && ...
			Power(i-1,j) < Power(i,j) && ...
			Power(i,j) > Power(i+1,j) && ...
			Power(i-1,j+1) < Power(i,j) && ...
			Power(i,j) > Power(i+1,j+1) && ...
			Power(i-1,j-1) < Power(i,j) && ...
			Power(i,j) > Power(i+1,j-1),
			%
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
%
LeftLimitOfPeakInSeconds= min(Time);
LeftLimitOfPeakInPoints= 1;
RightLimitOfPeakInSeconds= max(Time);
RightLimitOfPeakInPoints= NumberOfColumns;
%
% ИЩЕМ левую границу рассматриваемой вспышки:
%
ItIsALeftFlankOfHill= false;
HasLeftBorder= false;
%
for z=j-1:-1:1,
	if	Power(i,z) < Power(i,j) * coefficientOfProbe,
%	if	Power(i,z) < Power(i,j) / 2,
		HasLeftBorder= true;
		LeftLimitOfPeakInSeconds= Time(z+1);
		LeftLimitOfPeakInPoints= z + 1;
		break;
	end;
	if	Power(i,z) >= Power(i,j),
		ItIsALeftFlankOfHill= true;
		LeftLimitOfPeakInSeconds= Time(z+1);
		LeftLimitOfPeakInPoints= z + 1;
		break;
	end;
end;
% Вот отличие алгоритма 2016.06.28:
if ~HasLeftBorder,
	continue;
end;
% Вот отличие алгоритма 2016.06.22.A:
if ItIsALeftFlankOfHill,
	continue;
end;
%
% ИЩЕМ правую границу рассматриваемой вспышки:
%
ItIsARightFlankOfHill= false;
HasRightBorder= false;
%
for z=j+1:1:NumberOfColumns,
	if	Power(i,z) < Power(i,j) * coefficientOfProbe,
	% if	Power(i,z) < Power(i,j) / 2,
		HasRightBorder= true;
		RightLimitOfPeakInSeconds= Time(z-1);
		RightLimitOfPeakInPoints= z - 1;
		break;
	end;
	if	Power(i,z) >= Power(i,j),
		ItIsARightFlankOfHill= true;
		RightLimitOfPeakInSeconds= Time(z-1);
		RightLimitOfPeakInPoints= z - 1;
		break;
	end;
end;
% Вот отличие алгоритма 2016.06.28:
if ~HasRightBorder,
	continue;
end;
% Вот отличие алгоритма 2016.06.22.A:
if ItIsARightFlankOfHill,
	continue;
end;
%
%
% Если левой или правой границы нет вообще
% (потому что достигли начала или конца файла),
% точка-кандидат отбрасывается.
% Но теперь (2016-05-06) эта проверка сработать
% не может никогда, потому что начало и конец файла
% задаются в качестве границ любой вспышки по умолчанию
% (если не будет найдена настоящая граница).
%
if	isnan(LeftLimitOfPeakInSeconds),
	%% 2016.06.28: УСИЛЕНО:
	%% continue;
	error('Error: LeftLimitOfPeakInSeconds is not found!');
end;
if	isnan(RightLimitOfPeakInSeconds),
	%% 2016.06.28: УСИЛЕНО:
	%% continue;
	error('Error: RightLimitOfPeakInSeconds is not found!');
end;
%
LengthOfPeakInSeconds= ...
	RightLimitOfPeakInSeconds - ...
	LeftLimitOfPeakInSeconds;
LengthOfPeakInPoints= ...
	RightLimitOfPeakInPoints - ...
	LeftLimitOfPeakInPoints;
threshold_of_the_width_of_the_wave_train_in_points= ...
	round(OnePeriodWidth_Points * Number_of_periods);
%
% Проверка 2 (проверяем, не слишком ли короткая вспышка).
%
if LengthOfPeakInPoints < threshold_of_the_width_of_the_wave_train_in_points,
	% warning('Отбросили пик');
	continue;
end;
%
%====================================================================%
% Проверка по частоте 09.05.2016                                     %
%====================================================================%
%
BottomLimitOfPeakInHz= min(Frequencies);
BottomLimitOfPeakInPoints= 1;
TopLimitOfPeakInHz= max(Frequencies);
TopLimitOfPeakInPoints= NumberOfRows;
%
% ИЩЕМ нижнюю границу рассматриваемой вспышки:
%
ItIsABottomFlankOfHill= false;
HasBottomBorder= false;
%
for z=i-1:-1:1,
	% if	Power(z,j) < Power(i,j) / 2,
	if	Power(z,j) < Power(i,j) * coefficientOfProbe,		
		HasBottomBorder= true;
		BottomLimitOfPeakInHz= Frequencies(z+1);
		BottomLimitOfPeakInPoints= z + 1;
		break;
	end;
	if	Power(z,j) >= Power(i,j),
		ItIsABottomFlankOfHill= true;
		BottomLimitOfPeakInHz= Frequencies(z+1);
		BottomLimitOfPeakInPoints= z + 1;
		break;
	end;
end;
% Вот отличие алгоритма 2016.06.28:
if ~HasBottomBorder,
	continue;
end;
% Вот отличие алгоритма 2016.06.16:
if ItIsABottomFlankOfHill,
	continue;
end;
% ИЩЕМ верхнюю границу рассматриваемой вспышки:
%
ItIsATopFlankOfHill= false;
HasTopBorder= false;
%
for z=i+1:1:NumberOfRows,
	% if	Power(z,j) < Power(i,j) / 2,
	if	Power(z,j) < Power(i,j) * coefficientOfProbe,
		HasTopBorder= true;
		TopLimitOfPeakInHz= Frequencies(z-1);
		TopLimitOfPeakInPoints= z - 1;
		break;
	end;
	if	Power(z,j) >= Power(i,j),
		ItIsATopFlankOfHill= true;
		TopLimitOfPeakInHz= Frequencies(z-1);
		TopLimitOfPeakInPoints= z - 1;
		break;
	end;
end;
% Вот отличие алгоритма 2016.06.28:
if ~HasTopBorder,
	continue;
end;
% Вот отличие алгоритма 2016.06.16:
if ItIsATopFlankOfHill,
	continue;
end;
%
% Если нижней или верней границы нет вообще
% (потому что достигли начала или конца файла),
% точка-кандидат отбрасывается.
% Но теперь (2016-05-06) эта проверка сработать
% не может никогда, потому что начало и конец файла
% задаются в качестве границ любой вспышки по умолчанию
% (если не будет найдена настоящая граница).
%
if	isnan(TopLimitOfPeakInHz),
	%% 2016.06.28: УСИЛЕНО:
	%% continue;
	error('Error: TopLimitOfPeakInHz is not found!');
end;
if	isnan(BottomLimitOfPeakInHz),
	%% 2016.06.28: УСИЛЕНО:
	%% continue;
	error('Error: BottomLimitOfPeakInHz is not found!');
end;
%
BandwidthOfPeakInHz= ...
	TopLimitOfPeakInHz - ...
	BottomLimitOfPeakInHz;
%
%
%====================================================================%
%
Naidena_tochka_kotoraya_bolshe_Power_ij= false;
%
% Координата x - это частота, координата y - это время.
%
for x=BottomLimitOfPeakInPoints:TopLimitOfPeakInPoints,
	%
	for y=LeftLimitOfPeakInPoints:RightLimitOfPeakInPoints,
		%
		if i==x && j==y,
			continue;
		end;
		%
		% Проверка 0 (нет точек больше рассматриваемой).
		%
		if Power(i,j) < Power(x,y),
			Naidena_tochka_kotoraya_bolshe_Power_ij= ...
				true;
			break;
		end;
		%
	end;
	%
	if	Naidena_tochka_kotoraya_bolshe_Power_ij,
		break;
	end;
	%
end;
%
if	~Naidena_tochka_kotoraya_bolshe_Power_ij,
	Number_of_peaks= Number_of_peaks + 1;
	%
	Frequencies_of_flashes(Number_of_peaks)= Frequencies(i);
	Time_marks_of_flashes(Number_of_peaks)= Time(j);
	Powers_of_flashes(Number_of_peaks)= Power(i,j);

	Durations_of_flashes_in_seconds(Number_of_peaks)=...
		LengthOfPeakInSeconds;
	LengthOfPeriodInSeconds= 1 / Frequencies(i);
	Durations_of_flashes_in_periods(Number_of_peaks)=...
		LengthOfPeakInSeconds / LengthOfPeriodInSeconds;
	LeftLimitsOfFlashes(Number_of_peaks)= ...
		LeftLimitOfPeakInSeconds;
	RightLimitsOfFlashes(Number_of_peaks)= ...
		RightLimitOfPeakInSeconds;
	%
	Bandwidthes_of_flashes_in_Hz(Number_of_peaks)= ...
		BandwidthOfPeakInHz;
	FractionalBandwidthes_of_flashes(Number_of_peaks)= ...
		BandwidthOfPeakInHz / Frequencies(i);
	TopLimitsOfFlashes(Number_of_peaks)= ...
		TopLimitOfPeakInHz;
	BottomLimitsOfFlashes(Number_of_peaks)= ...
		BottomLimitOfPeakInHz;
	%
end;
%
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
			%
		end;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Frequencies_of_flashes= Frequencies_of_flashes(1:Number_of_peaks);
Time_marks_of_flashes= Time_marks_of_flashes(1:Number_of_peaks);
Powers_of_flashes= Powers_of_flashes(1:Number_of_peaks);
Durations_of_flashes_in_seconds= ...
	Durations_of_flashes_in_seconds(1:Number_of_peaks);
Durations_of_flashes_in_periods= ...
	Durations_of_flashes_in_periods(1:Number_of_peaks);
LeftLimitsOfFlashes= LeftLimitsOfFlashes(1:Number_of_peaks);
RightLimitsOfFlashes= RightLimitsOfFlashes(1:Number_of_peaks);
Bandwidthes_of_flashes_in_Hz= ...
	Bandwidthes_of_flashes_in_Hz(1:Number_of_peaks);
FractionalBandwidthes_of_flashes= ...
	FractionalBandwidthes_of_flashes(1:Number_of_peaks);
TopLimitsOfFlashes= TopLimitsOfFlashes(1:Number_of_peaks);
BottomLimitsOfFlashes= BottomLimitsOfFlashes(1:Number_of_peaks);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if eliminate_beta,

New_Frequencies_of_flashes= zeros(Number_of_peaks,1);
New_Time_marks_of_flashes= zeros(Number_of_peaks,1);
New_Powers_of_flashes= zeros(Number_of_peaks,1);
New_Durations_of_flashes_in_seconds= zeros(Number_of_peaks,1);
New_Durations_of_flashes_in_periods= zeros(Number_of_peaks,1);
New_LeftLimitsOfFlashes= zeros(Number_of_peaks,1);
New_RightLimitsOfFlashes= zeros(Number_of_peaks,1);
New_Bandwidthes_of_flashes_in_Hz= zeros(Number_of_peaks,1);
New_FractionalBandwidthes_of_flashes= zeros(Number_of_peaks,1);
New_TopLimitsOfFlashes= zeros(Number_of_peaks,1);
New_BottomLimitsOfFlashes= zeros(Number_of_peaks,1);

New_Frequencies_of_flashes(:)= NaN;
New_Time_marks_of_flashes(:)= NaN;
New_Powers_of_flashes(:)= NaN;
New_Durations_of_flashes_in_seconds(:)= NaN;
New_Durations_of_flashes_in_periods(:)= NaN;
New_LeftLimitsOfFlashes(:)= NaN;
New_RightLimitsOfFlashes(:)= NaN;
New_Bandwidthes_of_flashes_in_Hz(:)= NaN;
New_FractionalBandwidthes_of_flashes(:)= NaN;
New_TopLimitsOfFlashes(:)= NaN;
New_BottomLimitsOfFlashes(:)= NaN;

counter9= 0;

for n=1:Number_of_peaks,
	BetaFrequency= Frequencies_of_flashes(n);
	BetaLeftLimitsOfFlash= LeftLimitsOfFlashes(n);
	BetaRightLimitsOfFlash= RightLimitsOfFlashes(n);
	IgnoreBeta= false;
	for m=1:Number_of_peaks,
		AlphaFrequency= Frequencies_of_flashes(m);
		AlphaLeftLimitsOfFlash= LeftLimitsOfFlashes(m);
		AlphaRightLimitsOfFlash= RightLimitsOfFlashes(m);
		if AlphaFrequency >= 14;
			continue;
		else
			if	AlphaLeftLimitsOfFlash <= BetaLeftLimitsOfFlash &&...
				AlphaRightLimitsOfFlash >= BetaRightLimitsOfFlash,
				IgnoreBeta= true;
				break;
				% warning('Отбросили пик');
			end;
			if	AlphaLeftLimitsOfFlash > BetaLeftLimitsOfFlash &&...
				AlphaRightLimitsOfFlash < BetaRightLimitsOfFlash,
				IgnoreBeta= true;
				% warning('Отбросили пик');
				break;
			end;
			if	AlphaLeftLimitsOfFlash < BetaLeftLimitsOfFlash &&...
				BetaLeftLimitsOfFlash < AlphaRightLimitsOfFlash,
				IgnoreBeta= true;
				% warning('Отбросили пик');
				break;
			end;
			if	BetaLeftLimitsOfFlash < AlphaLeftLimitsOfFlash &&...
				AlphaLeftLimitsOfFlash < BetaRightLimitsOfFlash,
				IgnoreBeta= true;
				% warning('Отбросили пик');
				break;
			end;
		end;
	end;
	if IgnoreBeta,
		continue;
	end;
	counter9= counter9 + 1;
	New_Frequencies_of_flashes(counter9)= Frequencies_of_flashes(n);
	New_Time_marks_of_flashes(counter9)= Time_marks_of_flashes(n);
	New_Powers_of_flashes(counter9)= Powers_of_flashes(n);
	New_Durations_of_flashes_in_seconds(counter9)= Durations_of_flashes_in_seconds(n);
	New_Durations_of_flashes_in_periods(counter9)= Durations_of_flashes_in_periods(n);
	New_LeftLimitsOfFlashes(counter9)= LeftLimitsOfFlashes(n);
	New_RightLimitsOfFlashes(counter9)= RightLimitsOfFlashes(n);
	New_Bandwidthes_of_flashes_in_Hz(counter9)= Bandwidthes_of_flashes_in_Hz(n);
	New_FractionalBandwidthes_of_flashes(counter9)= FractionalBandwidthes_of_flashes(n);
	New_TopLimitsOfFlashes(counter9)= TopLimitsOfFlashes(n);
	New_BottomLimitsOfFlashes(counter9)= BottomLimitsOfFlashes(n);
end; 

Frequencies_of_flashes= New_Frequencies_of_flashes(1:counter9);
Time_marks_of_flashes= New_Time_marks_of_flashes(1:counter9);
Powers_of_flashes= New_Powers_of_flashes(1:counter9);
Durations_of_flashes_in_seconds= New_Durations_of_flashes_in_seconds(1:counter9);
Durations_of_flashes_in_periods= New_Durations_of_flashes_in_periods(1:counter9);
LeftLimitsOfFlashes= New_LeftLimitsOfFlashes(1:counter9);
RightLimitsOfFlashes= New_RightLimitsOfFlashes(1:counter9);
Bandwidthes_of_flashes_in_Hz= New_Bandwidthes_of_flashes_in_Hz(1:counter9);
FractionalBandwidthes_of_flashes= New_FractionalBandwidthes_of_flashes(1:counter9);
TopLimitsOfFlashes= New_TopLimitsOfFlashes(1:counter9);
BottomLimitsOfFlashes= New_BottomLimitsOfFlashes(1:counter9);

end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if save_flash_diagrams,
	%
	Flash_Freq_Stack= Frequencies_of_flashes;
	Flash_Time_Stack= Time_marks_of_flashes;
	Flash_Ampl_Stack= Powers_of_flashes;
	Flash_Durat_In_Seconds_Stack= Durations_of_flashes_in_seconds;
	Flash_Durat_In_Periods_Stack= Durations_of_flashes_in_periods;
	Flash_Band_In_Hz_Stack= Bandwidthes_of_flashes_in_Hz;
	Flash_Frac_Band_Stack= FractionalBandwidthes_of_flashes;
	%
%SelectedChannelName= 'EMG1'; % включи это, если на самом деле считается Е3
%SelectedChannelName= 'EMG2'; % включи это, если на самом деле считается Е4 
	%
	Save_Freq_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Freq','.mat'];
	save(Save_Freq_mat,'Flash_Freq_Stack');
	%
	Save_Time_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Time','.mat'];
	save(Save_Time_mat,'Flash_Time_Stack');
	%
	Save_Ampl_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Ampl','.mat'];
	save(Save_Ampl_mat,'Flash_Ampl_Stack');
    	%
	Save_Durat_In_Seconds_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'DuratSeconds','.mat'];
	save(Save_Durat_In_Seconds_mat,'Flash_Durat_In_Seconds_Stack');
	%
	Save_Durat_In_Periods_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'DuratPeriods','.mat'];
	save(Save_Durat_In_Periods_mat,'Flash_Durat_In_Periods_Stack');
	%
	Save_Left_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Left','.mat'];
	save(Save_Left_mat,'LeftLimitsOfFlashes');
	%
	Save_Right_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Right','.mat'];
	save(Save_Right_mat,'RightLimitsOfFlashes');
	%
	Save_Bandwidthes_Hz_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'BandwidthesHz','.mat'];
	save(Save_Bandwidthes_Hz_mat,'Flash_Band_In_Hz_Stack');
	%
	Save_Frac_Band_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Frac_Band','.mat'];
	save(Save_Frac_Band_mat,'Flash_Frac_Band_Stack');
	%
	Save_Top_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Top','.mat'];
	save(Save_Top_mat,'TopLimitsOfFlashes');
	%
	Save_Bottom_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Bottom','.mat'];
	save(Save_Bottom_mat,'BottomLimitsOfFlashes');
	%
	Save_TimeAndFrequency_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'TimeAndFrequency','.mat'];
	save(Save_TimeAndFrequency_mat,'Time','Frequencies');
	%
end;

if save_wavelet_matrices,
	%
	Save_Wavelet_mat= [...
		PathStr,'/',ShortName,ext,'_',...
		SelectedChannelName,'Wavelet','.mat'];
	save(Save_Wavelet_mat,'Power','Time','Frequencies');
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
