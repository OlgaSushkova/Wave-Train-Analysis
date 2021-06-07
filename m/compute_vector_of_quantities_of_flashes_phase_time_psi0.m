%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ...
[...
VectorOfQuantityOfFlashes,...
VectorOfFrequencies_Wave,... %17-05-2021
VectorOfAmplitudes_Wave,...%17-05-2021
VectorOfDurations_Wave,...%17-05-2021
VectorOfDurations_in_Periods_Wave,... %17-05-2021
VectorOfBandwidthes_Wave,... %17-05-2021
VectorOfPhases_Wave,... %17-05-2021
VectorOfTimes_Wave,... %24-05-2021
VectorOfPsi0_Wave... %26-05-2021
]= compute_vector_of_quantities_of_flashes(...
	MinFreq,... 
	MaxFreq,...
	MinAmpl,...
	MaxAmpl,...
	MinDurat,...
	MaxDurat,...
	MinDurat_in_Periods,...
	MaxDurat_in_Periods,...
	MinBandwidth,...
	MaxBandwidth,...
	MinPhase,...
	MaxPhase,...
    MinTime,...
	MaxTime,...
	MinPsi0,...
	MaxPsi0,...
	MatrixOfFlashes,...
	N_Patients,...
	N_Controls,...
	CName,...
	NumberOfFolder,...
	LengthOfFolder...	
	);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LengthOfCName= length(CName);

VectorOfFrequencies_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfAmplitudes_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfDurations_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfDurations_in_Periods_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfBandwidthes_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfPhases_Wave=cell(1,LengthOfFolder); %17-05-2021
VectorOfTimes_Wave=cell(1,LengthOfFolder); %24-05-2021
VectorOfPsi0_Wave=cell(1,LengthOfFolder); %26-05-2021

for i=1:LengthOfFolder,
	%
	for z=1:LengthOfCName,
		%
%=====================================================================%

VectorOfFrequencies= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){1}.Flash_Freq_Stack;
VectorOfAmplitudes= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){2}.Flash_Ampl_Stack;
VectorOfDurations= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){3}.Flash_Durat_In_Seconds_Stack;
VectorOfDurations_in_Periods= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){4}.Flash_Durat_In_Periods_Stack;
VectorOfBandwidthes= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){5}.Flash_Band_In_Hz_Stack;
Duration= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){6}.Duration;
VectorOfPhases= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){7}.Flash_Phase_Stack;%17-05-2021
VectorOfTimes= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){8}.Flash_Time_Stack;%24-05-2021
VectorOfPsi0= MatrixOfFlashes{NumberOfFolder}(i).(CName{z}){9}.Flash_Psi0_Stack;%26-05-2021

assignin('base','VectorOfFrequencies',VectorOfFrequencies);

QuantityOfFlashes= 0;
Counter = 0;
VectorOfFrequencies_Wave_column= NaN(length(VectorOfFrequencies),1); %17-05-2021
VectorOfAmplitudes_Wave_column= NaN(length(VectorOfAmplitudes),1); %17-05-2021
VectorOfDurations_Wave_column= NaN(length(VectorOfDurations),1); %17-05-2021
VectorOfDurations_in_Periods_Wave_column= NaN(length(VectorOfDurations_in_Periods),1); %17-05-2021
VectorOfBandwidthes_Wave_column= NaN(length(VectorOfBandwidthes),1); %17-05-2021
VectorOfPhases_Wave_column= NaN(length(VectorOfPhases),1); %17-05-2021
VectorOfTimes_Wave_column= NaN(length(VectorOfTimes),1); %24-05-2021
VectorOfPsi0_Wave_column= NaN(length(VectorOfPsi0),1); %26-05-2021

for v=1:length(VectorOfFrequencies),
	CurrentFreq= VectorOfFrequencies(v);
	CurrentAmpl= VectorOfAmplitudes(v);
	CurrentDurat= VectorOfDurations(v);
	CurrentDurat_in_Periods= VectorOfDurations_in_Periods(v);
	CurrentBandwidth= VectorOfBandwidthes(v);
	CurrentPhase= VectorOfPhases(v);%17-05-2021
	CurrentTime= VectorOfTimes(v);%24-05-2021
    CurrentPsi0= VectorOfPsi0(v);%26-05-2021
	
	if MinFreq <= MaxFreq,
		if  	CurrentFreq < MinFreq ||...
			CurrentFreq > MaxFreq,
			continue;
		end;
	else
		if  	CurrentFreq >= MaxFreq &&...
			CurrentFreq <= MinFreq,
			continue;
		end;
	end;
	if MinAmpl <= MaxAmpl,
		if  	CurrentAmpl < MinAmpl ||...
			CurrentAmpl > MaxAmpl,
			continue;
		end;
	else
		if  	CurrentAmpl >= MaxAmpl &&...
			CurrentAmpl <= MinAmpl,
			continue;
		end;
	end;
	if MinDurat <= MaxDurat,
		if  	CurrentDurat < MinDurat ||...
			CurrentDurat > MaxDurat,
			continue;
		end;
	else
		if  	CurrentDurat >= MaxDurat &&...
			CurrentDurat <= MinDurat,
			continue;
		end;
	end;
	if MinDurat_in_Periods <= MaxDurat_in_Periods,
		if  	CurrentDurat_in_Periods < MinDurat_in_Periods ||...
			CurrentDurat_in_Periods > MaxDurat_in_Periods,
			continue;
		end;
	else
		if  	CurrentDurat_in_Periods >= MaxDurat_in_Periods &&...
			CurrentDurat_in_Periods <= MinDurat_in_Periods,
			continue;
		end;
	end;
	if MinBandwidth <= MaxBandwidth,
		if  	CurrentBandwidth < MinBandwidth ||...
			CurrentBandwidth > MaxBandwidth,
			continue;
		end;
	else
		if  	CurrentBandwidth >= MaxBandwidth &&...
			CurrentBandwidth <= MinBandwidth,
			continue;
		end;
	end;
	if MinPhase <= MaxPhase,
		if  	CurrentPhase < MinPhase ||...
			CurrentPhase > MaxPhase,
			continue;
		end;
	else
		if  	CurrentPhase >= MaxPhase &&...
			CurrentPhase <= MinPhase,
			continue;
		end;
	end;
    if MinTime <= MaxTime,
		if  	CurrentTime < MinTime ||...
			CurrentTime > MaxTime,
			continue;
		end;
	else
		if  	CurrentTime >= MaxTime &&...
			CurrentTime <= MinTime,
			continue;
		end;
	end;
	
	if MinPsi0 <= MaxPsi0,
		if  	CurrentPsi0 < MinPsi0 ||...
			CurrentPsi0 > MaxPsi0,
			continue;
		end;
	else
		if  	CurrentPsi0 >= MaxPsi0 &&...
			CurrentPsi0 <= MinPsi0,
			continue;
		end;
	end;
	
	QuantityOfFlashes= QuantityOfFlashes + 1;
    Counter = Counter+1;
    
    VectorOfFrequencies_Wave_column(Counter)=CurrentFreq;  %17-05-2021
    VectorOfAmplitudes_Wave_column(Counter)=CurrentAmpl;  %17-05-2021
    VectorOfDurations_Wave_column(Counter)=CurrentDurat;  %17-05-2021
    VectorOfDurations_in_Periods_Wave_column(Counter)=CurrentDurat_in_Periods;  %17-05-2021
    VectorOfBandwidthes_Wave_column(Counter)=CurrentBandwidth;  %17-05-2021
    VectorOfPhases_Wave_column(Counter)=CurrentPhase;  %17-05-2021
    VectorOfTimes_Wave_column(Counter)=CurrentTime;  %24-05-2021
	VectorOfPsi0_Wave_column(Counter)=CurrentPsi0;  %26-05-2021
end;


QuantityOfFlashes= QuantityOfFlashes / Duration;
VectorOfQuantityOfFlashes(i,z)= QuantityOfFlashes;

VectorOfFrequencies_Wave{i}=VectorOfFrequencies_Wave_column(1:Counter); %17-05-2021
VectorOfAmplitudes_Wave{i}=VectorOfAmplitudes_Wave_column(1:Counter); %17-05-2021
VectorOfDurations_Wave{i}=VectorOfDurations_Wave_column(1:Counter); %17-05-2021
VectorOfDurations_in_Periods_Wave{i}=VectorOfDurations_in_Periods_Wave_column(1:Counter); %17-05-2021
VectorOfBandwidthes_Wave{i}=VectorOfBandwidthes_Wave_column(1:Counter); %17-05-2021
VectorOfPhases_Wave{i}=VectorOfPhases_Wave_column(1:Counter); %17-05-2021
VectorOfTimes_Wave{i}=VectorOfTimes_Wave_column(1:Counter); %24-05-2021
VectorOfPsi0_Wave{i}=VectorOfPsi0_Wave_column(1:Counter); %26-05-2021
%=====================================================================%
			
	end;
  	%
end;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
