%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Подпрограмма построения еще одной гистограммы                       %
% Авторы: Сушкова О.С., Морозов А.А.                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ...
[...
Matrix,...
x...
]= o_hist(...
	Filtered_Ampl_1,...
	Filtered_Freq_1,...
	Kol_stolb,...	
	xmin,...	
	xmax,...
	TimeInterval,...
	Title,...
	ViborHist);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sh= (xmax - xmin) / Kol_stolb;

Matrix= zeros(length(Filtered_Freq_1),Kol_stolb);
Matrix(:,:)= NaN;

Matrix_kol_vo_el_v_stolbce= zeros(1,Kol_stolb);
Matrix_summ_el_v_stolbce= zeros(1,Kol_stolb);
Matrix_standardised_gist= zeros(1,Kol_stolb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:Kol_stolb,
	Kol_vo_el_v_stolbce= 0;
        for v=1:length(Filtered_Freq_1),
		CurrentValue= Filtered_Freq_1(v);
		if k == 1,
			if xmin <= CurrentValue && CurrentValue <= xmin+sh,
				Kol_vo_el_v_stolbce= ...
					Kol_vo_el_v_stolbce + 1;
				Matrix(Kol_vo_el_v_stolbce,k)= CurrentValue;
				Matrix_summ_el_v_stolbce(k)= ...
					Matrix_summ_el_v_stolbce(k) + Filtered_Ampl_1(v);
				Matrix_kol_vo_el_v_stolbce(k)= ...
					Matrix_kol_vo_el_v_stolbce(k) + 1;
			end;
		else
			if xmin+(k-1)*sh < CurrentValue && CurrentValue <= xmin+k*sh,
				Kol_vo_el_v_stolbce= ...
					Kol_vo_el_v_stolbce + 1;
				Matrix(Kol_vo_el_v_stolbce,k)= CurrentValue;
				Matrix_summ_el_v_stolbce(k)= ...
					Matrix_summ_el_v_stolbce(k) + Filtered_Ampl_1(v);
				Matrix_kol_vo_el_v_stolbce(k)= ...
					Matrix_kol_vo_el_v_stolbce(k) + 1;
			end;
		end;
	end;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:Kol_stolb,
	Matrix_standardised_gist(k)= ...
		Matrix_summ_el_v_stolbce(k) ./ ...
		Matrix_kol_vo_el_v_stolbce(k);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x= xmin+sh/2:sh:xmax;

if strcmp(ViborHist,'simple'),
	Matrix= Matrix_kol_vo_el_v_stolbce/TimeInterval;
elseif strcmp(ViborHist,'summa'),
	Matrix= Matrix_summ_el_v_stolbce/TimeInterval;
elseif strcmp(ViborHist,'standard'),
	Matrix= Matrix_standardised_gist;
else
	disp ([...
		'Nepravilnoe imia peremennoi ViborHist: ',...
		ViborHist]);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
