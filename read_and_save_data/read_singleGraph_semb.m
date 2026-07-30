%% Rebecca Shannon
% 7/11/25
% read data from singleGraph and save to mat

clear
clc

%% NOTE: NEED TO CHANGE MAT AND STRUCTURE NAMES BELOW
% also need to set the case name
% note that each row is a new time
% time = row - 1 (starts at 0)

%% INITIAL SETTINGS

% Choose case
caseName = ['MY_O2_I2'];
i=1;

tStart = 0;
writeInterval = 1e-6;
tEnd = 299e-6;
    
cd(strcat('/p/home/rebshan/sembian_PIMPLE/',caseName,'/postProcessing/singleGraph/'));

%% READ ALL SINGLEGRAPH DATA
% split up based on timestep number format
% specifically for 1us timesteps

% read first matrix


M = readmatrix('0/line_T_p.xy','FileType','text');
U = readmatrix('0/line_U.xy','Filetype','text');
x = M(:,1);

timeInt = tStart:writeInterval:tEnd;

% initialize
T = zeros(round(tEnd/writeInterval),size(M,1));
p = zeros(round(tEnd/writeInterval),size(M,1));
rho = zeros(round(tEnd/writeInterval),size(M,1));
U1 = zeros(round(tEnd/writeInterval),size(M,1));
U2 = zeros(round(tEnd/writeInterval),size(M,1));

% extract data for t0
colNum = tStart + 1;
T(colNum,:) = M(:,2);
p(colNum,:) = M(:,3);
rho(colNum,:) = 0;
U1(colNum,:) = U(:,2);
U2(colNum,:) = U(:,3);

for t = timeInt

    colNum = colNum + 1;

    if t == 0
        continue
    end

    if t < 1e-6
         
        M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
        U = readmatrix(sprintf('%.0e/line_U.xy',t),'FileType','text');

%        sprintf('%.0e',t)
        T(colNum,:) = M(:,2);
        p(colNum,:) = M(:,3);
        rho(colNum,:) = M(:,4);
        U1(colNum,:) = U(:,2);
        U2(colNum,:) = U(:,3);
        continue
    end

     if t < 10e-6

         if rem(t,1e-6) == 0
              M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
              U = readmatrix(sprintf('%.0e/line_U.xy',t),'FileType','text');
 %             sprintf('%.0e',t)
         else 
              M = readmatrix(sprintf('%.1e/line_T_p_rho.xy',t),'FileType','text');
              U = readmatrix(sprintf('%.1e/line_U.xy',t),'FileType','text');
%              sprintf('%.1e',t)
         end
 
         T(colNum,:) = M(:,2);
         p(colNum,:) = M(:,3);
         rho(colNum,:) = M(:,4);
         U1(colNum,:) = U(:,2);
         U2(colNum,:) = U(:,3);
 
         continue
     end

     if t < 100e-6

         if isapprox(t,100e-6,'loose')
         elseif rem(round(t,6),10e-6) == 0
             M = readmatrix(sprintf('%.0e/line_T_p_rho.xy',t),'FileType','text');
             U = readmatrix(sprintf('%.0e/line_U.xy',t),'FileType','text');
%             sprintf('%.0e',t)
         elseif rem(t,1e-6)==0
             M = readmatrix(sprintf('%.1e/line_T_p_rho.xy',t),'FileType','text');
             U = readmatrix(sprintf('%.1e/line_U.xy',t),'FileType','text');
%             sprintf('%.1e',t)
         else
              M = readmatrix(sprintf('%.2e/line_T_p_rho.xy',t),'FileType','text');
              U = readmatrix(sprintf('%.2e/line_U.xy',t),'FileType','text');
%             sprintf('%.2e',t)
         end

         T(colNum,:) = M(:,2);
         p(colNum,:) = M(:,3);
         rho(colNum,:) = M(:,4);
         U1(colNum,:) = U(:,2);
         U2(colNum,:) = U(:,3);

         continue
     end

     t_strip = strip(num2str(t),'right','0');
     M = readmatrix(strcat(t_strip,'/line_T_p_rho.xy'),'FileType','text');
     U = readmatrix(strcat(t_strip,'/line_U.xy'),'FileType','text');
     T(colNum,:) = M(:,2);
     p(colNum,:) = M(:,3);
     rho(colNum,:) = M(:,4);
     U1(colNum,:) = U(:,2);
     U2(colNum,:) = U(:,3);
%     sprintf(strcat(t_strip))
    
end


%% SEND TO STRUCTURE

struct.T = T;
struct.p = p;
struct.rho = rho;
struct.x = x;
struct.time = transpose(tStart:writeInterval:tEnd);
%struct.name = caseName;

%% SAVE 

semb_MY_O2_I2 = struct;
save('../../../PIMPLE_singleGraph.mat', "semb_MY_O2_I2",'-append')
