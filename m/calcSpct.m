%
% (c) 2014 IRE RAS Alexei A. Morozov
%
function [Pxx,Frequencies]= calcSpct(...
				Vector,...
				Rate,...
				RequestedWindowLength,...
				TrailingZerosIntervalLength,...
				SpectraWindowOverlap);

%---------------------------------------------------------------------%

N_Points= length(Vector);

%---------------------------------------------------------------------%

WindowWidth= round(RequestedWindowLength * Rate);

if TrailingZerosIntervalLength > 0,
	ZeroPaddingIntervalLength= ...
		round(WindowWidth*TrailingZerosIntervalLength/100);
	n_fft= WindowWidth + ZeroPaddingIntervalLength;
else
	n_fft= WindowWidth;
end;

WindowWidth= min(WindowWidth,N_Points);

switch SpectraWindowOverlap,
case 'no overlap',
	Shift= WindowWidth;
case '1 / 2',
	Shift= round(WindowWidth / 2);
case '3 / 4',
	Shift= round(WindowWidth / 4);
case '7 / 8',
	Shift= round(WindowWidth / 8);
case 'width - 1',
	Shift= 1;
otherwise
	error([	'Unknown overlap of window: ',...
		MainMode.SpectraWindowOverlap]);
end;

SpectraWindowType= 'Hann (Hanning)';

switch SpectraWindowType,
case 'modified Bartlett-Hann',
	Window= barthannwin(WindowWidth);
case 'Hann (Hanning)',
	Window= hann(WindowWidth);
case 'Hamming',
	Window= hamming(WindowWidth);
case 'Gaussian',
	Window= gausswin(WindowWidth);
case 'Blackman',
	Window= blackman(WindowWidth);
case 'Blackman-Harris',
	Window= blackmanharris(WindowWidth);
case 'Nuttall''s (modified Blackman-Harris)',
	Window= nuttallwin(WindowWidth);
case 'Flat Top weighted',
	Window= flattopwin(WindowWidth);
case 'Bohman',
	Window= bohmanwin(WindowWidth);
case 'Parzen (de la Valle-Poussin)',
	Window= parzenwin(WindowWidth);
case 'Chebyshev',
	Window= chebwin(WindowWidth,MainMode.SpectraWindowMagnitude);
case 'Kaiser',
	Window= kaiser(WindowWidth,MainMode.SpectraWindowBeta);
case 'Tukey',
	Window= tukeywin(WindowWidth,MainMode.SpectraWindowRatio);
case 'Bartlett',
	Window= bartlett(WindowWidth);
case 'triangular',
	Window= triang(WindowWidth);
case 'Boxcar (rectangular)',
	Window= rectwin(WindowWidth);
otherwise
	error([	'Unknown type of window: ',...
		MainMode.SpectraWindowType]);
end;

Frequencies= Rate * (0:n_fft-1) / n_fft;

N_Step= 0;

BeginningPoint= 1;

while true,
	%
	EndPoint= BeginningPoint + WindowWidth - 1;
	%
	if EndPoint > N_Points,
		%
		break;
		%
	end;
	%
	N_Step= N_Step + 1;
	%
	BeginningPoint= BeginningPoint + Shift;
	%
end;
%
Sum= [];
%
N_Step= 0;
%
BeginningPoint= 1;
%
while true,
	%
	EndPoint= BeginningPoint + WindowWidth - 1;
	%
	if EndPoint > N_Points,
		%
		break;
		%
	end;
	%
	Segment= Vector(BeginningPoint:EndPoint);
	%
	Segment= detrend(Segment,'linear');
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	Segment= Segment .* Window;
	% Y1= fft(Segment,WindowWidth);
	Y1= fft(Segment,n_fft);
	Y2= abs(Y1).^2;
	%
	Correction= 0;
	%
	for c=1:WindowWidth,
		Correction= Correction + Window(c).^2;
	end;
	%
	Y2= Y2 / Correction;
	%
	Y2= Y2 / Rate;
	%
	if rem(n_fft,2),	% Odd length nfft
		%
		SpectrumEnd= (n_fft + 1) / 2;
		%
		Y2= Y2(1:SpectrumEnd);
		%
		% This is the one-sided spectrum [Power]:
		Y2= [Y2(1); 2*Y2(2:end)];
		%
	else
		%
		SpectrumEnd= (n_fft / 2) + 1;
		%
		Y2= Y2(1:SpectrumEnd);
		%
		% This is the one-sided spectrum [Power]:
		Y2= [Y2(1); 2*Y2(2:end-1); Y2(end)];
		%
	end;
	%
	Frequencies= Frequencies(1:SpectrumEnd);
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	% [Y2,Frequencies]=...
	%	periodogram(Segment,Window,WindowWidth,Rate);
	%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	N_Step= N_Step + 1;
	%
	if isempty(Sum),
		%
		Sum= zeros(length(Y2),1);
		%
	end;
	%
	Sum= Sum + Y2;
	%
	BeginningPoint= BeginningPoint + Shift;
	%
end;

Pxx= Sum / N_Step;

%---------------------------------------------------------------------%
