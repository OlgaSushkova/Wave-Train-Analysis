%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Values = calc_and_plot_spectrum(...
		Fig,...
		InputFileName,...
		SamplingRate,...
		SelectedChannelName,...
		Time,...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[PathStr,ShortName,ext]= fileparts(InputFileName);

[FontName,FontSize,FontWeight]= fontAttr();

[...
Pxx,...
Frequencies...
]= calcSpct(...
		SelectedVector,...
		SamplingRate,...
		RequestedWindowLength,...
		TrailingZerosIntervalLength,...
		SpectraWindowOverlap);

Values= zeros(length(ArrayOfRangeNames),1);

Values(:)= NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for r=1:length(ArrayOfRangeNames),
	%
	LowerFreq= ArrayOfLowerAndUpperBounds(r,1);
	UpperFreq= ArrayOfLowerAndUpperBounds(r,2);
	%
%/////////////////////////////////////////////////////////////////////%

Summa= 0;
Kol_vo= 0;

Max= - Inf;

Freq= NaN;

for i=1:length(Frequencies),
	CurrentFrequency= Frequencies(i);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		Summa= Summa + Pxx(i);
		Kol_vo= Kol_vo + 1;
		if Pxx(i) > Max,
			Max= Pxx(i);
			Freq= CurrentFrequency;
		end;
	end;
end;

Vectors= zeros(Kol_vo,1);

Vectors(:)= NaN;

cValues= 0;

for i=1:length(Frequencies),
	CurrentFrequency= Frequencies(i);
	if	LowerFreq <= CurrentFrequency && ...
		CurrentFrequency < UpperFreq,
		cValues= cValues + 1;
		Vectors(cValues)= Pxx(i);
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
else
	error (['Wrong name of Metrics: ', Metrics]);
end;

Values(r)= Value;

%/////////////////////////////////////////////////////////////////////%
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if plot_spectra,
	%
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%

MinPxx= min(Pxx);
MaxPxx= max(Pxx);

figure(Fig);
set(figure(Fig),'Color',[1,1,1]);
set(figure(Fig),'NumberTitle','off');
set(figure(Fig),'name',[...
	'Spectrum; ',ShortName,'; ',...
	SelectedChannelName,'; ',...
	'Rate ',num2str(SamplingRate)]);
plot(...
	Frequencies,...
	Pxx,...
	'LineWidth',3,...
	'Color','m');
if MinPxx < MaxPxx,
	axis([MinFreq,MaxFreq,MinPxx,MaxPxx]);
end;
set(gca,'FontName',FontName);
set(gca,'FontSize',FontSize);
set(gca,'FontWeight',FontWeight);
title([	...
	ShortName,', ',...
	SelectedChannelName,', ',...
	'Rate: ',num2str(SamplingRate)],...
	'FontName',FontName,...
	'FontSize',10,...
	'FontWeight',FontWeight,...
	'Interpreter','none');
xlabel('Frequency [Hz]');
ylabel('PSD [mV^2/Hz]');
rsz_wnd(Fig);
if save_figures,
	CurrentDirectory= cd;
	FigureName1= fullfile(...
		[PathStr,'/',ShortName],...
		[...
		'Spectrum-',...
		ShortName,'-',...
		'[',...
		SelectedChannelName,...
		']']);
	cd(PathStr);
	[s,mess,messid]= mkdir(ShortName);
	save_Fig(FigureName1);
	cd(CurrentDirectory);
end;

%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
