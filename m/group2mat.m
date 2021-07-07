%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2015 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function group2mat(...
		InputFolder,...
		ChannelNames,...
		ChannelNamesSelectedByUser,...
		Method,...
		Metrics,...
		ArrayOfLowerAndUpperBounds,...
		ArrayOfRangeNames,...
		SamplingRate0,...
		X84_WindowLengthInMinutes,...
		NotchFilterQ,...
		DecimationFactor,...
		RequestedWindowLength,...
		TrailingZerosIntervalLength,...
		SpectraWindowOverlap,...
		Low_Freq,...
		Step_Freq,...
		Upper_Freq,...
		Fb,...
		Fc,...
		ThresholdOfHalfOfFullWidthOfFrequencyInHz,...
		threshold_of_half_width_of_frequency_in_Hz,...
		Number_of_periods,...
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ThresholdOfHalfWidthOfFrequencyInPoints= ...
	round(ThresholdOfHalfOfFullWidthOfFrequencyInHz/Step_Freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������� ������� ��������� ������������� �������                 %
% (� ��������� ������ ��� - ChannelNamesSelectedByUser) � ��������   %
% ������ ������� (ChannelNames)                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ChannelNumbersSelectedByUser= ...
	zeros(length(ChannelNamesSelectedByUser),1);

ChannelNumbersSelectedByUser(:)= NaN;

% ���� ������ ������� ������, ������� ������� ������� �������������:

for i=1:length(ChannelNamesSelectedByUser),
	%
	% ���������� CurrentChannelName ���������� ��� ���� ������,
	% ������� ������ �������������� � �����:
	%
	CurrentChannelName= ChannelNamesSelectedByUser{i};
	%
	% ������ ���������� CurrentNumberOfChannel � ���������� �
	% �� NaN. ��� ���������� ����� ������� � ���� ���������� �����
	% ����� ���������������� ������ (CurrentChannelName) � �����
	% ������ ��� ������� (ChannelNames).
	%
	CurrentNumberOfChannel= NaN;
	%
	% ���� ��� �� ����� ������ ������� (19 ��� 21) � ����
	% ���������� � ���������� �������, ���������� ��������������:
	%
	for j=1:length(ChannelNames),
		%
		% ���������� NameOfChannel ���������� ��� ������,
		% ������� �������������� �� ������ ����� �����:
		%
		NameOfChannel= ChannelNames{j};
	        %
		% ���� ��� 2 ���������� ���������:
		%
		if strcmp(CurrentChannelName,NameOfChannel),
			%
			% �� ���������� CurrentNumberOfChannel
			% ������������� ���������� ����� ����� ������
			% � ����� ������ ��� ������� (�� ���� �� 1 ��
			% 19 ��� 21):
			%
			CurrentNumberOfChannel= j;
			%
			% ���������� �������, ���� ���������������:
			%
			break;
			%
		end;
        	%
	end;
	%
	% ����� ���� �� �������, ��������� �������������, ����������, ��
	% �� ����� ���������� �� � ����� �� ��� ������� � ����� ������
	% ��� ������� ChannelNames, ��:
	%
	if isnan(CurrentNumberOfChannel),
		%
		% ��������� ��������� � ���, ��� ����� �� ������:
		%
		error([...
			'����� � ��������� ������ ',...
			CurrentChannelName,...
			' �� ������!']);
	end;
	%
	% ����� ������ CurrentNumberOfChannel � ����� ������ ����
	% ������� (ChannelNames) ������������� �������� �������
	% ChannelNumbersSelectedByUser.
	% ������ ChannelNumbersSelectedByUser ������ � ���� �����
	% ������ �� ������ ��������� ������������� �������
	% (ChannelNamesSelectedByUser).
	%
	ChannelNumbersSelectedByUser(i)= CurrentNumberOfChannel;
	%
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% . - ������� �������; .. - ������� ����������

List= dir(InputFolder);

counter= 0;

for n=1:length(List),
	SelectedFile= List(n).name;
	[PathStr,ShortName,ext]= fileparts(SelectedFile);
	LowerLettersOfExtOfSelectedFile= lower(ext);
	if strcmp(LowerLettersOfExtOfSelectedFile,'.txt'),
		counter= counter + 1;
	end;
end;

ListOfFileNames= cell(counter,1);

counterOfFileNames= 0;

for k=1:length(List),
	SelectedFile= List(k).name;
	[PathStr,ShortName,ext]= fileparts(SelectedFile);
	LowerLettersOfExtOfSelectedFile= lower(ext);
	if strcmp(LowerLettersOfExtOfSelectedFile,'.txt'),
		counterOfFileNames= counterOfFileNames + 1;
		ListOfFileNames{counterOfFileNames}= SelectedFile;
	end;
end;

ListOfFileNames= sort(ListOfFileNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InputFileName= NaN;

TableOfValues= ...
	zeros(counterOfFileNames,length(ChannelNamesSelectedByUser),length(ArrayOfRangeNames));

TableOfValues(:,:,:)= NaN;

counter2= 0;

for i=1:length(ListOfFileNames),
	%
	CurrentFileName= ListOfFileNames{i};
	%
	[PathStr,ShortName,ext]= fileparts(CurrentFileName);
	LowerLettersOfExtOfSelectedFile= lower(ext);
	%
	if strcmp(LowerLettersOfExtOfSelectedFile,'.txt'),
	        %
		counter2= counter2 + 1;
		%
		InputFileName= [InputFolder,CurrentFileName];
		%
		disp([...
			'�����������: ',...
			num2str(counter2),...
			') ',...
			...CurrentListElementName...
			CurrentFileName...
			]);
		%
		[...
		MatrixOfValues,...
		LF,...
		UF...
		]= txt2mat(...
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
     
		for j=1:length(ChannelNamesSelectedByUser),
			for r=1:length(ArrayOfRangeNames),
                TableOfValues(counter2,j,r)= MatrixOfValues(j,r);
			end;
		end;
		%
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for r=1:length(ArrayOfRangeNames),
	CurrentRangeName= ArrayOfRangeNames{r};
	Array= TableOfValues(:,:,r);
	
    save([...
	InputFolder, ...
	Method, '_', Metrics, '_', CurrentRangeName, '_Results.log'...
	],...
	'Array',...
	'-ASCII');
end;

save([...
	InputFolder, ...
	Method, '_', Metrics, '_Names.mat'...
	],...
	'ArrayOfRangeNames','ChannelNamesSelectedByUser'...
	);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FID1= fopen([InputFolder, Method, '_', Metrics, '_FileNames.log'],'w');

fprintf(FID1,'InputFolder: %s\n',InputFolder);
fprintf(FID1,'Method: %s\n',Method);
fprintf(FID1,'Metrics: %s\n',Metrics);

for r=1:length(ArrayOfRangeNames),
	CurrentRangeName= ArrayOfRangeNames{r};
	CurrentLowerBound= ArrayOfLowerAndUpperBounds(r,1);
	CurrentUpperBound= ArrayOfLowerAndUpperBounds(r,2);
	fprintf(FID1,...
		'%d) %s: %f - %f\n', ...
		r,...
		CurrentRangeName,...
		CurrentLowerBound,...
		CurrentUpperBound);
end;

fprintf(FID1,'SamplingRate0: %f\n',SamplingRate0);
fprintf(FID1,'X84_WindowLengthInMinutes: %f\n',X84_WindowLengthInMinutes);
fprintf(FID1,'NotchFilterQ: %f\n',NotchFilterQ);
fprintf(FID1,'DecimationFactor: %d\n',DecimationFactor);
fprintf(FID1,'RequestedWindowLength: %f\n',RequestedWindowLength);
fprintf(FID1,'TrailingZerosIntervalLength: %f\n',TrailingZerosIntervalLength);
fprintf(FID1,'SpectraWindowOverlap: %s\n',SpectraWindowOverlap);
fprintf(FID1,'Low_Freq: %f\n',Low_Freq);
fprintf(FID1,'Step_Freq: %f\n',Step_Freq);
fprintf(FID1,'Upper_Freq: %f\n',Upper_Freq);
fprintf(FID1,'Fb: %f\n',Fb);
fprintf(FID1,'Fc: %f\n',Fc);
fprintf(FID1,'ThresholdOfHalfOfFullWidthOfFrequencyInHz: %f\n',ThresholdOfHalfOfFullWidthOfFrequencyInHz);
fprintf(FID1,'Number_of_periods: %f\n',Number_of_periods);
fprintf(FID1,'ViborHist: %s\n',ViborHist);
fprintf(FID1,'Check_Amplitude_Values: %s\n',bool2str(Check_Amplitude_Values));
fprintf(FID1,'Minimal_Amplitude_Value_for_auc: %f\n',Minimal_Amplitude_Value_for_auc);
fprintf(FID1,'Maximal_Amplitude_Value_for_auc: %f\n',Maximal_Amplitude_Value_for_auc);
fprintf(FID1,'Eliminate_beta: %s\n',bool2str(eliminate_beta));
fprintf(FID1,'LF: %f\n',LF);
fprintf(FID1,'UF: %f\n',UF);
fprintf(FID1,'\n');

counter3= 0;

for t=1:length(ListOfFileNames),
	%
	CurrentListElementName= ListOfFileNames{t};
	%
	[PathStr,ShortName,ext]= fileparts(CurrentListElementName);
	LowerLettersOfExtOfSelectedFile= ext;
	%
	if strcmpi(LowerLettersOfExtOfSelectedFile,'.txt'),
	        %
		counter3= counter3 + 1;
		InputFileName= [InputFolder,CurrentListElementName];
		%
		fprintf(FID1,'%d) %s\n', counter3, InputFileName);
		%
	end;
	%
end;

fclose(FID1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%