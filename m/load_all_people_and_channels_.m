%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2017 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ...
[...
MegaStructure,...
ListOfFileNames,...
NumberOfFileNames,...
NumberOfCNames...
]= load_all_people_and_channels_(...
	InputFolder,...
	CName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

List= dir(InputFolder);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

counter= 0;

ListOfFileNames= cell(counter,1);

for n=1:length(List),
	SelectedFile= List(n).name;
	[~,~,ext]= fileparts(SelectedFile);
	LowerLettersOfExtOfSelectedFile= lower(ext);
	if strcmp(LowerLettersOfExtOfSelectedFile,'.txt'),
		counter= counter + 1;
		ListOfFileNames{counter,1}= SelectedFile;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ListOfFileNames= sort(ListOfFileNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NumberOfFileNames= length(ListOfFileNames);
NumberOfCNames= length(CName);

for i=1:NumberOfFileNames,
	%
	CurrentFileName= ListOfFileNames{i};
	[NN1,ShortName,ext]= fileparts(CurrentFileName);
	%
	for z=1:NumberOfCNames,
		%
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%

FN1= [InputFolder,'/',ShortName,ext,'_',CName{z},'Freq','.mat'];
FN2= [InputFolder,'/',ShortName,ext,'_',CName{z},'Ampl','.mat'];
FN3= [InputFolder,'/',ShortName,ext,'_',CName{z},'DuratSeconds','.mat'];
FN4= [InputFolder,'/',ShortName,ext,'_',CName{z},'DuratPeriods','.mat'];
FN5= [InputFolder,'/',ShortName,ext,'_',CName{z},'BandwidthesHz','.mat'];
FN6= [InputFolder,'/',ShortName,ext,'_',CName{z},'TimeAndFrequency','.mat'];

S1= load(FN1,'Flash_Freq_Stack');
S2= load(FN2,'Flash_Ampl_Stack');
S3= load(FN3,'Flash_Durat_In_Seconds_Stack');
S4= load(FN4,'Flash_Durat_In_Periods_Stack');
S5= load(FN5,'Flash_Band_In_Hz_Stack');
S6= load(FN6,'Time');

Time= S6.Time;

MegaStructure(i).FileName= CurrentFileName;
MegaStructure(i).(CName{z}){1}= S1;
MegaStructure(i).(CName{z}){2}= S2;
MegaStructure(i).(CName{z}){3}= S3;
MegaStructure(i).(CName{z}){4}= S4;
MegaStructure(i).(CName{z}){5}= S5;
MegaStructure(i).(CName{z}){6}.Duration= max(Time) - min(Time);

%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
		%
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
