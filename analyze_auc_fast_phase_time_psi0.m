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
% % % % %%% dimension= 'Durat'; %давно не используем
% dimension= 'Durat_in_Periods';
% dimension= 'Bandwidth';
% dimension= 'Phase';
% dimension= 'Time';
% dimension= 'Psi0';

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

% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по фазе
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
% for k=1:length(MinPhase), 
% 	CurrentMinPhase= MinPhase(k);
% 	for l=1:length(MaxPhase),
% 		CurrentMaxPhase= MaxPhase(l);	
% 		if CurrentMinPhase >= CurrentMaxPhase,
% 			AUC(a,b,c,d,e,f,g,h,i,j,k,l)= NaN;
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
% 	end;
% end;
% 
% 
% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по времени:
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
% for k=1:length(MinPhase), 
% 	CurrentMinPhase= MinPhase(k);
% 	for l=1:length(MaxPhase),
% 		CurrentMaxPhase= MaxPhase(l);	
% for m=1:length(MinTime), 
% 	CurrentMinTime= MinTime(m);
% 	for n=1:length(MaxTime),
% 		CurrentMaxTime= MaxTime(n);	
% 		if CurrentMinTime >= CurrentMaxTime,
% 			AUC(a,b,c,d,e,f,g,h,i,j,k,l,m,n)= NaN;
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
% 	end;
% end;
% 	end;
% end;


% for a=1:length(MinFreq), %этот цикл включает и выключает ниж. треуг-к по фи0:
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
% for k=1:length(MinPhase), 
% 	CurrentMinPhase= MinPhase(k);
% 	for l=1:length(MaxPhase),
% 		CurrentMaxPhase= MaxPhase(l);	
% for m=1:length(MinTime), 
% 	CurrentMinTime= MinTime(m);
% 	for n=1:length(MaxTime),
% 		CurrentMaxTime= MaxTime(n);	
% for o=1:length(MinPsi0), 
% 	CurrentMinPsi0= MinPsi0(o);
% 	for p=1:length(MaxPsi0),
% 		CurrentMaxPsi0= MaxPsi0(p);	
% 		if CurrentMinPsi0 >= CurrentMaxPsi0,
% 			AUC(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p)= NaN;
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
% 	end;
% end;
% 	end;
% end;
% 	end;
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
				
			for k=1:length(MinPhase),
				CurrentMinPhase= MinPhase(k);
				for l=1:length(MaxPhase),
					CurrentMaxPhase= MaxPhase(l);	
					
			for m=1:length(MinTime),
				CurrentMinTime= MinTime(m);
				for n=1:length(MaxTime),
					CurrentMaxTime= MaxTime(n);	
					
			for o=1:length(MinPsi0),
				CurrentMinPsi0= MinPsi0(o);
				for p=1:length(MaxPsi0),
					CurrentMaxPsi0= MaxPsi0(p);	
%:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::%
CurrentAUC= AUC(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p);
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
	CurrentMinPhase_global_MAX= CurrentMinPhase;
	CurrentMaxPhase_global_MAX= CurrentMaxPhase;	
	CurrentMinTime_global_MAX= CurrentMinTime;
	CurrentMaxTime_global_MAX= CurrentMaxTime;	
	CurrentMinPsi0_global_MAX= CurrentMinPsi0;
	CurrentMaxPsi0_global_MAX= CurrentMaxPsi0;	
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
	CurrentMinPhase_global_MIN= CurrentMinPhase;
	CurrentMaxPhase_global_MIN= CurrentMaxPhase;
	CurrentMinTime_global_MIN= CurrentMinTime;
	CurrentMaxTime_global_MIN= CurrentMaxTime;
	CurrentMinPsi0_global_MIN= CurrentMinPsi0;
	CurrentMaxPsi0_global_MIN= CurrentMaxPsi0;
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
	end;
end;
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
disp(['MinPhase_MAX= ', num2str(CurrentMinPhase_global_MAX)]);
disp(['MaxPhase_MAX= ', num2str(CurrentMaxPhase_global_MAX)]);
disp(['MinTime_MAX= ', num2str(CurrentMinTime_global_MAX)]);
disp(['MaxTime_MAX= ', num2str(CurrentMaxTime_global_MAX)]);
disp(['MinPsi0_MAX= ', num2str(CurrentMinPsi0_global_MAX)]);
disp(['MaxPsi0_MAX= ', num2str(CurrentMaxPsi0_global_MAX)]);
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
disp(['MinPhase_MIN= ', num2str(CurrentMinPhase_global_MIN)]);
disp(['MaxPhase_MIN= ', num2str(CurrentMaxPhase_global_MIN)]);
disp(['MinTime_MIN= ', num2str(CurrentMinTime_global_MIN)]);
disp(['MaxTime_MIN= ', num2str(CurrentMaxTime_global_MIN)]);
disp(['MinPsi0_MIN= ', num2str(CurrentMinPsi0_global_MIN)]);
disp(['MaxPsi0_MIN= ', num2str(CurrentMaxPsi0_global_MIN)]);
disp(['CurrentMin= ', num2str(current_min)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_surfes_fast_phase_time_psi0(...
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
	Names,...DirWithEDF_left,...
	AUC,...H_value,...TimeHalfwidthValue,...
    dimension);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
