%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function... 
[...
Matrix,...
Frequencies...
] = calcWavelet(...
		InputFileName,...
		SelectedVector,...
		SamplingRate,...
		Low_Freq,...
		Step_Freq,...
		Upper_Freq,...
		Fb,...
		Fc);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

WaveletName= ['cmor',num2str(Fb),'-',num2str(Fc)];

Frequencies= [Low_Freq:Step_Freq:Upper_Freq];
F_Length= length(Frequencies);

S= zeros(F_Length,1);

for e=1:length(Frequencies),
	%
	S(e)= Fc * SamplingRate / Frequencies(e);
	%
end;

N_Time= length(SelectedVector);

Matrix= zeros(F_Length,N_Time);

Matrix(:,:)= cwt(SelectedVector,S,WaveletName);

%Matrix= (abs(Matrix)).^2; % убрано 13-05-2021, когда стали вычислять фазу
%всплесков

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
