%% Rebecca Shannon
% 10/28/25
% plot data from singleGraph - single point over time


addpath('/p/home/rebshan/matlab/')

dataFile = 'PIMPLE_singleGraph.mat';
load(dataFile)

dat(1) = semb_MN_O2_I2;
dat(2) = semb_MN_O2_I3;
dat(3) = semb_blastTest;
dat(4) = semb_MN_O2_I3_11;
%dat(5) = semb_RMN_O2_I3;
%dat(6) = semb_MY_O2_I2;
%dat(7) = semb_MY_O2_I3;
%dat(7) = semb_MY_O2_I3;
% dat(6) = semb_MN_O2_I3_C;
% dat(7) = semb_MY_O2_I3_C;

probeInd(1) = 61;
probeInd(2) = 211;
probeInd(3) = 405;

for probe = 1:3

    figure
    for caseInd = [1:4]
        %plot(dat(caseInd).time-dat(caseInd).shift,smoothdata(dat(caseInd).p(1:end-1,probeInd(probe)),"movmean",9))
        plot(dat(caseInd).time-dat(caseInd).shift, dat(caseInd).p(1:end-1,probeInd(probe)))
        hold on
        legend('N22','Y23','blastTest','BLPIMP')
        grid on
        xlim([0 1.2e-4])
    end
end