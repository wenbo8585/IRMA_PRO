%%
%�����ǩ�ļ���·��
str = './IRMA_annotate/IRMA2007__class_';
%����ļ�������
outstr = './IRMA2007__class_';
%����ȡͼ��·����10986�� resized��
oringalPath = './Resize/';
%��ȡ������������116�
classnum = 116;
%ÿһ�ȡͼ����,�O��0��ȡ��һ����ЈD��
%imgnum = 100;
imgnum = 0;
%%
flag = 0;
for i = 1:116
    filename = [str,num2str(i)];  
    ID = fopen(filename);
    P = textscan(ID,'%s %s');
    
    if(imgnum == 0)
        outpath = [outstr,num2str(i)];
        mkdir(outpath);
        disp(outpath);
        flag = flag + 1;
        if flag > classnum
            break;
        end    
        disp(length(P{1}));
        for j = 1 : length(P{1})
            picname = P{1}{j,1};
            try
                copyfile([oringalPath,picname,'.pgm'],[outpath,'\',picname,'.pgm']);
            catch
                disp(picname);
                disp('�ļ�������');
            end
        end
    else
        if(length(P{1}) >= imgnum && flag <= 116)
        %Pn(i) = length(P{1});
            outpath = [outstr,num2str(i)];
            mkdir(outpath);
            disp(outpath);
            flag = flag + 1;
            if flag > classnum
                break;
            end    
            for j = 1 : imgnum
                picname = P{1}{j,1};
                copyfile([oringalPath,picname,'.pgm'],[outpath,'\',picname,'.pgm']);
            end
        end
    end  
    fclose(ID);
%celldisp(C)  
end
if(flag < classnum)
    disp('�������㣬�p��ÿһ�ȡ�D�񔵻��ȡ�');
end


 
