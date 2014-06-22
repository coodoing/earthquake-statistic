function [ output_args ] = RecentEQData( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clear all;
% ��Ҫ���������������ĵ�������ͼ��ʱ�䣬�𼶺;�γ��
    [dmatrix,date] = xlsread('EQ_Data.xls','1973-2013��28 33-102 109��','a1:d166');
    % �����漰��ʱ�䴦������ÿ�����������ܲ�һ�£���Ҫ����profile���и��ٲ��ԣ�
    % datestr(ת����ָ����ʽ��ʱ���ַ���) datenum��ת�������֣� datevec��ת����������
    % http://zhiqiang.org/blog/it/datestr-datenum-efficiency-in-matlab.html
    % disp(datevec(date));
    [year, month, day, hour, minute, second] = datevec(date);
    lat = dmatrix(:,1);
    log = dmatrix(:,2);
    mag = dmatrix(:,3);
        
    hold on;box on;
    axis([1973 max(year) 4 10]);    
    plot(year,mag,'r.');
    title('����ɽ�����-������ͼ(USGS)');
    xlabel('���');
    ylabel('��');
    
    hold on;
    figure(2);
    % ������ɢ�е��������
    plot3(lat,log,mag, 'bo'); %scatter3(lat,log,mag,'bo');  
    % �������ݲ�ֵ��� mesh
    hold on;grid on;
    xi = linspace(min(lat),max(lat),50);	% x interpolation points
    yi = linspace(min(log),max(log),50);	% x interpolation points
    [Xi,Yi]=meshgrid(xi,yi); % meshgrid �����귶Χ��������
    Zi=griddata(lat,log,mag,Xi,Yi,'v4');% gridfit����
    mesh(Xi,Yi,Zi);   
    title('3D-����ɽ�����-����ֲ�ͼ(USGS)');
    xlabel('γ��');
    ylabel('����');
    zlabel('��');
  
    hold off;
    % Profiler();
end

% ����xls����
function LoadXlsData()
end

% ���ܲ��Գ���
function ProfileTest()
    tic; 
    for i = 1:5000, 
        p = datenum('2010-10-10'); 
    end; 
    toc
end

% matlab�Դ������ܷ�������
function Profiler()
    profile on        
    ProfileTest();
    profile viewer
    p = profile('info');
    profsave(p,'profile_results')
end