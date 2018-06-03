%Drawing cube for sensor values
function [] = PlotShape(xval,yval,zval,C,alpha,titleT)



    fill3(xval,yval,zval,C,'FaceAlpha',alpha);
    xlabel('x')
    ylabel('y');
    zlabel('z');
    xlim([-2 2]);
    ylim([-2 2]);
    zlim([-2 2]);
    title(titleT)
    box on;
    drawnow
end
