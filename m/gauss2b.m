%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2014 Olga S. Sushkova, Alexei A. Morozov                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function matrix = gauss2b(FullWidth_time_in_Dots,FullWidth_frequency_in_Dots);

alpha= 2.5;

sigmaX= FullWidth_time_in_Dots / (2*alpha);
% disp(['sigmaX: ',num2str(sigmaX)]);

sigmaY= FullWidth_frequency_in_Dots / (2*alpha);
% disp(['sigmaY: ',num2str(sigmaY)]);

HalfWidth_time_in_Dots= (FullWidth_time_in_Dots - 1) / 2;
HalfWidth_frequency_in_Dots= (FullWidth_frequency_in_Dots - 1) / 2;

x= [-HalfWidth_time_in_Dots:1:HalfWidth_time_in_Dots];
y= [-HalfWidth_frequency_in_Dots:1:HalfWidth_frequency_in_Dots];

for i=1:length(x),
	for j=1:length(y),
		% gf = np.exp(-(x*x + y*y) / (2 * sigma ** 2))
		matrix(i,j)= 1 / (2*pi*sigmaX*sigmaY)*exp(-(x(i)^2/(2*sigmaX^2)+y(j)^2/(2*sigmaY^2)));
	end;
end;

matrix= matrix ./ max(max(matrix));
