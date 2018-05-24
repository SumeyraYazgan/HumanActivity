%Drawing cube for sensor values
function [] = PlotShape(xval,yval,zval,C,alpha)

figure(1)
    fill3(xval,yval,zval,C,'FaceAlpha',alpha);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([-2 2]);
    box on;
    drawnow
end
