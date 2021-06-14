%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_surfes_fast_phase_time_psi0(...
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
			Names,...
			AUC,...
            dimension);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scrsize = get(0, 'ScreenSize');

[FontName,FontSize,FontWeight]= fontAttr();
FontSize=  36;

Fig= 1000;
FolderNamePatients= '';
StatusOfHemisphereOrHand= '';

[A,B,C,D,E,F,G,H,I,J,K,L]= size(AUC);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(dimension,'Freq'),

	AUC_section= AUC(:,:,1,1,1,1,1,1,1,1);
	AUC_section= reshape(AUC_section,A,B);
	FigIDNT = figure(Fig);
	set (FigIDNT,'Position',scrsize);
	set(gcf,'PaperPositionMode','auto');
	set(FigIDNT,'Color',[1,1,1]);
	set(FigIDNT,'NumberTitle','off');
	set(FigIDNT,'name','');
	set(FigIDNT,'RendererMode','manual');
	set(FigIDNT,'Renderer','zbuffer');
	% surf(MinFreq,MaxFreq,abs(AUC_section'-0.5));
	surf(MinFreq,MaxFreq,AUC_section');
	shading('interp');
	xlabel(...
		'MinFreq [Hz]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	ylabel(...
		'MaxFreq [Hz]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	zlabel(...
		'AUC',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
end;

if strcmp(dimension,'Ampl'),
	AUC_section= AUC(1,1,:,:,1,1,1,1,1,1);
	AUC_section= reshape(AUC_section,C,D);
	FigIDNT = figure(Fig);
	surf(MinAmpl,MaxAmpl,AUC_section');
	shading('interp');
	xlabel(...
		'MinAmpl [\muV]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight,...
        'Interpreter','tex');
	ylabel(...
		'MaxAmpl [\muV]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight,...
        'Interpreter','tex');
	zlabel(...
		'AUC',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
end;

if strcmp(dimension,'Durat'),
	AUC_section= ...
		AUC(...
			1,1,1,1,:,:,1,1,1,1);
	AUC_section= reshape(AUC_section,E,F);
	FigIDNT = figure(Fig);
	surf(MinDurat,MaxDurat,AUC_section');
	shading('interp');
	xlabel(...
		'MinDurat',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	ylabel(...
		'MaxDurat',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	zlabel(...
		'AUC',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
end;

if strcmp(dimension,'Durat_in_Periods'),
	AUC_section= ...
		AUC(...
			1,1,1,1,1,1,:,:,1,1);
	AUC_section= reshape(AUC_section,G,H);
	FigIDNT = figure(Fig);
	surf(MinDurat_in_Periods,MaxDurat_in_Periods,AUC_section');
	shading('interp');
	xlabel(...
		'MinDurat_in_Periods [Periods]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight,...
        'Interpreter','none');
	ylabel(...
		'MaxDurat_in_Periods [Periods]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight,...
        'Interpreter','none');
	zlabel(...
		'AUC',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
end;


if strcmp(dimension,'Bandwidth'),
	AUC_section= ...
		AUC(...
			1,1,1,1,1,1,1,1,:,:);
	AUC_section= reshape(AUC_section,I,J);
	FigIDNT = figure(Fig);
	surf(MinBandwidth,MaxBandwidth,AUC_section');
	shading('interp');
	xlabel(...
		'MinBandwidth [Hz]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	ylabel(...
		'MaxBandwidth [Hz]',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
	zlabel(...
		'AUC',...
		'FontName',FontName,...
		'FontSize',FontSize,...
		'FontWeight',FontWeight);
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if ~isempty(strfind(InputFolder_Patients,'Essential')) ||...
% ~isempty(~strfind(lower(InputFolder_Patients),'right')) ||...
% ~isempty(~strfind(lower(InputFolder_Patients),'left')),
% Names
WindowTitle= [...
   	Names...
	];

	
title(...
	WindowTitle,...
	'Color','k',...
	'FontName',FontName,...
	'FontSize',FontSize-15,...
	'FontWeight',FontWeight,...
	'HorizontalAlignment','center',...
	'Interpreter','none'...
	);
	
% ������� B = reshape(A, m, n) ���������� ������ �������� m � n, 
% �������������� �� ��������� ������� A ����� �� ���������������� 
% ������� �� ��������.

set(gca,'FontName',FontName);
set(gca,'FontSize',FontSize);
set(gca,'FontWeight',FontWeight);
set(gcf,'ColorMap',jet);

caxis([0,1]);
view(0,90);

colorbar(...
	'FontName',FontName,...
	'FontSize',FontSize,...
	'FontWeight',FontWeight,...
	'location','EastOutside'...
	);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
