test3up=[-65,-21.95];
test3down=[-65,-89.64];
test31up=[-65,-20.62];
test31down=[-65,-96.84];
test32up=[-65,-19.97];
test32down=[-65,-93.72];
test33up=[-65,-18.82];
test33down=[-65,-87.62];

yright=-100:1:0;
fake=zeros(1,101);
figure
x=[0,1];
yyaxis left 
plot(x,test3up,'r','LineWidth', 2)
hold on
yyaxis left 
plot(x,test3down,'r','LineWidth', 2)
yyaxis left 
plot(x,test31up,'b','LineWidth', 2)
hold on
yyaxis left 
plot(x,test31down,'b','LineWidth', 2)
yyaxis left 
plot(x,test32up,'k','LineWidth', 2)
hold on
yyaxis left 
plot(x,test32down,'k','LineWidth', 2)
yyaxis left 
plot(x,test33up,'g','LineWidth', 2)
hold on
yyaxis left 
plot(x,test33down,'g','LineWidth', 2)
yyaxis right
plot(fake,yright) 