%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_signal(...
		Fig,...
		InputFileName,...
		SamplingRate,...
		SelectedChannelName,...
		Time,...
		SelectedVector,...
		save_figures);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[PathStr,ShortName,ext]= fileparts(InputFileName);

[FontName,FontSize,FontWeight]= fontAttr();

figure(Fig);
set(figure(Fig),'Color',[1,1,1]);
set(figure(Fig),'NumberTitle','off');
set(figure(Fig),'name',[...
	'Signal; ',ShortName,'; ',...
	SelectedChannelName,'; ',...
	'Rate ',num2str(SamplingRate)]);
plot(Time,SelectedVector);
set(gca,'FontName',FontName);
set(gca,'FontSize',FontSize);
set(gca,'FontWeight',FontWeight);
title([	... 'Signal, ',...
	ShortName,', ',...
	SelectedChannelName,', ',...
	'Rate: ',num2str(SamplingRate)],...
	'FontName',FontName,...
	'FontSize',10,...
	'FontWeight',FontWeight,...
	'Interpreter','none');
xlabel('Time [sec]');
ylabel('Signal [mV]');

rsz_wnd(Fig);

if save_figures,
	CurrentDirectory= cd;
	FigureName1= fullfile(...
		[PathStr,'/',ShortName],...
		[...
		'Signal-',...
		ShortName,'-',...
		'[',...
		SelectedChannelName,...
		']']);
	cd(PathStr);
	[s,mess,messid]= mkdir(ShortName);
	save_Fig(FigureName1);
	cd(CurrentDirectory);
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
