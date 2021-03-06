%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2015 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_flashes(...
	Fig,...
	ShortName,...
	SelectedChannelName,...
	SamplingRate,...
	Time_marks_of_flashes,...
	Frequencies_of_flashes);

[FontName,FontSize,FontWeight]= fontAttr();

figure(Fig);

set(figure(Fig),'Color',[1,1,1]);
set(figure(Fig),'NumberTitle','off');
set(figure(Fig),'name',...
	[...
	'Signal; ',...
	ShortName,...
	'; ',...
	SelectedChannelName,'; ',...
	'Rate ',num2str(SamplingRate)...
	]);

plot(Time_marks_of_flashes,Frequencies_of_flashes,'o');

set(gca,'FontName',FontName);
set(gca,'FontSize',FontSize);
set(gca,'FontWeight',FontWeight);
title([...
	ShortName,', ',...
	SelectedChannelName,', ',...
	'Rate: ',num2str(SamplingRate)],...
	'FontName',FontName,...
	'FontSize',10,...
	'FontWeight',FontWeight,...
	'Interpreter','none');
xlabel('Time [sec]');
ylabel('Frequency [Hz]');

rsz_wnd(Fig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
