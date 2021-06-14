%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2015 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fclose('all');
close('all');
clear('all');
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% addpath - указывает, где искать подпрограммы (функции)
% cd - возвращает полный путь текущей директории
addpath([cd,'/m']);
addpath([cd,'/tables']);
% \\ или / нужно поставить, указывая путь

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FileName='Table_AUC';

dimension= 'Freq';
% dimension= 'Ampl';
% dimension= 'Durat'; %давно не используем
% dimension= 'Durat_in_Periods';
% dimension= 'Bandwidth';

load(...
	FileName,...
	'AUC',...'H_value',...'TimeHalfwidthValue',...
	'MinFreq',...
	'MaxFreq',... 
    'MinAmpl',... 
	'MaxAmpl',...
	'MinDurat',...
	'MaxDurat',...
    'MinDurat_in_Periods',...
	'MaxDurat_in_Periods',...
	'MinBandwidth',...
	'MaxBandwidth',...
	'MinPhase',...
	'MaxPhase',...
	'MinTime',...
	'MaxTime',...
	'MinPsi0',...
	'MaxPsi0',...
	'Names',...'DirWithEDF_left',... 
	'CName'...
	);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по частоте
% 	CurrentMinFreq= MinFreq(a);
% 	for b=1:length(MaxFreq),
% 		CurrentMaxFreq= MaxFreq(b);
% 		if CurrentMinFreq >= CurrentMaxFreq,
% 			AUC(a,b)= NaN;
% 		end;
% 	end;
% end;
%%%
% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по амплитуде
% 	CurrentMinFreq= MinFreq(a);
% 	for b=1:length(MaxFreq),
% 		CurrentMaxFreq= MaxFreq(b);
% for c=1:length(MinAmpl), 
% 	CurrentMinAmpl= MinAmpl(c);
% 	for d=1:length(MaxAmpl),
% 		CurrentMaxAmpl= MaxAmpl(d);
% 		if CurrentMinAmpl >= CurrentMaxAmpl,
% 			AUC(a,b,c,d)= NaN;
% 		end;
% 	end;
% end;
%  	end;
% end;
% %%%
% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по периодам
% 	CurrentMinFreq= MinFreq(a);
% 	for b=1:length(MaxFreq),
% 		CurrentMaxFreq= MaxFreq(b);
% for c=1:length(MinAmpl), 
% 	CurrentMinAmpl= MinAmpl(c);
% 	for d=1:length(MaxAmpl),
% 		CurrentMaxAmpl= MaxAmpl(d);
% for e=1:length(MinDurat), 
% 	CurrentMinDurat= MinDurat(e);
% 	for f=1:length(MaxDurat),
% 		CurrentMaxDurat= MaxDurat(f);		
% for g=1:length(MinDurat_in_Periods), 
% 	CurrentMinDurat_in_Periods= MinDurat_in_Periods(g);
% 	for h=1:length(MaxDurat_in_Periods),
% 		CurrentMaxDurat_in_Periods= MaxDurat_in_Periods(h);	
% 		if CurrentMinDurat_in_Periods >= CurrentMaxDurat_in_Periods,
% 			AUC(a,b,c,d,e,f,g,h)= NaN;
% 		end;
% 	end;
% end;
%  	end;
% end;
%  	end;
% end;
%  	end;
% end;
%%%
% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по банд
% 	CurrentMinFreq= MinFreq(a);
% 	for b=1:length(MaxFreq),
% 		CurrentMaxFreq= MaxFreq(b);
% for c=1:length(MinAmpl), 
% 	CurrentMinAmpl= MinAmpl(c);
% 	for d=1:length(MaxAmpl),
% 		CurrentMaxAmpl= MaxAmpl(d);
% for e=1:length(MinDurat), 
% 	CurrentMinDurat= MinDurat(e);
% 	for f=1:length(MaxDurat),
% 		CurrentMaxDurat= MaxDurat(f);		
% for g=1:length(MinDurat_in_Periods), 
% 	CurrentMinDurat_in_Periods= MinDurat_in_Periods(g);
% 	for h=1:length(MaxDurat_in_Periods),
% 		CurrentMaxDurat_in_Periods= MaxDurat_in_Periods(h);	
% for i=1:length(MinBandwidth), 
% 	CurrentMinBandwidth= MinBandwidth(i);
% 	for j=1:length(MaxBandwidth),
% 		CurrentMaxBandwidth= MaxBandwidth(j);	
% 		if CurrentMinBandwidth >= CurrentMaxBandwidth,
% 			AUC(a,b,c,d,e,f,g,h,i,j)= NaN;
% 		end;
% 	end;
% end;
%  	end;
% end;
%  	end;
% end;
%  	end;
% end;
%  	end;
% end;


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
current_max= -Inf; 
current_min= Inf; 

for a=1:length(MinFreq),
	CurrentMinFreq= MinFreq(a);
	for b=1:length(MaxFreq),
		CurrentMaxFreq= MaxFreq(b);
        for c=1:length(MinAmpl),
			CurrentMinAmpl= MinAmpl(c);
			for d=1:length(MaxAmpl),
				CurrentMaxAmpl= MaxAmpl(d);
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
for e=1:length(MinDurat),
	CurrentMinDurat= MinDurat(e);
	for f=1:length(MaxDurat),
		CurrentMaxDurat= MaxDurat(f);
    
    for g=1:length(MinDurat_in_Periods),
	CurrentMinDurat_in_Periods= MinDurat_in_Periods(g);
        for h=1:length(MaxDurat_in_Periods),
		CurrentMaxDurat_in_Periods= MaxDurat_in_Periods(h);    
                
		for i=1:length(MinBandwidth),
			CurrentMinBandwidth= MinBandwidth(i);
			for j=1:length(MaxBandwidth),
				CurrentMaxBandwidth= MaxBandwidth(j);
				

%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
CurrentAUC= AUC(a,b,c,d,e,f,g,h,i,j);
if CurrentAUC > current_max,
	current_max= CurrentAUC;
	CurrentMinFreq_global_MAX= CurrentMinFreq; 
	CurrentMaxFreq_global_MAX= CurrentMaxFreq;
    CurrentMinAmpl_global_MAX= CurrentMinAmpl;
	CurrentMaxAmpl_global_MAX= CurrentMaxAmpl;
	CurrentMinDurat_global_MAX= CurrentMinDurat;
	CurrentMaxDurat_global_MAX= CurrentMaxDurat;
    CurrentMinDurat_in_Periods_global_MAX= CurrentMinDurat_in_Periods;
	CurrentMaxDurat_in_Periods_global_MAX= CurrentMaxDurat_in_Periods;
	CurrentMinBandwidth_global_MAX= CurrentMinBandwidth;
	CurrentMaxBandwidth_global_MAX= CurrentMaxBandwidth;
end;
if CurrentAUC < current_min,
	current_min= CurrentAUC;
	CurrentMinFreq_global_MIN= CurrentMinFreq; 
	CurrentMaxFreq_global_MIN= CurrentMaxFreq;
    CurrentMinAmpl_global_MIN= CurrentMinAmpl;
	CurrentMaxAmpl_global_MIN= CurrentMaxAmpl;
	CurrentMinDurat_global_MIN= CurrentMinDurat;
	CurrentMaxDurat_global_MIN= CurrentMaxDurat;
    CurrentMinDurat_in_Periods_global_MIN= CurrentMinDurat_in_Periods;
	CurrentMaxDurat_in_Periods_global_MIN= CurrentMaxDurat_in_Periods;
	CurrentMinBandwidth_global_MIN= CurrentMinBandwidth;
	CurrentMaxBandwidth_global_MIN= CurrentMaxBandwidth;
end;
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
    end;
end;
	end;
end;
    end;
end;
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
			end;
		end;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(['MinFreq_MAX= ', num2str(CurrentMinFreq_global_MAX)]);
disp(['MaxFreq_MAX= ', num2str(CurrentMaxFreq_global_MAX)]);
disp(['MinAmpl_MAX= ', num2str(CurrentMinAmpl_global_MAX)]);
disp(['MaxAmpl_MAX= ', num2str(CurrentMaxAmpl_global_MAX)]);
disp(['MinDurat_MAX= ', num2str(CurrentMinDurat_global_MAX)]);
disp(['MaxDurat_MAX= ', num2str(CurrentMaxDurat_global_MAX)]);
disp(['MinDurat_in_Periods_MAX= ', num2str(CurrentMinDurat_in_Periods_global_MAX)]);
disp(['MaxDurat_in_Periods_MAX= ', num2str(CurrentMaxDurat_in_Periods_global_MAX)]);
disp(['MinBandwidth_MAX= ', num2str(CurrentMinBandwidth_global_MAX)]);
disp(['MaxBandwidth_MAX= ', num2str(CurrentMaxBandwidth_global_MAX)]);
disp(['CurrentMax= ', num2str(current_max)]);

disp(['MinFreq_MIN= ', num2str(CurrentMinFreq_global_MIN)]);
disp(['MaxFreq_MIN= ', num2str(CurrentMaxFreq_global_MIN)]);
disp(['MinAmpl_MIN= ', num2str(CurrentMinAmpl_global_MIN)]);
disp(['MaxAmpl_MIN= ', num2str(CurrentMaxAmpl_global_MIN)]);
disp(['MinDurat_MIN= ', num2str(CurrentMinDurat_global_MIN)]);
disp(['MaxDurat_MIN= ', num2str(CurrentMaxDurat_global_MIN)]);
disp(['MinDurat_in_Periods_MIN= ', num2str(CurrentMinDurat_in_Periods_global_MIN)]);
disp(['MaxDurat_in_Periods_MIN= ', num2str(CurrentMaxDurat_in_Periods_global_MIN)]);
disp(['MinBandwidth_MIN= ', num2str(CurrentMinBandwidth_global_MIN)]);
disp(['MaxBandwidth_MIN= ', num2str(CurrentMaxBandwidth_global_MIN)]);
disp(['CurrentMin= ', num2str(current_min)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_surfes_fast_(...
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
	Names,...DirWithEDF_left,...
	AUC,...H_value,...TimeHalfwidthValue,...
    dimension);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
