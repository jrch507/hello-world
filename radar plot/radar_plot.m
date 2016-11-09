%% radar_plot
% This program is used to draw radar plot. 
% 
% The data for each plot is stored in "rho", whose rows correspond to each
% plot and columns correspond to each axis.
% 
% The names of each plot are set in "plot_name".
% 
% The names of each axis are set in "axis_name".
%
% The colors of each plot are set in "color_map".
%% 
clc;
clear all;
close all;

%% input information
rho = [0.00097905	0.059897481	0.328756104	0.283019274	0.32734809
           0.006388781	0.48699805	0.298527357	0.107078121	0.101007691
           0.000898493	0.004439837	0.132153028	0.382674493	0.47983415
           0.000283406	0.004928207	0.166669025	0.373381865	0.454737496];   % radar data to be revealed, row -- each plot, column -- each axis

plot_name = {'ERP','delta/theta-ERD','theta/alpha-ERS','gamma-ERS'};  % names of plots
axis_name = {'E1','E2','E3','E4','E5'};   % names of axes

color_map = [39 203 207  % blue
    71 191 55 % green
    205 84 41 % red
    176 58 188]; % purple   color vectors corresponding to each plot, row--each plot, column--rgb channels, ranged from [0 255] for each channel

%% error checking for input information
if numel(plot_name)~=size(rho,1)
    error('Number of plot_name should be equal to number of plots!');
end
if numel(axis_name)~=size(rho,2)
    error('Number of axis_name should be equal to number of axes!');
end
if size(color_map,1)~=size(rho,1)
    error('Number of color vector should be equal to number of plots!');
end

%% calculate axes information
N = size(rho,2);                       % number of axes
theta = [0:N]*2*pi/N;                % angle for each axis

if mod(N,2)==1
    % if number of axes is odd, start axis should be adjusted to pi/2
    theta  = theta+pi/2;
end

%% plot axes
h = figure;
axis_unit=0.1;
num_circle = ceil(max(max(rho))/axis_unit);     % number of circle grid
axis_circle_value = (1:num_circle)*axis_unit;   % value for each circle grid

% -----set text positions to reveal values of each circle grid--------------------
if mod(N,2)==1
    theta_sel = pi/2;
    posX_axis_value = cos(theta_sel)*max(axis_circle_value)*ones(1,num_circle)+10*axis_unit/100;
    posY_axis_value = sin(theta_sel)*(axis_circle_value)+10*axis_unit/100;
else
    theta_sel = 0;
    posX_axis_value = cos(theta_sel)*(axis_circle_value)+10*axis_unit/100;
    posY_axis_value = sin(theta_sel)*max(axis_circle_value)*ones(1,num_circle)+10*axis_unit/100;
end

% -----set text positions to reveal axes names--------------------
posX_axis_name = cos(theta)*max(axis_circle_value)+(cos(theta)>=0)*20*axis_unit/100-(cos(theta)<0)*50*axis_unit/100;
posY_axis_name = sin(theta)*max(axis_circle_value)+sign(sin(theta))*20*axis_unit/100;

% -----plot axes and show circle grid values----------------------------------------------
for k = 1:num_circle
   hold on;polar_pww(theta,ones(1,N+1)*axis_circle_value(k),'Color','b','linestyle',':','linewidth',1);
   text(posX_axis_value(k),posY_axis_value(k),num2str(axis_circle_value(k)),'FontSize',18,'FontName','Times New Roman');
end

% -----show axes names-------------------------------------
for k =1:N
    if mod(N,2)==1
       if sum(abs(posX_axis_name(k)-posX_axis_value)<50*axis_unit/100)>0
           posX_axis_name(k) = posX_axis_value(end)+70*axis_unit/100;
       end
    else
        if sum(abs(posY_axis_name(k)-posY_axis_value)<50*axis_unit/100)>0
           posY_axis_name(k) = posY_axis_value(end)+70*axis_unit/100;
       end
    end
       text(posX_axis_name(k),posY_axis_name(k),axis_name{k},'FontSize',18,'FontName','Times New Roman');
end

%% plot value
rho = [rho,rho(:,1)];
color_map = color_map/255;
N_plot = numel(plot_name);
h_plot = zeros(1,N_plot);
for k = 1:N_plot
    hold on;h_plot(k) = polar_pww(theta,rho(k,:),'Color',color_map(k,:),'LineWidth',3,'MarkerSize',6,'Marker','o');
end

%% configure figure
% --------change figure position and size------------
left =0;
bottom = 0;
width = 1000;
height = 1000;
set(gcf,'position',[left,bottom,width,height]);

% ---------set axis range-----------------
set(gca,'xlim',[-1.2 1.2]*max(axis_circle_value));
set(gca,'ylim',[-1.2 1.2]*max(axis_circle_value));
% --------add legends------------------------------------
fontsize_legend = 18;
fontname_legend = 'Times New Roman';
eval_str = 'legend(h_plot';
for k = 1:N_plot
    eval_str = strcat(eval_str,',plot_name{',num2str(k),'}');
end
eval_str = strcat(eval_str,',''FontSize'',fontsize_legend,''FontName'',fontname_legend,''Location'',''SouthEast'');');
eval(eval_str);