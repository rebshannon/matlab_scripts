

plot(shLiCh5_FLt,shLiCh5_FLp)
hold on
plot(shLiCh5_FCt,shLiCh5_FCp)
plot(shLiCh5_FCt,shLiCh5_FCp)

xlabel('Time (s)')
ylabel('Pressure (Pa)')
legend('Lower','Center','Top')
grid on
title({'Pressure on Front Face of Channel','Mach 4 Shock, Linear Channel'})

figure
plot(shLiCh5_BLt,shLiCh5_BLp)
hold on
plot(shLiCh5_BCt,shLiCh5_BCp)
plot(shLiCh5_BTt,shLiCh5_BTp)

xlabel('Time (s)')
ylabel('Pressure (Pa)')
legend('Lower','Center','Top')
grid on
title({'Pressure on Back Face of Channel','Mach 4 Shock, Linear Channel'})

figure
plot(shLiCh5_FLt,shLiCh5_FLp-shLiCh5_BLp)
hold on
plot(shLiCh5_FCt,shLiCh5_FCp-shLiCh5_BCp)
plot(shLiCh5_FTt,shLiCh5_FTp-shLiCh5_BTp)

xlabel('Time (s)')
ylabel('Pressure (Pa)')
legend('Lower','Center','Top')
grid on
title({'Pressure Difference on Channel','Mach 4 Shock, Linear Channel'})