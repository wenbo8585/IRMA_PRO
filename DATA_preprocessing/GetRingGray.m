%   该函数用于截取指定半径范围内的圆环，统计灰度均值和标准差
%   输入： 
%   center ：     圆心坐标：行列[r,c]
%   grayImg:      灰度图像
%   inR,outR:     圆环内外半径
%   输出： 
%   ringImg ：             截取后的圆环图像
%   graymean,graystd:      灰度均值和标准差
function [ringImg, graymean, graystd] = GetRingGray(grayImg,center,inR,outR)

[Row, Col] = size(grayImg);%图像大小
tempImg = zeros(Row,Col); %构造 row*col 的0矩阵
tempGray = [];
for ir = 1:Row
    for ic = 1:Col
        tempR = sqrt((ir-center(1))^2+(ic-center(2))^2);
        %判断是否在Ring范围内。center(1)为圆心的行
        if tempR >= inR && tempR <= outR
            tempImg(ir,ic) = 1;
            tempGray = [tempGray grayImg(ir,ic)];
        end
    end
end

ringImg = tempImg.*double(grayImg);
graymean = mean(tempGray);
graystd = std(double(tempGray));
end
