%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Matrix,Time] = readFile(FileName1,SamplingRate);

disp(['I will process file: ',FileName1]);

[PathStr,ShortName,ext]= fileparts(FileName1);

MatName1= fullfile(PathStr,[ShortName,'.bin']);

if exist(MatName1,'file'),
	try
		%
		load(MatName1,'-mat','Matrix','Time');
		%
		return;
		%
	catch
		%
		disp([	'Sorry, I don''t understand ',...
			'the format of the ',...
			MatName1,...
			' file!']);
		%
	end;
else
	disp([	'Sorry, the ',...
		MatName1,...
		' file don''t exist!']);

end;

TmpName1= fullfile(PathStr,[ShortName,'.tmp']);

FID1= fopen(FileName1,'r');
FID2= fopen(TmpName1,'w');

LineNumber= 0;

while true,
	%
	tline= fgetl(FID1);
	%
	LineNumber= LineNumber + 1;
	%
	if ~ischar(tline),
		%
		break;
		%
	elseif isempty(strtok(tline)),
		%
		continue;
		%
	elseif length(tline) > 0 && tline(1) == ';',
		%
		disp([num2str(LineNumber,'%07d'),'>>> ',tline]);
		%
		continue;
		%
	elseif isempty(str2num(tline)),
		%
		disp([num2str(LineNumber,'%07d'),'>>> ',tline]);
		%
		continue;
		%
	else
		%
		fprintf(FID2,'%s\n',tline);
		%
	end;
	%
end;

fclose(FID1);
fclose(FID2);

try
	%
	Matrix= load(TmpName1,'-ascii');
	%
catch
	%
	disp([	'Sorry, I don''t understand the format of the ',...
		FileName1,...
		' file!']);
	%
	Matrix= [];
	Time= [];
	%
	return;
	%
end;

delete(TmpName1);

[N_Rows,N_Columns]= size(Matrix);
Time= [0:N_Rows-1] / SamplingRate;

save(MatName1,'-v7.3','Matrix','Time');
