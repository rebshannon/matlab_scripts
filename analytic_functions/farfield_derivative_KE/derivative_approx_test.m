
for i=1:size(y)-1
    dRdt(i) = (y(i+1)-y(i))/(t(i+1)-t(i));
end

diffy=diff(y);
difft=diff(t);
plotthis=diffy./difft;
