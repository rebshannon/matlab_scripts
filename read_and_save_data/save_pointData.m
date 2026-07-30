cd ../shockTube/shockChannel/shockLin5/point_data/

M=readmatrix('backBottomCorner.final.csv');
S.shLiCh5_BLt=M(:,1);
S.shLiCh5_BLT=M(:,2);
S.shLiCh5_BLU0=M(:,3);
S.shLiCh5_BLU1=M(:,4);
S.shLiCh5_BLU2=M(:,5);
S.shLiCh5_BLp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

M=readmatrix('frontBottomCorner.final.csv');
S.shLiCh5_FLt=M(:,1);
S.shLiCh5_FLT=M(:,2);
S.shLiCh5_FLU0=M(:,3);
S.shLiCh5_FLU1=M(:,4);
S.shLiCh5_FLU2=M(:,5);
S.shLiCh5_FLp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

M=readmatrix('backCenterFace.final.csv');
S.shLiCh5_BCt=M(:,1);
S.shLiCh5_BCT=M(:,2);
S.shLiCh5_BCU0=M(:,3);
S.shLiCh5_BCU1=M(:,4);
S.shLiCh5_BCU2=M(:,5);
S.shLiCh5_BCp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

M=readmatrix('frontCenterFace.final.csv');
S.shLiCh5_FCt=M(:,1);
S.shLiCh5_FCT=M(:,2);
S.shLiCh5_FCU0=M(:,3);
S.shLiCh5_FCU1=M(:,4);
S.shLiCh5_FCU2=M(:,5);
S.shLiCh5_FCp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

M=readmatrix('backTopCorner.final.csv');
S.shLiCh5_BTt=M(:,1);
S.shLiCh5_BTT=M(:,2);
S.shLiCh5_BTU0=M(:,3);
S.shLiCh5_BTU1=M(:,4);
S.shLiCh5_BTU2=M(:,5);
S.shLiCh5_BTp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

M=readmatrix('frontTopCorner.final.csv');
S.shLiCh5_FTt=M(:,1);
S.shLiCh5_FTT=M(:,2);
S.shLiCh5_FTU0=M(:,3);
S.shLiCh5_FTU1=M(:,4);
S.shLiCh5_FTU2=M(:,5);
S.shLiCh5_FTp=M(:,6);
save('../../shForcesOnChannel','-struct','S','-append')
clear

% M=readmatrix('pointData.final.csv');
% S.shLiCh5_t=M(:,1);
% S.shLiCh5_T=M(:,2);
% S.shLiCh5_0=M(:,3);
% S.shLiCh5_1=M(:,4);
% S.shLiCh5_2=M(:,5);
% S.shLiCh5_p=M(:,6);
%save('../../shForcesOnChannel','-struct','S','-append')
