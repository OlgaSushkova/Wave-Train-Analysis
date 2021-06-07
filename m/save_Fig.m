%---------------------------------------------------------------------%
% (c) 2015 IRE RAS Alexei A. Morozov                                  %
%---------------------------------------------------------------------%

function save_Fig(FigureName);

%---------------------------------------------------------------------%

[PathStr,ShortName,ext]= fileparts(FigureName);

%---------------------------------------------------------------------%

% saveas(gcf,FigureName,'fig');

fclose('all');

% [status,result]= system('erase *.bmp');
%---------------------------------------------------------------------%
% BMP_JobList= dir([PathStr,'/*.bmp']);
% N_Job= length(BMP_JobList);
% for p=1:N_Job,
%	%
%	BMP_FileName= BMP_JobList(p).name;
%	delete([PathStr,'/',BMP_FileName]);
%	%
% end;
%---------------------------------------------------------------------%

BMP_FileName= [FigureName,'.bmp'];
% PNG_FileName= [FigureName,'.png'];
JPG_FileName= [FigureName,'.jpg'];

try
	%
	print(BMP_FileName,gcf,'-dbmp','-zbuffer');
	X= imread(BMP_FileName,'bmp');
	%
	% print(PNG_FileName,gcf,'-dpng','-zbuffer');
	% X= imread(PNG_FileName,'png');
	%
	C1= mk_C_2;
	imwrite(X,JPG_FileName,'jpg',...
		'Quality',100,'Comment',C1);
	%
	% try
	%	% delete([FigureName,'.BMP']);
	% end;
end;

%---------------------------------------------------------------------%

BMP_JobList= dir([PathStr,'/*.bmp']);

N_Job= length(BMP_JobList);

for p=1:N_Job,
	%
	BMP_FileName= BMP_JobList(p).name;
	delete([PathStr,'/',BMP_FileName]);
	%
end;

%---------------------------------------------------------------------%
