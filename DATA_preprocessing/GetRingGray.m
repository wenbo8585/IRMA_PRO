%   �ú������ڽ�ȡָ���뾶��Χ�ڵ�Բ����ͳ�ƻҶȾ�ֵ�ͱ�׼��
%   ���룺 
%   center ��     Բ�����꣺����[r,c]
%   grayImg:      �Ҷ�ͼ��
%   inR,outR:     Բ������뾶
%   ����� 
%   ringImg ��             ��ȡ���Բ��ͼ��
%   graymean,graystd:      �ҶȾ�ֵ�ͱ�׼��
function [ringImg, graymean, graystd] = GetRingGray(grayImg,center,inR,outR)

[Row, Col] = size(grayImg);%ͼ���С
tempImg = zeros(Row,Col); %���� row*col ��0����
tempGray = [];
for ir = 1:Row
    for ic = 1:Col
        tempR = sqrt((ir-center(1))^2+(ic-center(2))^2);
        %�ж��Ƿ���Ring��Χ�ڡ�center(1)ΪԲ�ĵ���
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
