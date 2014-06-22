function [ output_args ] = RecentEQData( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clear all;
% 主要用来绘制最近几年的地震曲线图：时间，震级和经纬度
    [dmatrix,date] = xlsread('EQ_Data.xls','1973-2013（28 33-102 109）','a1:d166');
    % 这里涉及到时间处理函数（每个函数的性能不一致，需要根据profile进行跟踪测试）
    % datestr(转换成指定格式的时间字符串) datenum（转换成数字） datevec（转换成向量）
    % http://zhiqiang.org/blog/it/datestr-datenum-efficiency-in-matlab.html
    % disp(datevec(date));
    [year, month, day, hour, minute, second] = datevec(date);
    lat = dmatrix(:,1);
    log = dmatrix(:,2);
    mag = dmatrix(:,3);
        
    hold on;box on;
    axis([1973 max(year) 4 10]);    
    plot(year,mag,'r.');
    title('龙门山地震带-地震震级图(USGS)');
    xlabel('年份');
    ylabel('震级');
    
    hold on;
    figure(2);
    % 单纯的散列点数据拟合
    plot3(lat,log,mag, 'bo'); %scatter3(lat,log,mag,'bo');  
    % 曲线数据插值拟合 mesh
    hold on;grid on;
    xi = linspace(min(lat),max(lat),50);	% x interpolation points
    yi = linspace(min(log),max(log),50);	% x interpolation points
    [Xi,Yi]=meshgrid(xi,yi); % meshgrid 对坐标范围进行设置
    Zi=griddata(lat,log,mag,Xi,Yi,'v4');% gridfit函数
    mesh(Xi,Yi,Zi);   
    title('3D-龙门山地震带-地震分布图(USGS)');
    xlabel('纬度');
    ylabel('经度');
    zlabel('震级');
  
    hold off;
    % Profiler();
end

% 加载xls数据
function LoadXlsData()
end

% 性能测试程序
function ProfileTest()
    tic; 
    for i = 1:5000, 
        p = datenum('2010-10-10'); 
    end; 
    toc
end

% matlab自带的性能分析工具
function Profiler()
    profile on        
    ProfileTest();
    profile viewer
    p = profile('info');
    profsave(p,'profile_results')
end