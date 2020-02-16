function varargout = MMN(varargin)
%MMN排队系统  制作人：Tazen Fee 2012年12月

% MMN M-file for MMN.fig
%      MMN, by itself, creates a new MMN or raises the existing
%      singleton*.
%
%      H = MMN returns the handle to a new MMN or the handle to
%      the existing singleton*.
%
%      MMN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MMN.M with the given input arguments.
%
%      MMN('Property','Value',...) creates a new MMN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MMN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MMN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MMN

% Last Modified by GUIDE v2.5 06-Dec-2012 08:32:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MMN_OpeningFcn, ...
                   'gui_OutputFcn',  @MMN_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MMN is made visible.
function MMN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MMN (see VARARGIN)

% Choose default command line output for MMN
handles.output = hObject;

pic2=imread('shouyintai.jpg');
set(handles.sever1,'CData',pic2);
set(handles.sever2,'CData',pic2);
set(handles.sever3,'CData',pic2);
set(handles.sever4,'CData',pic2);

global N;
N=1;
global g;
g=1;
global h;
h=2;
global Tmax;
Tmax=30;
global vf;
vf=1;
%下面的代码用于输出图像
global Tey;
Tey=0;
global Ley;
Ley=0;
global Sey;
Sey=0;
global Tx;
Tx=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MMN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MMN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in severin.
function severin_Callback(hObject, eventdata, handles)
% hObject    handle to severin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns severin contents as cell array
%        contents{get(hObject,'Value')} returns selected item from severin
global N;
list=get(handles.severin,'String');
val=get(handles.severin,'Value');
N=str2num(list{val});
set(handles.sever2,'Visible','off');
set(handles.sever3,'Visible','off');
set(handles.sever4,'Visible','off');
if N==2
    set(handles.sever2,'Visible','on');
elseif N==3
    set(handles.sever2,'Visible','on');
    set(handles.sever3,'Visible','on');
elseif N==4
    set(handles.sever2,'Visible','on');
    set(handles.sever3,'Visible','on');
    set(handles.sever4,'Visible','on');
end   



% --- Executes during object creation, after setting all properties.
function severin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to severin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bocanin_Callback(hObject, eventdata, handles)
% hObject    handle to bocanin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bocanin as text
%        str2double(get(hObject,'String')) returns contents of bocanin as a
%        double
global g;
g=str2num(get(handles.bocanin,'String'));

% --- Executes during object creation, after setting all properties.
function bocanin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bocanin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fucanin_Callback(hObject, eventdata, handles)
% hObject    handle to fucanin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fucanin as text
%        str2double(get(hObject,'String')) returns contents of fucanin as a double
global h;
h=str2num(get(handles.fucanin,'String'));

% --- Executes during object creation, after setting all properties.
function fucanin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fucanin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function dengshiout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dengshiout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pingchangout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pingchangout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function duichangout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duichangout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function fushiout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fushiout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function kongfuout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kongfuout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function gongtaiout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gongtaiout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%   g为顾客到达时间服从的泊松分布的参数
%   h为顾客服务时间服从的负指数分布的参数
%   N为服务台数
%   Tmax为仿真时长
if get(handles.start,'String')=='退出'
    close;
else
    set(handles.start,'String','退出');
    global N;
    global g;
    global h;
    global Tmax;
    %vf存放仿真速度
    global vf;
  
    %A为顾客的详细信息，其中按行依次为到达时间、服务时长、排队时长、服务台号,离开时间和进入服务时间
    global A;
    A=zeros(6,1);
    %离开时间排序
    global leave;
    leave=0;
    %S为服务台的信息，其中行代表服务台号，列分别代表状态（0为空闲，1为工作），和状态改变的时间
    global S;
    S=zeros(N,1);
    %s表示对应的服务台的状态改变数
    global s;
    s=zeros(1,N);
    %Se表示总的服务利用率，Sm表示表示服务台处于工作状态的台数
    global Se;
    Se=0;
    global Sm;
    Sm=0;
    %L为队列信息，行分别表示状态改变时间和相应的队长,Te表示平均等待时间，Le表示平均队长
    global L;
    L=[0;0];
    global Te;
    Te=0;
    global Le;
    Le=0;
    %t存放状态改变的时刻，顾客号，及相应的状态（1到达，0离开,2进入服务）
    global t;
    t=zeros(3,1);
    %下面的用于输出图像
    global Tey;
    global Ley;
    global Sey;
    global Tx;
    %初始化
    a=0;
    i=0;
    k=1;
    while A(1,k)<=Tmax
        i=poissrnd(g);
        A(1,k+1)=A(1,k)+i;
        k=k+1;
    end
    K=k-1;
    A(2,:)=random('exp',h,1,k);

    %生成完整的A矩阵
    i=0;
    k=1;
    n=1;
    p=1;
    sk=linspace(0,0,N);
    while k<=K
        if A(1,k)>=sk(1,p)
            sk(1,1)=A(1,k)+A(2,k);
            A(3,k)=0;
            A(4,k)=1;
            A(5,k)=sk(1,1);
        elseif A(1,k)<sk(1,n)
            A(3,k)=sk(1,n)-A(1,k);
            sk(1,n)=sk(1,n)+A(2,k);
            A(4,k)=n;
            A(5,k)=sk(1,n);
        else i=1;
            while sk(1,i)>A(1,k)
                i=i+1;
            end
            sk(1,i)=A(1,k)+A(2,k);
            A(3,k)=0;
            A(4,k)=i;
            A(5,k)=sk(1,i);
        end
        i=2;
        n=1;
        p=1;
        while i<=N
            if sk(1,i)>sk(1,p)
                p=i;
            end
            if sk(1,i)<sk(1,n)
                n=i;
            end
            i=i+1;
        end
        A(6,k)=A(1,k)+A(3,k);
        k=k+1;
    end

    %离开时间排序
    x=1;
    i=1;
    leave=linspace(1,K,K);
    while i<K
        j=i+1;
        while j<=K
            if A(5,leave(1,j))<A(5,leave(1,i))
                x=leave(1,i);
                leave(1,i)=leave(1,j);
                leave(1,j)=x;
            end
            j=j+1;
        end
        i=i+1;
    end

    %仿真时刻排序,k表示顾客到达号，n表示顾客离开号，i表示顾客进入服务号
    m=0;
    k=1;
    n=1;
    i=1;
    person=0;
    while m<=3*K-1&&n<=K&&i<=K
        m=m+1;
        if (k==K+1&&i==K+1)||(A(1,k)>=A(5,leave(1,n))&&A(6,i)>=A(5,leave(1,n)))
            t(1,m)=A(5,leave(1,n));
            t(2,m)=leave(1,n);
            t(3,m)=0;
            n=n+1;        
        elseif k==K+1||A(1,k)>A(6,i)
            t(1,m)=A(6,i);
            t(2,m)=i;
            t(3,m)=2;
            i=i+1;       
        else
            t(1,m)=A(1,k);
            t(2,m)=k;
            t(3,m)=1;
            k=k+1;
        end
    end

    %开始仿真
    k=1;
    i=0;
    km=0;
    Sec=0;
    LTec=0;
    j=0;
    person=0;
    while k<=m&&t(1,k)<=Tmax
        km=km+1;
        k=k+1;
    end
    k=1;
    while k<=km
        Tx(1,k)=t(1,k);
        k=k+1;
    end
    k=1;
    while k<=km
        i=0;
        %更新时间显示
        set(handles.timeout,'String',num2str(t(1,k)));
        while k<=km-i-1&&t(1,k)==t(1,k+i+1)&&t(3,k)==t(3,k+i+1)
            i=i+1;
        end
        if t(3,k)==0
            y=1;
            while y<=N               
                Sec=Sec+(t(1,k)-t(1,k-1))*S(y,1);
                y=y+1;
            end
            Se=Sec/(N*t(1,k))*100;
            %更新服务利用率显示
            set(handles.fushiout,'String',num2str(Se));
            y=0;
            while y<i+1
                x=A(4,t(2,k));
                S(x,1)=0;
                s(1,x)=s(1,x)+1;
                S(x,s(1,x)+1)=t(1,k);
                L(1,k)=t(1,k);
                L(2,k)=L(2,k-1);
                y=y+1;
                k=k+1;
            end
            Sm=Sm-i-1; 
            k=k-i-1;
            LTec=LTec+L(2,k)*(L(1,k)-L(1,k-1));
            x=0;
            while x<K&&A(1,x+1)<t(1,k)
                x=x+1;
            end
            Te=LTec/x;
            Le=LTec/t(1,k);
            %更新平均等待时间显示
            set(handles.dengshiout,'String',num2str(Te));
            %更新平均队长显示
            set(handles.pingchangout,'String',num2str(Le));
            %更新工作服务台数显示
            set(handles.gongtaiout,'String',num2str(Sm));
            %更新空闲服务台数显示
            set(handles.kongfuout,'String',num2str(N-Sm));
            %此处加入离开函数（t(2,k)号顾客到t(2,k+i)号顾客）
            lj=0.477;
            j=0;
            while lj>0.305
                lj=lj-0.01;
                pause(0.1/vf);
                j=0;
                while j<i+1
                    pp=get(person(1,t(2,k+j)),'Position');
                    pp(1,1)=lj;
                    set(person(1,t(2,k+j)),'Position',pp);
                    j=j+1;
                end
            end
            j=0;
            while j<i+1
                pp=get(person(1,t(2,k+j)),'Position');
                dl=pp(1,2);
                while dl>0.003
                    dl=dl-0.01;
                    pause(0.03/vf);
                    pp=get(person(1,t(2,k+j)),'Position');
                    pp(1,2)=dl;
                    set(person(1,t(2,k+j)),'Position',pp);
                end
                set(person(1,t(2,k+j)),'Visible','off');
                j=j+1;
            end
            y=0;
            while y<i+1
                Tey(1,k+y)=Te;
                Ley(1,k+y)=Le;
                Sey(1,k+y)=Se;
                disp(['                    ',num2str(t(1,k+y)),'s时，',num2str(t(2,k+y)),'号顾客从',num2str(A(4,t(2,k+y))),'号服务台离开']);
                y=y+1;
            end
        elseif  t(3,k)==1 
            y=1;
            while y<=N
                if k>1                
                    Sec=Sec+(t(1,k)-t(1,k-1))*S(y,1);
                else
                    Sec=Sec+t(1,k)*S(y,1);
                end
                y=y+1;
            end
            if t(1,k)==0
                Se=0;
            else
                Se=Sec/(N*t(1,k))*100;
            end
            %更新服务利用率显示
            set(handles.fushiout,'String',num2str(Se));
            L(1,k)=t(1,k);  
            if k>1
                L(2,k)=L(2,k-1)+i+1;
                LTec=LTec+L(2,k-1)*(L(1,k)-L(1,k-1));
            else
                L(2,k)=i+1;
                LTec=0;
            end
            x=1;
            while x<K&&A(1,x)<t(1,k)
                x=x+1;
            end
            if x>1           
                Te=LTec/(x-1);
            else
                Te=0;
            end
            if t(1,k)>0
                Le=LTec/t(1,k);
            else
                Le=0;
            end
            y=0;
            while y<i
                L(1,k+1)=t(1,k+1);
                L(2,k+1)=L(2,k);
                y=y+1;
                k=k+1;
            end
            k=k-i;
            %更新平均等待时间显示
            set(handles.dengshiout,'String',num2str(Te));
            %更新平均队长显示
            set(handles.pingchangout,'String',num2str(Le));
            %此处加入到达函数（t(2,k)号顾客到t(2,k+i)号顾客）
            wnum=0;
            j=0;
            while j<i+1
                pic=imread('matlab.jpg');
                person(1,t(2,k+j))=uicontrol('Style','push','Units','normalized','String','','FontUnits','normalized','ForegroundColor','blue','FontSize',0.2,'CData',pic,'Position',[0.92 0.66-0.185*j 0.052 0.149]);
                set(person(1,t(2,k+j)),'String',num2str(t(2,k+j)));
                j=j+1;
                if k==1
                    wnum(1,j)=j;
                else
                    wnum(1,j)=L(2,k-1)+j;
                end
            end
            lj=0.92;
            j=0;
            while lj>0.813
                lj=lj-0.01;
                pause(0.1/vf);
                j=0;
                while j<i+1
                    pp=get(person(1,t(2,k+j)),'Position');
                    pp(1,1)=lj;
                    set(person(1,t(2,k+j)),'Position',pp);
                    j=j+1;
                end
            end
            j=0;
            while j<i+1
                if wnum(1,j+1)==5||wnum(1,j+1)==10||wnum(1,j+1)==15
                    lj0=0.592+0.065*(floor(wnum(1,j+1)/5)-1);
                else
                    lj0=0.592+0.065*floor(wnum(1,j+1)/5);
                end
                if rem(wnum(1,j+1),5)==0
                    dl0=0.697-0.166*4;
                else
                    dl0=0.697-0.166*(rem(wnum(1,j+1),5)-1);
                end
                pp=get(person(1,t(2,k+j)),'Position');
                dl=pp(1,2);
                if dl>dl0
                    while dl>dl0
                        dl=dl-0.01;
                        pause(0.1/vf);
                        pp=get(person(1,t(2,k+j)),'Position');
                        pp(1,2)=dl;
                        set(person(1,t(2,k+j)),'Position',pp);
                    end
                else
                    while dl<dl0
                        dl=dl+0.01;
                        pause(0.1/vf);
                        pp=get(person(1,t(2,k+j)),'Position');
                        pp(1,2)=dl;
                        set(person(1,t(2,k+j)),'Position',pp);
                    end
                end
                pp=get(person(1,t(2,k+j)),'Position');
                lj=pp(1,1); 
                while lj>lj0
                    lj=lj-0.01;
                    pause(0.1/vf);
                    pp=get(person(1,t(2,k+j)),'Position');
                    pp(1,1)=lj;
                    set(person(1,t(2,k+j)),'Position',pp);
                end
                j=j+1;
                dui=str2num(get(handles.duichangout,'String'));
                dui=dui+1;
                set(handles.duichangout,'String',dui);
            end

            %更新队长显示
            set(handles.duichangout,'String',num2str(L(2,k)));
            %更新工作服务台数显示
            set(handles.gongtaiout,'String',num2str(Sm));
            %更新空闲服务台数显示
            set(handles.kongfuout,'String',num2str(N-Sm));
            y=0;
            while y<i+1
                Tey(1,k+y)=Te;
                Ley(1,k+y)=Le;
                Sey(1,k+y)=Se;
                disp([num2str(t(1,k+y)),'s时，',num2str(t(2,k+y)),'号顾客到达商场']);
                y=y+1;
            end
        else
            y=1;
            while y<=N               
                Sec=Sec+(t(1,k)-t(1,k-1))*S(y,1);
                y=y+1;
            end
            if t(1,k)==0
                Se=0;
            else
                Se=Sec/(N*t(1,k))*100;
            end
            %更新服务利用率显示
            set(handles.fushiout,'String',num2str(Se));
            L(1,k)=t(1,k);  
            L(2,k)=L(2,k-1)-i-1;
            LTec=LTec+L(2,k-1)*(L(1,k)-L(1,k-1));
            x=1;
            while x<K&&A(1,x)<t(1,k)
                x=x+1;
            end
            if x>1           
                Te=LTec/(x-1);
            else
                Te=0;
            end
            if t(1,k)>0
                Le=LTec/t(1,k);
            else
                Le=0;
            end
            %更新平均等待时间显示
            set(handles.dengshiout,'String',num2str(Te));
            %更新平均队长显示
            set(handles.pingchangout,'String',num2str(Le));

            y=0;
            while y<i
                L(1,k+1)=t(1,k+1);
                L(2,k+1)=L(2,k);
                y=y+1;
                k=k+1;
            end
            k=k-i;
            y=0;
            while y<i+1
                x=A(4,t(2,k+y));
                S(x,1)=1;
                s(1,x)=s(1,x)+1;
                S(x,s(1,x)+1)=t(1,k+y);
                y=y+1;
            end
            %此处加入进入服务函数（t(2,k)号顾客到t(2,k+i)号顾客）
            pp=get(person(t(2,k)),'Position');
            lj=pp(1,1);
            j=0;
            while j<i+1
                pp=get(person(t(2,k+j)),'Position');
                lj=pp(1,1);
                while lj>0.53
                    lj=lj-0.01;
                    pause(0.1/vf);
                    pp=get(person(t(2,k+j)),'Position');
                    pp(1,1)=lj;
                    set(person(t(2,k+j)),'Position',pp);
                end
                %更新队长显示
                set(handles.duichangout,'String',num2str(L(2,k-1)-1-j));
                if  L(2,k-1)>(1+j)&&L(2,k-1)<(6+j)
                    jm=1;
                    while jm<(L(2,k-1)-j)
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                elseif L(2,k-1)>(5+j)&&L(2,k-1)<(11+j)
                    jm=1;
                    while jm<5
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                    pp=get(person(t(2,k+j)+5),'Position');
                    pp(1,1)=pp(1,1)-0.064;
                    pp(1,2)=pp(1,2)-0.166*4;
                    set(person(t(2,k+j)+5),'Position',pp);
                    jm=6;
                    while jm<(L(2,k-1)-j)
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                elseif L(2,k-1)>(10+j) 
                    jm=1;
                    while jm<5
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                    pp=get(person(t(2,k+j)+5),'Position');
                    pp(1,1)=pp(1,1)-0.064;
                    pp(1,2)=pp(1,2)-0.166*4;
                    set(person(t(2,k+j)+5),'Position',pp);
                    jm=6;
                    while jm<10
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                    pp=get(person(t(2,k+j)+10),'Position');
                    pp(1,1)=pp(1,1)-0.064;
                    pp(1,2)=pp(1,2)-0.166*4;
                    set(person(t(2,k+j)+10),'Position',pp);
                    jm=11;
                    while jm<(L(2,k-1)-j)
                        pp=get(person(t(2,k+j)+jm),'Position');
                        pp(1,2)=pp(1,2)+0.166;
                        set(person(t(2,k+j)+jm),'Position',pp);
                        jm=jm+1;
                    end
                end
                pp=get(person(t(2,k+j)),'Position');
                dl=pp(1,2);
                dl0=0.697-0.198*(A(4,t(2,k+j))-1);
                while dl>dl0
                    dl=dl-0.01;
                    pause(0.1/vf);
                    pp=get(person(t(2,k+j)),'Position');
                    pp(1,2)=dl;
                    set(person(t(2,k+j)),'Position',pp);
                end
                while lj>0.472
                    lj=lj-0.01;
                    pause(0.1/vf);
                    pp=get(person(t(2,k+j)),'Position');
                    pp(1,1)=lj;
                    set(person(t(2,k+j)),'Position',pp);
                end
                j=j+1;
            end
            Sm=Sm+i+1;
            %更新工作服务台数显示
            set(handles.gongtaiout,'String',num2str(Sm));
            %更新空闲服务台数显示
            set(handles.kongfuout,'String',num2str(N-Sm));
            y=0;
            while y<i+1
                Tey(1,k+y)=Te;
                Ley(1,k+y)=Le;
                Sey(1,k+y)=Se;
                disp(['         ',num2str(t(1,k+y)),'s时，',num2str(t(2,k+y)),'号顾客到',num2str(A(4,t(2,k+y))),'号服务台接受服务']);
                y=y+1;
            end
        end
        k=k+i+1;
    end
end



% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Tey;
global Ley;
global Sey;
global Tx;
%仿真图
figure(1);
hold on; 
set(1,'position',[0,0,800,600]);
subplot(2,2,1); 
plot(Tx,Tey);
title('平均等待时间变化图');
xlabel('时间');
ylabel('平均等待时间'); 
subplot(2,2,2); 
plot(Tx,Ley);
title('平均队长变化图');
xlabel('时间');
ylabel('平均队长'); 
subplot(2,2,3); 
plot(Tx,Sey);
title('服务台利用率变化图'); 
xlabel('时间');
ylabel('服务台利用率'); 
hold off;



function fangshiin_Callback(hObject, eventdata, handles)
% hObject    handle to fangshiin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fangshiin as text
%        str2double(get(hObject,'String')) returns contents of fangshiin as a double
global Tmax;
Tmax=str2num(get(handles.fangshiin,'String'));

% --- Executes during object creation, after setting all properties.
function fangshiin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fangshiin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function timeout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in fangv.
function fangv_Callback(hObject, eventdata, handles)
% hObject    handle to fangv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fangv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fangv
global vf;
vf=1;
vf=get(handles.fangv,'Value');



% --- Executes during object creation, after setting all properties.
function fangv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fangv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
