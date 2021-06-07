%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function...
[...
SelectedVector,...
SamplingRate,...
LF,...
UF...
]= preprocess_signal(...
	SelectedVector,...
	SamplingRate,...
	X84_WindowLengthInMinutes,...
	NotchFilterQ,...
	DecimationFactor,...
	SelectedChannelName,...
	Time);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Отличительной особенностью операции && (по сравнению с &) является  %
% то, что вычисляется первое условие, и если оно ложное, то второе    %
% даже не вычисляется.                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 	length(SelectedChannelName) >= 3 && ...
	strcmp(SelectedChannelName(1:3),'EMG'),
	this_is_EMG_channel= true;
else
	this_is_EMG_channel= false;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% X84_WindowLengthInMinutes= 1; % [minutes]
% X84_WindowLengthInMinutes= 0.5; % [minutes]

WindowLengthInPoints= round(X84_WindowLengthInMinutes * 60 * SamplingRate);

%MatrixToBeModified= Matrix;

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %            Метод X84         %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% WindowShift= ceil(WindowLengthInPoints / 2);

% ModifiedVector= SelectedVector;

% %num2str(WindowLengthInPoints,'%1.10f'):

% CurrentPosition= 1;
% while (true),
	% Beginning= CurrentPosition;
	% End= min(CurrentPosition+WindowLengthInPoints,length(SelectedVector));
	% Vector= SelectedVector(Beginning:End);
	% Median= median(Vector);
	% Deviation= abs(Vector - Median);
	% MAD= median(Deviation);
	% UpperBound= Median + 5.2 * MAD; % X84
	% LowerBound= Median - 5.2 * MAD; % X84
	% for p=Beginning:End,
		% if ModifiedVector(p) > UpperBound,
			% ModifiedVector(p)= UpperBound;
		% elseif ModifiedVector(p) < LowerBound,
			% ModifiedVector(p)= LowerBound;
		% end;
	% end;
	% if End >= length(SelectedVector),
		% break;
	% end;
	% CurrentPosition= CurrentPosition + WindowShift;
% end;   
% %figure(100);
% %subplot(2,1,1);
% %plot(Time,ModifiedVector);
% %xlabel('Время (с)');
% %ylabel('Напряжение(мкВ)');

% SelectedVector= ModifiedVector;

%SelectedVector= detrend(SelectedVector,'linear'); %для акселерометра при отключенном Баттерворте

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SelectedVector= ...
	notch_filtering(50,SelectedVector,SamplingRate,NotchFilterQ);
SelectedVector= ...
	notch_filtering(100,SelectedVector,SamplingRate,NotchFilterQ);
SelectedVector= ...
	notch_filtering(150,SelectedVector,SamplingRate,NotchFilterQ);
SelectedVector= ...
	notch_filtering(200,SelectedVector,SamplingRate,NotchFilterQ);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if this_is_EMG_channel,
 	LF= 60;
 	UF= 240;
    % LF= 2;
	% UF= 240;
else
	if DecimationFactor==20,
		LF = 0.1; 
	else
		LF= 2;
	end;		
	UF= 240;
end;

HalfRate= SamplingRate / 2; %частота Найквиста

W1= LF / HalfRate;
W2= UF / HalfRate;

% HalfOrder= 2;
HalfOrder= 4;

% Make order HalfOrder*2 bandpass digital filter:

[b,a]= butter(HalfOrder,[W1,W2]);

disp([	'Butterworth filter is used: ',...
	'LF= ',num2str(LF),' Hz, ',...
	'UF= ',num2str(UF),' Hz, ',...
	'order: 2*',num2str(HalfOrder),'*2= ',...
		num2str(2*HalfOrder*2),'.']);

SelectedVector= filtfilt(b,a,SelectedVector);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 if this_is_EMG_channel,
 	SelectedVector= abs(hilbert(SelectedVector));
 end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SelectedVector= decimate(SelectedVector,DecimationFactor);
SamplingRate= SamplingRate / DecimationFactor;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
