function varargout = JointMake(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JointMake_OpeningFcn, ...
                   'gui_OutputFcn',  @JointMake_OutputFcn, ...
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

%=======================================================
function JointMake_OpeningFcn(hObject, eventdata, handles, varargin)

    global  hObj22  
hObj22=hObject ;

if ~exist('Temp')
    mkdir('Temp')
end
    global S hObj event varar
set(handles.E_ad1,'string','')
set(handles.E_ad2,'string','')
set(handles.v_Ad1,'string','')
set(handles.Sy_Ad1,'string','')
set(handles.p_Ad1,'string','')
set(handles.p_Ad2,'string','')
set(handles.v_ad2,'string','')
set(handles.Sy_ad2,'string','')
set(handles.NoLamad1,'string','')
set(handles.NoLamad2,'string','')
set(handles.listbox4,'string','')
set(handles.E_ads,'string','')
set(handles.v_ads,'string','')
set(handles.Sy_ads,'string','')
set(handles.p_ads,'string','')
set(handles.E_e_ads,'string','')
set(handles.E_m_ads,'string','')
set(handles.funcdeg_ads,'string','')
set(handles.No_part_ads,'string','')
set(handles.L_1,'string','')
set(handles.L_2,'string','')
set(handles.L_3,'string','')
set(handles.L_5,'string','')
set(handles.L_6,'string','')
set(handles.t_1,'string','')
set(handles.t_2,'string','')
set(handles.t_3,'string','')
set(handles.w_,'string','')
set(handles.T_x,'string','')
set(handles.T_z,'string','')
set(handles.T_y,'string','')

set(handles.U_x,'string','')
set(handles.U_z,'string','')
set(handles.U_y,'string','')
set(handles.step_time,'string','')
set(handles.mesh_thick,'string','')
set(handles.mesh_size,'string','')
set(handles.E_ad1,'string','')
set(handles.E_ad1,'string','')

set(handles.pop_ad1,'value',1)
set(handles.pop_ad2,'value',1)
set(handles.popadhesive,'value',1)
set(handles.radiobutton1,'value',1)
set(handles.Load,'value',0)
set(handles.Implicit,'value',1)
set(handles.ad_12,'value',0)
set(handles.Joint_type,'value',1)
set(handles.popadhesive,'value',1)
set(handles.tabad2,'data',['', '',''])
set(handles.tabad1,'data',['', '',''])
set(handles.tabad1,'RowName', {'L1', });
set(handles.tabad2,'RowName', {'L1', });
handles.gradebehav=2;


S.ln=0;
handles.LN=0;
S.yn=0;
S.E1=str2double('');
S.E2=str2double('');
S.v12=str2double('');
S.G12=str2double('');
S.G13=str2double('');
S.G23=str2double('');
S.p=str2double('');
S.Name={};
handles.Name={};
handles.LBAD1=1;
handles.layupad1={};
handles.layupad2={};
handles.CM=[];
handles.layupad1_final=[];
handles.layupad2_final=[];
handles.nlad1=0.25;
handles.nlad2=0.25;
handles.ELP1=1;
handles.ELP2=1;
 handles.ad12=0;
handles.nonlinmesh=0;
handles.jointtype=1; 
handles.ad12=0;
handles.stp=1;                
handles.stptime=.01;         
handles.ELP2=1;
handles.ELP1=1;
handles.ELP=1; 
handles.LC=1;

handles.Save_Lam1_indicator=0;
handles.Save_Lam2_indicator=0;

handles.L1=str2double('');
handles.L2=str2double('');
handles.L3=str2double('');
handles.L5=str2double('');
handles.L6=str2double('');
handles.t1=str2double('');
handles.t2=str2double('');
handles.t3=str2double('');
handles.w=str2double('');    

handles.nopartition=str2double('');       
                          
handles.meshsize=str2double('');
handles.meshthick=str2double('');              
handles.pad1=str2double('');
handles.pad2=str2double('');

handles.Syad1=str2double('');
handles.Ead1=str2double('');
handles.vad1=str2double('');

handles.Syad2=str2double('');
handles.Ead2=str2double('');
handles.vad2=str2double('');              
handles.Syads=str2double('');

handles.Eads=str2double('');
handles.vads=str2double('');
handles.Eeads=str2double('');
handles.Emads=str2double('');
handles.vads=str2double('');
handles.funcdegree=str2double(''); 
handles.pads=str2double('');

handles.Ux=str2double('');
handles.Uz=str2double('');
handles.Uy=str2double('');
handles.Tx=str2double('');
handles.Tz=str2double('');
handles.Ty=str2double('');
handles.holdon=0; 
imshow('1.bmp', 'Parent', handles.axes1);

set(handles.Sy_Ad1,'Enable','off');
set(handles.Sy_ad2,'Enable','off');
set(handles.p_Ad1,'Enable','off');
set(handles.p_Ad2,'Enable','off');
set(handles.NoLamad1,'Enable','off');
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam1,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad1,'Enable','off');
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
set(handles.Sy_ads,'Enable','off');
set(handles.p_ads,'Enable','off'); 
set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');

set(handles.step_time,'Enable','off');
set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');
set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');
set(handles.E_ads,'Enable','on');
set(handles.T_x,'Enable','off');
set(handles.T_z,'Enable','off');
set(handles.T_y,'Enable','off');

set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');
set(handles.U_x,'Enable','on');
set(handles.U_z,'Enable','on');
set(handles.U_y,'Enable','on');
set(handles.resultpanel,'visible','off');
set(handles.datainputpanel,'visible','on');
 set(handles.FAPSpanel,'visible','off');

handles.pwd0=pwd;
pw00=handles.pwd0;
aaa=find(pw00=='\');
pw00(aaa)='/';
handles.pwd0=pw00;

plot(handles.axes2,[],[])
plot(handles.axes3,[],[])
plot(handles.axes4,[],[])
plot(handles.axes5,[],[])
plot(handles.axes6,[],[])
plot(handles.axes7,[],[])

set(handles.axes7,'visible', 'off')
set(handles.axes5,'visible', 'off')
set(handles.axes3,'visible', 'off')

set(handles.inp_dat,'Value',1)
 handles.Fan_Parstd=0;
 handles.Result=0;   
 handles.Inp_Dat=1;

handles.psm_Var=1;
handles.rpsm_c=0;
handles.lable='E_A_d_h_e_s_i_v_e';
handles.tm_check=0;
set(handles.T_M_E,'Enable','off') 

handles.psm_LLIM=str2double('');
handles.psm_TLIM=str2double('');
handles.psm_INTRV=str2double('');
handles.tm_low=str2double('');
handles.tm_high=str2double('');
handles.tm_int=str2double('');
handles.tm_a=str2double('');
handles.TM_f1=str2double('');





set(handles.allo_M,'Enable','off')
set(handles.allo_S,'Enable','off')
set(handles.allo_N,'Enable','off')

set(handles.FA_a_M,'Enable','off')
set(handles.FA_a_S,'Enable','off')
set(handles.FA_a_N,'Enable','off')

set(handles.FA_MS0,'Enable','off')
set(handles.FA_NS0,'Enable','off')
set(handles.FA_SS0,'Enable','off')

set(handles.FA_TM_check_M,'Enable','off')
set(handles.FA_TM_check_N,'Enable','off')
set(handles.FA_TM_check_S,'Enable','off')

set(handles.FA_MSX,'Enable','off')
set(handles.FA_SSX,'Enable','off')
set(handles.FA_NSX,'Enable','off')

handles.FAMcheck=0;
handles.FANcheck=0;
handles.FAScheck=0;
handles.FATMcheck=0;
handles.FATMcheckM=0;
handles.FATMcheckN=0;
handles.FATMcheckS=0;


handles.alloM=str2double('');   
handles.alloN=str2double('');   
handles.alloS=str2double('');   
handles.FAaM=str2double('');   
handles.FAaN=str2double('');   
handles.FAaS=str2double('');   
handles.FAMS0=str2double('');   
handles.FANS0=str2double('');   
handles.FASS0=str2double(''); 
handles.tm_b=str2double('');
% 

handles.FAMFunc1='';   
handles.FASFunc1='';   
handles.FANFunc1='';   


 handles.FASSR=0;
 handles.FASSTMR=0;
handles.fatmP=0;

handles.STR={};


% set(handles.text79,'visible','off'); 
% set(handles.text80,'visible','off'); 
% set(handles.text82,'visible','off'); 
% set(handles.text89,'visible','off'); 
% set(handles.text124,'visible','off'); 
% set(handles.text131,'visible','off'); 
% set(handles.text91,'visible','off'); 
% set(handles.text131,'visible','off'); 
% set(handles.text133,'visible','off'); 

handles.output = hObject;
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = JointMake_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function Joint_type_Callback(hObject, eventdata, handles)
 
handles.jointtype=get(hObject,'value');

if handles.jointtype==1
    
imshow('1.bmp', 'Parent', handles.axes1);
imshow('Path1.bmp', 'Parent', handles.axes8); 


set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');

elseif handles.jointtype==2
    
imshow('2.bmp', 'Parent', handles.axes1); 
imshow('Path2.bmp', 'Parent', handles.axes8); 


set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');
elseif handles.jointtype==3
    
imshow('3.bmp', 'Parent', handles.axes1); 
imshow('Path3.bmp', 'Parent', handles.axes8); 

set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');


elseif handles.jointtype==4
    imshow('4.bmp', 'Parent', handles.axes1); 
    imshow('Path4.bmp', 'Parent', handles.axes8); 
 set(handles.L_5,'Enable','on');
set(handles.L_6,'Enable','on');  
end
    

 
 guidata(hObject, handles)
 
    
function Joint_type_CreateFcn(hObject, eventdata, handles)

%===============================================================    
function Modules__Callback(hObject, eventdata, handles)
handles.mod=get(hObject,'value');
if handles.mod==1
set(handles.resultpanel,'visible','off');
set(handles.datainputpanel,'visible','on');
elseif handles.mod==2
    set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
end
guidata(hObject, handles)
    
    
function Modules__CreateFcn(hObject, eventdata, handles)


%===================================================================
function pop_ad1_Callback(hObject, eventdata, handles)
handles.ELP1=get(hObject,'value');
if handles.ELP1==1

set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');

set(handles.t_1  ,'Enable','on');
if handles.ad12==1
set(handles.t_2  ,'Enable','on');
end

set(handles.Sy_Ad1,'Enable','off');
set(handles.NoLamad1,'Enable','off');    
set(handles.SavLam1,'Enable','off');
set(handles.tabad1,'Enable','off');

if handles.stp==2
    set(handles.p_Ad1,'Enable','on');
end

if handles.ELP2 ~=3 || handles.ad12==1
    
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
end   
    
elseif handles.ELP1==2
set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');   
set(handles.Sy_Ad1,'Enable','on');

set(handles.t_1  ,'Enable','on'); 

if handles.ad12==1
set(handles.t_2  ,'Enable','on');
end

set(handles.NoLamad1,'Enable','off');    
set(handles.SavLam1,'Enable','off');
set(handles.tabad1,'Enable','off');

if handles.stp==2
    set(handles.p_Ad1,'Enable','on');
end


if handles.ELP2 ~=3 || handles.ad12==1
    
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
end

else
set(handles.p_Ad1,'Enable','off');
 set(handles.v_Ad1,'Enable','off');    
set(handles.E_ad1,'Enable','off');   
set(handles.Sy_Ad1,'Enable','off');
set(handles.NoLamad1,'Enable','on');
set(handles.SavLam1,'Enable','on');
set(handles.tabad1,'Enable','on');
set(handles.listbox4,'Enable','on');
set(handles.LamDef,'Enable','on'); 
set(handles.EdiLam,'Enable','on');
set(handles.DelLam,'Enable','on');   

set(handles.t_1  ,'Enable','off');  

if handles.ad12==1
set(handles.t_2  ,'Enable','off');
end
  
end



guidata(hObject, handles)

function pop_ad1_CreateFcn(hObject, eventdata, handles)
global hOb1 ev1
hOb1=hObject;
ev1=eventdata;


%===================================================================

function pop_ad2_Callback(hObject, eventdata, handles)
handles.ELP2=get(hObject,'value');
if handles.ELP2==1
set(handles.Sy_ad2,'Enable','off');
set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');
 set(handles.t_2  ,'Enable','on'); 

% if handles.ELP1 ~=3
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');

% end

if handles.stp==2 && handles.ad12==0
    set(handles.p_Ad2,'Enable','on');
end

elseif handles.ELP2==2
    set(handles.t_2  ,'Enable','on');  
if handles.stp==2 && handles.ad12==0
    set(handles.p_Ad2,'Enable','on');
end  
 
 set(handles.Sy_ad2,'Enable','on');
 set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');
% if handles.ELP1 ~=3
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');

% end   
else
set(handles.p_Ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.v_ad2,'Enable','off');
set(handles.Sy_ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.NoLamad2,'Enable','on');
set(handles.SavLam2,'Enable','on'); 
set(handles.tabad2,'Enable','on');
set(handles.listbox4,'Enable','on');
set(handles.LamDef,'Enable','on'); 
set(handles.EdiLam,'Enable','on');
set(handles.DelLam,'Enable','on');
 set(handles.t_2  ,'Enable','off');     
    
end

guidata(hObject, handles)

function pop_ad2_CreateFcn(hObject, eventdata, handles)
 global hOb2 ev2
hOb2=hObject;
ev2=eventdata;   
    
function popadhesive_Callback(hObject, eventdata, handles)
    
    
%======================================================================

handles.ELP=get(hObject,'value');
    if handles.ELP==1
        
set(handles.E_ads,'Enable','on');    
set(handles.Sy_ads,'Enable','off');
set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');    
    
    elseif handles.ELP==2
        
set(handles.E_ads,'Enable','on');    
set(handles.Sy_ads,'Enable','on');
set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');     
        
    else
        
set(handles.E_ads,'Enable','off');    
set(handles.Sy_ads,'Enable','off');
set(handles.E_e_ads,'Enable','on');
set(handles.E_m_ads,'Enable','on');
set(handles.funcdeg_ads,'Enable','on');
set(handles.No_part_ads,'Enable','on');
set(handles.radiobutton1,'Enable','on');
set(handles.radiobutton2,'Enable','on');
set(handles.helpadhesFG,'Enable','on');     
        
        
    end
handles.ELP;
    guidata(hObject,handles)
    

function popadhesive_CreateFcn(hObject, eventdata, handles)
global hOb3 ev3
hOb3=hObject;
ev3=eventdata;
%======================================================================
function E_ad1_Callback(hObject, eventdata, handles)
handles.Ead1=str2double(get(hObject,'String'));
if isnan(handles.Ead1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)


function E_ad1_CreateFcn(hObject, eventdata, handles)
    global hOb4 ev4
hOb4=hObject;
ev4=eventdata;
%====================================================================


function Sy_Ad1_Callback(hObject, eventdata, handles)
    handles.Syad1=str2double(get(hObject,'String'));
if isnan(handles.Syad1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function Sy_Ad1_CreateFcn(hObject, eventdata, handles)
    global hOb5 ev5
hOb5=hObject;
ev5=eventdata;
%==========================================================================


function v_Ad1_Callback(hObject, eventdata, handles)
handles.vad1=str2double(get(hObject,'String'));
if isnan(handles.vad1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)


function v_Ad1_CreateFcn(hObject, eventdata, handles)
    global hOb6 ev6
hOb6=hObject;
ev6=eventdata;
%==========================================================================


function p_Ad1_Callback(hObject, eventdata, handles)

handles.pad1=str2double(get(hObject,'String'));
if isnan(handles.pad1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function p_Ad1_CreateFcn(hObject, eventdata, handles)
    global hOb71 ev71
hOb71=hObject;
ev71=eventdata;

%=========================================================================

function ad_12_Callback(hObject, eventdata, handles)
handles.ad12=get(hObject,'Value');


if handles.ad12==0
    if handles.ELP2==1 || handles.ELP2==2
       set(handles.t_2  ,'Enable','on');   
    end
    
    if handles.ELP2==2
set(handles.Sy_ad2,'Enable','on');
    end
set(handles.pop_ad2,'Enable','on');
if handles.stp==2
set(handles.p_Ad2,'Enable','on');
end
if handles.ELP2~=3
set(handles.E_ad2,'Enable','on'); set(handles.v_ad2,'Enable','on');
end

if handles.ELP2==3
set(handles.NoLamad2,'Enable','on');
set(handles.SavLam2,'Enable','on'); 
set(handles.tabad2,'Enable','on');
set(handles.listbox4,'Enable','on');
set(handles.LamDef,'Enable','on'); 
set(handles.EdiLam,'Enable','on');
set(handles.DelLam,'Enable','on');

 set(handles.t_2  ,'Enable','off'); 
end

else
    
if handles.ELP1==3
    set(handles.t_2  ,'Enable','off');
elseif handles.ELP1==1||2
    set(handles.t_2  ,'Enable','on');
end 
    
set(handles.Sy_ad2,'Enable','off');
set(handles.pop_ad2,'Enable','off');
set(handles.p_Ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.v_ad2,'Enable','off');
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
 if handles.ELP1~=3   
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
 end       
end
guidata(hObject,handles)


function ad_12_CreateFcn(hObject, eventdata, handles)
global hOb72 ev72
hOb72=hObject;
ev72=eventdata;

%=========================================================================

function p_Ad2_Callback(hObject, eventdata, handles)
handles.pad2=str2double(get(hObject,'String'));
if isnan(handles.pad2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
    
function p_Ad2_CreateFcn(hObject, eventdata, handles)
    global hOb73 ev73
hOb73=hObject;
ev73=eventdata;

%==========================================================================

function v_ad2_Callback(hObject, eventdata, handles)
handles.vad2=str2double(get(hObject,'String'));
if isnan(handles.vad2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function v_ad2_CreateFcn(hObject, eventdata, handles)

global hOb74 ev74
hOb74=hObject;
ev74=eventdata;
%==========================================================================

function Sy_ad2_Callback(hObject, eventdata, handles)
handles.Syad2=str2double(get(hObject,'String'));
if isnan(handles.Syad2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function Sy_ad2_CreateFcn(hObject, eventdata, handles)
global hOb75 ev75
hOb75=hObject;
ev75=eventdata;

%=========================================================================
function E_ad2_Callback(hObject, eventdata, handles)
handles.Ead2=str2double(get(hObject,'String'));
if isnan(handles.Ead2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function E_ad2_CreateFcn(hObject, eventdata, handles)
global hOb76 ev76
hOb76=hObject;
ev76=eventdata;


%======================================================================


function listbox4_Callback(hObject, eventdata, handles)
global hOb7 ev7 S
handles.LBAD1=get(hObject,'Value');
handles.STRLBAD1=get(hObject,'String');
guidata(hObject, handles)



function listbox4_CreateFcn(hObject, eventdata, handles)
    global hOb7 ev7
   hOb7=hObject;
   ev7=eventdata;
%==========================================================================

function tabad1_CellEditCallback(hObject, eventdata, handles)
    global hOb8 ev8
 handles.Save_Lam1_indicator=0;

handles.layupad1=(get(hObject,'Data'));


guidata(hObject, handles) 

%=======================================================================
function tabad1_CreateFcn(hObject, eventdata, handles)
global hOb8 ev8
   hOb8=hObject;
   ev8=eventdata;
set(hObject,'RowName', {'L1', });
set(hObject,'ColumnFormat', {'','numeric','numeric'});
set(hObject,'ColumnName', {'Lamina','Thick','Angle'});

%========================================================================
function tabad1_CellSelectionCallback(hObject, eventdata, handles)
global hOb8 ev8

    if isempty(handles.Name)
        errordlg('First define a Lamina','Error','modal')
    else
    set(hObject,'ColumnFormat', {handles.Name,'numeric','numeric'});
    end
guidata(hObject, handles)
%====================================================================




function tabad2_CellEditCallback(hObject, eventdata, handles)
    handles.layupad2=(get(hObject,'Data'));

handles.Save_Lam2_indicator=0;   
guidata(hObject, handles) 

    
function tabad2_CreateFcn(hObject, eventdata, handles)
   global hOb11 ev11
   hOb11=hObject;
   ev11=eventdata;
set(hObject,'RowName', {'L1', });
set(hObject,'ColumnFormat', {'','numeric','numeric'});
set(hObject,'ColumnName', {'Lamina','Thick','Angle'});
    

function tabad2_CellSelectionCallback(hObject, eventdata, handles)

global hOb11 ev11
    if isempty(handles.Name)
        errordlg('First define a Lamina','Error','modal')
    else
    set(hObject,'ColumnFormat', {handles.Name,'numeric','numeric'});
    end
guidata(hObject, handles)

%=========================================================================
function SavLam1_Callback(hObject, eventdata, handles)
 if  handles.nlad1==0.25
     errordlg('        Please first enter No of Layere','Error','modal')
 else
handles.layupad1;
handles.layupad1_final=[];
b=[];
c=[];
d=[];
e=[];

b=handles.layupad1(:,1)
d=cell2mat(handles.layupad1(:,2));
e=cell2mat(handles.layupad1(:,3));

hh=[];
for i =1:length(b)
 hh(i)= isempty(find(ismember(handles.Name,b(i))))==1;   
end
    


if length(cell2mat(handles.layupad1(:,3))...
)<handles.nlad1||length(cell2mat(handles.layupad1(:,2))...
)<handles.nlad1||sum(ismember(b,''))~=0 ||sum(isnan(d))~=0||sum(isnan(e))~=0

    errordlg('     Data are incomplete or wrong  !','Error','modal')


elseif sum(hh)~=0
    
    errordlg('     One or more Lamina is Deleted, Please Modify it  !','Error','modal') 
    
else
    


for i =1:length(b)
c(i)=find(ismember(handles.Name,b(i)));
handles.layupad1_final(i,1)=c(i);
handles.layupad1_final(i,2)=d(i);
handles.layupad1_final(i,3)=e(i);
end

msgbox('Data are Saved Succefully', 'message','modal')
handles.Save_Lam1_indicator=1;
  
end
 end
 handles.layupad1_final
 guidata(hObject,handles)
 
 
function SavLam2_Callback(hObject, eventdata, handles)
    
  if  handles.nlad2==0.25
     errordlg('        Please first enter No of Layere','Error','modal')
 else
handles.layupad2;
handles.layupad2_final=[];
b=[];
c=[];
d=[];
e=[];

b=handles.layupad2(:,1);
d=cell2mat(handles.layupad2(:,2));
e=cell2mat(handles.layupad2(:,3));

if length(cell2mat(handles.layupad2(:,3))...
)<handles.nlad2||length(cell2mat(handles.layupad2(:,2))...
)<handles.nlad2||sum(ismember(b,''))~=0 ||sum(isnan(d))~=0||sum(isnan(e))~=0

    errordlg('     Data are incomplete or wrong  !','Error','modal')
else
    


for i =1:length(b)
c(i)=find(ismember(handles.Name,b(i)));
handles.layupad2_final(i,1)=c(i);
handles.layupad2_final(i,2)=d(i);
handles.layupad2_final(i,3)=e(i);
end

msgbox('Data are Saved Succefully', 'message','modal')
  handles.Save_Lam2_indicator=1;
end
 end
 handles.layupad2_final;
 guidata(hObject, handles)   
   
%=========================================================================

function NoLamad1_Callback(hObject, eventdata, handles)
     global hOb8
    handles.nlad1=str2double(get(hObject,'string'));
    
     handles.Rowtab1=[];

   
         
        if isnan (handles.nlad1)|| handles.nlad1==0 || (handles.nlad1-round(handles.nlad1))~=0
   errordlg('Input should be a non zero integer number !','Error Baradar','modal')
    
  
        else
    handles.Save_Lam1_indicator=0;
            for i =1: handles.nlad1
                handles.Rowtab1{i}=strcat('L',num2str(i));

            end  
        end
       set(hOb8,'RowName', handles.Rowtab1);  
             
       if isempty(handles.Name)
         errordlg('First define a Lamina','Error','modal')
         set(handles.NoLamad1,'string','')
         
         
       else
           
                a=cell(handles.nlad1,3);     
                for i=1:handles.nlad1
                a(i,1)={''};
                end
                
            set(hOb8,'data',a)
    set(hOb8,'ColumnFormat', {handles.Name,'numeric','numeric'});
       end
%       
    guidata(hObject, handles)
     
    
function NoLamad1_CreateFcn(hObject, eventdata, handles)
       
   global hOb9 ev9
   hOb9=hObject;
   ev9=eventdata;
%=========================================================================

    
function NoLamad2_Callback(hObject, eventdata, handles)
     global hOb11
    handles.nlad2=str2double(get(hObject,'string'));
   
     handles.Rowtab2=[];

   
         
        if isnan (handles.nlad2)|| handles.nlad2==0 || (handles.nlad2-round(handles.nlad2))~=0
   errordlg('Input should be a non zero integer number !','Error Baradar','modal')
    
  
        else
    handles.Save_Lam2_indicator=0;
            for i =1: handles.nlad2
                handles.Rowtab2{i}=strcat('L',num2str(i));

            end  
        end
       set(hOb11,'RowName', handles.Rowtab2);  
             
       if isempty(handles.Name)
         errordlg('First define a Lamina','Error','modal')
         set(handles.NoLamad2,'string','')
       else
           
            a=cell(handles.nlad2,3);     
            for i=1:handles.nlad2
            a(i,1)={''};
            end
                
            set(hOb11,'data',a)
    set(hOb11,'ColumnFormat', {handles.Name,'numeric','numeric'});
       end
        
    guidata(hObject, handles)
     
    
function NoLamad2_CreateFcn(hObject, eventdata, handles)
   global hOb10 ev10
   hOb10=hObject;
   ev10=eventdata;
 guidata(hObject, handles)

   
%Adherent1LaminaDefinition=========================================================================

function LamDef_Callback(hObject, eventdata, handles)
close(figure (1))
global S hOb7
j=figure(1)
set(j,'Position',[300 300 400 300],'Color', [.94 .94 .94])
set(hOb7,'Value', 1)
%E1
H1=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .80, .12,.08],...
    'callback',@HF1);
HT1=uicontrol('Style', 'text', 'unit','normalized','Position', [.13, .82, .06,.05],'string','Exx');

%E2
H2=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .80, .12,.08],...
    'callback',@HF2);
HT2=uicontrol('Style', 'text', 'unit','normalized','Position', [.37, .82, .06,.05],'string','Eyy');
%v12
H3=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.68, .80, .12,.08],...
    'callback',@HF3);
HT3=uicontrol('Style', 'text', 'unit','normalized','Position', [.61, .82, .06,.05],'string','vxy');
%G12
H4=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .65, .12,.08],...
    'callback',@HF4);
HT4=uicontrol('Style', 'text', 'unit','normalized','Position', [.13, .67, .06,.05],'string','Gxy');
%G13
H5=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .65, .12,.08],...
    'callback',@HF5);
HT5=uicontrol('Style', 'text', 'unit','normalized','Position', [.37, .67, .06,.05],'string','Gxz');
%G23
H6=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.68, .65, .12,.08],...
    'callback',@HF6);
HT6=uicontrol('Style', 'text', 'unit','normalized','Position', [.61, .67, .06,.05],'string','Gyz');
%Lamina Name
H7=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .35, .18,.08],...
   'callback',@HF7);
HT7=uicontrol('Style', 'text', 'unit','normalized','Position', [.25, .37, .17,.05],'string','Lamina Name');
%Push Button
H8=uicontrol('style', 'pushbutton', 'BackgroundColor', [.94 .94 .94],...
    'unit','normalized', 'Position',[.44, .20, .12, .08],'String', 'Save',...
    'callback',{@HF8, handles, hObject});
%Density
H9=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .50, .12,.08],...
   'callback',@HF9);
HT9=uicontrol('Style', 'text', 'unit','normalized','Position', [.09, .52, .10,.05],'string','Density');

if handles.stp==2
    set(H9, 'Enable','on');
else
    set(H9, 'Enable','off');
end


function HF1(H1, ev1)
global S
S.E1=str2double(get(H1,'String'));

function HF2(H2, ev2)
global S
S.E2=str2double(get(H2,'String'));

function HF3(H3, ev3)
global S
S.v12=str2double(get(H3,'String'));

function HF4(H4, ev4)
global S
S.G12=str2double(get(H4,'String'));

function HF5(H5, ev5)
global S
S.G13=str2double(get(H5,'String'));

function HF6(H6, ev6)
global S
S.G23=str2double(get(H6,'String'));

function HF7(H7, ev7)
global S
S.Name=get(H7,'String');

function HF9(H9, ev9)
global S
S.p=str2double(get(H9,'String'));

 function HF8(H8, ev8, handles, hObject)
global S hOb7 hOb8 hOb11

S;
S.ln= handles.LN;
 handles.LN=S.ln;
handles.LN=1+handles.LN;
handles.Name{handles.LN}=S.Name;
    handles.Name
if isnan (S.E1)||isnan (S.E2)||isnan (S.v12)||...
        isnan (S.G12)||isnan (S.G13)||isnan (S.G23)||isempty (S.Name)||(isnan (S.p)&& handles.stp==2)
   errordlg('Data are incomplete or wrong','Error Baradar','modal')
handles.LN=-1+handles.LN;
elseif (isnan (S.p)&& handles.stp==2)
 errordlg('Data are incomplete or wrong','Error Baradar','modal')
handles.LN=-1+handles.LN;

elseif length(handles.Name)-length(unique(handles.Name)) ~=0
 handles.LN=-1+handles.LN;
  errordlg('Material name is repeted','Error','modal')


else
   S.yn=1; 
  handles.CM(handles.LN,1)=S.E1;
  handles.CM(handles.LN,2)=S.E2;
  handles.CM(handles.LN,3)=S.v12;
  handles.CM(handles.LN,4)=S.G12;
  handles.CM(handles.LN,5)=S.G13;
  handles.CM(handles.LN,6)=S.G23;
 if handles.stp==2
  handles.CM(handles.LN,7)=S.p;
 else 
  handles.CM(handles.LN,7)=0.0;
 end
  
  set (hOb7, 'String', handles.Name);
    S.E1=str2double('d2');
    S.E2=str2double('d2');
    S.v12=str2double('d2');
    S.G12=str2double('d2');
    S.G13=str2double('d2');
    S.G23=str2double('d2');
    S.p=str2double('d2');
    S.Name='';
    
    set(hOb8,'ColumnFormat', {handles.Name,'numeric','numeric'});
    set(hOb11,'ColumnFormat', {handles.Name,'numeric','numeric'});
  handles.LN=handles.LN;
    guidata(hObject, handles);
  close (figure(1))
end


%=========================================================================

function EdiLam_Callback(hObject, eventdata, handles)
global S
handles.LN= handles.LN;
handles.LN=handles.LN
if handles.LN==0
   errordlg('First define a "Lamina"','Error','modal') 
else
close(figure (1))
j=figure(1)
set(j,'Position',[300 300 400 300],'Color', [.94 .94 .94])

 jj=handles.LBAD1;
    jj=handles.LBAD1;  
    S.E1= handles.CM(jj,1);
    S.E2=handles.CM(jj,2);
    S.v12=handles.CM(jj,3);
    S.G12=handles.CM(jj,4);
    S.G13= handles.CM(jj,5);
    S.G23=handles.CM(jj,6);
  
 
    S.Name= handles.Name{jj}

%E1
Hh1=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .80, .12,.08],...
    'callback',@HF1);
HhT1=uicontrol('Style', 'text', 'unit','normalized','Position', [.13, .82, .06,.05],'string','Exx');

%E2
Hh2=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .80, .12,.08],...
    'callback',@HF2);
HhT2=uicontrol('Style', 'text', 'unit','normalized','Position', [.37, .82, .06,.05],'string','Eyy');
%v12
Hh3=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.68, .80, .12,.08],...
    'callback',@HF3);
HhT3=uicontrol('Style', 'text', 'unit','normalized','Position', [.61, .82, .06,.05],'string','vxy');
%G12
Hh4=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .65, .12,.08],...
    'callback',@HF4);
HhT4=uicontrol('Style', 'text', 'unit','normalized','Position', [.13, .67, .06,.05],'string','Gxy');
%G13
Hh5=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .65, .12,.08],...
    'callback',@HF5);
HhT5=uicontrol('Style', 'text', 'unit','normalized','Position', [.37, .67, .06,.05],'string','Gxz');
%G23
Hh6=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.68, .65, .12,.08],...
    'callback',@HF6);
HhT6=uicontrol('Style', 'text', 'unit','normalized','Position', [.61, .67, .06,.05],'string','Gyz');
%Lamina Name
Hh7=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.44, .35, .18,.08],...
   'callback',@HF7);
HhT7=uicontrol('Style', 'text', 'unit','normalized','Position', [.25, .37, .17,.05],'string','Lamina Name');
%Push Button
Hh8=uicontrol('style', 'pushbutton', 'BackgroundColor', [.94 .94 .94],...
    'unit','normalized', 'Position',[.44, .20, .12, .08],'String', 'Save',...
    'callback',{@HFF8, handles, hObject});
%Density
Hh9=uicontrol('Style', 'edit', 'unit', 'normalized',...
    'BackgroundColor', [1 1 1],'Position', [.2, .50, .12,.08],...
   'callback',@HF9);
HhT9=uicontrol('Style', 'text', 'unit','normalized','Position', [.09, .52, .10,.05],'string','Density');

if handles.stp==2
    set(Hh9, 'Enable','on');
else
    set(Hh9, 'Enable','off');
end


 
  set (Hh1,'string',handles.CM(jj,1));
  set (Hh2,'string',handles.CM(jj,2));
  set (Hh3,'string',handles.CM(jj,3));
  set (Hh4,'string',handles.CM(jj,4));
  set (Hh5,'string',handles.CM(jj,5));
  set (Hh6,'string',handles.CM(jj,6));
  set (Hh7,'string',handles.Name{jj});
  
   if handles.stp==2
   set (Hh9,'string',handles.CM(jj,7));
 end
end

 function HFF8(H9, ev9, handles, hObject) 
  global S hOb7 hOb8 hOb11
  
  if isnan (S.E1)||isnan (S.E2)||isnan (S.v12)||...
        isnan (S.G12)||isnan (S.G13)||isnan (S.G23)||...
        (isnan (S.p)&& handles.stp==2)||isempty (S.Name)
    
    errordlg('Data are incomplete or wrong','Error','modal')
  
  else
  jj=handles.LBAD1;  
  handles.CM(jj,1)=S.E1;
  handles.CM(jj,2)=S.E2;
  handles.CM(jj,3)=S.v12;
  handles.CM(jj,4)=S.G12;
  handles.CM(jj,5)=S.G13;
  handles.CM(jj,6)=S.G23;
  if handles.stp==2
  handles.CM(jj,7)=S.p;
  end
  handles.Name{jj}=S.Name;
  handles.CM;
  set (hOb7, 'String', handles.Name)
  set(hOb8,'ColumnFormat', {handles.Name,'numeric','numeric'});
  set(hOb11,'ColumnFormat', {handles.Name,'numeric','numeric'});
  close(figure(1))
  guidata(hObject, handles)
  end
  
  %========================================================================
function DelLam_Callback(hObject, eventdata, handles)
     global S hOb7 ev7 hOb8 ev8 hOb11
  
   handles.LN=handles.LN;
   handles.LN= handles.LN;
 if handles.LN==0
   errordlg('First define a "Lamina"','Error','modal') 
 else
    
 
    jj=handles.LBAD1;
    jj
%     jj1=handles.STRLBAD1;
    
    promptMessage = sprintf(strcat('Do You want to delete lamina ',' "',handles.Name{jj},' "'));
    titleBarCaption = 'Yes or No';

	button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','modal');
	 
    if strcmpi(button, 'Yes')
    handles.CM(jj,:)=[];
     handles.Name(jj)=[];
     handles.LN=handles.LN-1
     handles
     S
     handles.CM;
%      
     handles.Name;
%  
% b=handles.layupad1(:,1)     
% if handles.ELP1==3 && length(cell2mat(b)~=0)
% 
% hh=[];
% for i =1:length(b)
%  hh(i)= isempty(find(ismember(handles.Name,b(i))))==1;   
% end   
% 
% if sum(hh) ~=0
% handles.Save_Lam1_indicator=0;     
% end
% end    
%      
% b=handles.layupad2(:,1)     
% if handles.ELP2==3 & handles.ad12==0 && length(cell2mat(b)~=0)
% b=handles.layupad2(:,1)
% hh=[];
% for i =1:length(b)
%  hh(i)= isempty(find(ismember(handles.Name,b(i))))==1;   
% end   
% 
% if sum(hh) ~=0
% handles.Save_Lam2_indicator=0;     
% end
% end    
%      




     set(hOb7,'Value', 1)
       
     set (hOb7, 'string', handles.Name);
  
     if isempty(handles.Name)
         handles.Name={'please define a Lamina'}
         tabad1_CellSelectionCallback(hOb8,ev8, handles)
         
          
           handles.Name(1)=[];
     else
       
     set(hOb8,'ColumnFormat', {handles.Name,'numeric','numeric'});
     set(hOb11,'ColumnFormat', {handles.Name,'numeric','numeric'});
     end
     guidata(hObject, handles)
    end

 end


%==============================================================
function E_ads_Callback(hObject, eventdata, handles)
 
    handles.Eads=str2double(get(hObject,'String'));
if isnan(handles.Eads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
    
function E_ads_CreateFcn(hObject, eventdata, handles)
%======================================================================


function Sy_ads_Callback(hObject, eventdata, handles)

        handles.Syads=str2double(get(hObject,'String'));
if isnan(handles.Syads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function Sy_ads_CreateFcn(hObject, eventdata, handles)


%============================================================

function v_ads_Callback(hObject, eventdata, handles)
    handles.vads=str2double(get(hObject,'String'));
if isnan(handles.vads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
function v_ads_CreateFcn(hObject, eventdata, handles)

%===================================================================

function p_ads_Callback(hObject, eventdata, handles)
    handles.pads=str2double(get(hObject,'String'));
if isnan(handles.pads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)    

function p_ads_CreateFcn(hObject, eventdata, handles)
%===================================================================

function E_e_ads_Callback(hObject, eventdata, handles)
    handles.Eeads=str2double(get(hObject,'String'));
if isnan(handles.Eeads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)  

function E_e_ads_CreateFcn(hObject, eventdata, handles)

%===================================================================


function E_m_ads_Callback(hObject, eventdata, handles)
     handles.Emads=str2double(get(hObject,'String'));
if isnan(handles.Emads)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
function E_m_ads_CreateFcn(hObject, eventdata, handles)

%=====================================================================

function funcdeg_ads_Callback(hObject, eventdata, handles)
    handles.funcdegree=str2double(get(hObject,'String'));
if isnan(handles.funcdegree)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
    
elseif handles.funcdegree<0 || (mod(handles.funcdegree,2)==1 && handles.funcdegree~=1)|| ((floor(handles.funcdegree)-handles.funcdegree) ~=0 && handles.funcdegree>1)
     errordlg('Valid Value for n: 0<n<1, n=1 and n=2,4,6, ...  ','Error','modal')
     handles.funcdegree=2;
     set(hObject,'string','2')
mode    
end
guidata(hObject,handles)
function funcdeg_ads_CreateFcn(hObject, eventdata, handles)


%========================================================================

function No_part_ads_Callback(hObject, eventdata, handles)
    handles.nopartition=str2double(get(hObject,'String'));
if isnan(handles.nopartition)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

function No_part_ads_CreateFcn(hObject, eventdata, handles)

%=========================================================================
    
    
function helpadhesFG_Callback(hObject, eventdata, handles)

    open('Help-FG.pdf')

%================================================================
function mesh_thick_Callback(hObject, eventdata, handles)
 handles.meshthick=str2double(get(hObject,'String'));
if isnan(handles.meshthick)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

    
function mesh_thick_CreateFcn(hObject, eventdata, handles)
%==============================================================
function ad_nonlin_mesh_Callback(hObject, eventdata, handles)
handles.nonlinmesh=get(hObject,'value');
guidata(hObject, handles)


function mesh_size_Callback(hObject, eventdata, handles)
     handles.meshsize=str2double(get(hObject,'String'));
if isnan(handles.meshsize)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
handles.meshsize;
guidata(hObject,handles)

function mesh_size_CreateFcn(hObject, eventdata, handles)

%===============================================================


function step_time_Callback(hObject, eventdata, handles)
 handles.stptime=str2double(get(hObject,'String'));
if isnan(handles.steptime)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
    
    
function step_time_CreateFcn(hObject, eventdata, handles)


%===========================================================
function T_x_Callback(hObject, eventdata, handles)
handles.Tx=str2double(get(hObject,'String'));
if isnan(handles.Tx)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

     
end
guidata(hObject,handles)

function T_x_CreateFcn(hObject, eventdata, handles)

%=============================================================
function T_y_Callback(hObject, eventdata, handles)
handles.Ty=str2double(get(hObject,'String'));
if isnan(handles.Ty)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

     
end
guidata(hObject,handles)

function T_y_CreateFcn(hObject, eventdata, handles)

%=============================================================

function T_z_Callback(hObject, eventdata, handles)
 handles.Tz=str2double(get(hObject,'String'));  
if isnan(handles.Tz)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

   
    
end
guidata(hObject,handles)   

function T_z_CreateFcn(hObject, eventdata, handles)
%==============================================================

function U_x_Callback(hObject, eventdata, handles)
 handles.Ux=str2double(get(hObject,'String'));
if isnan(handles.Ux)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)

function U_x_CreateFcn(hObject, eventdata, handles)

%==============================================================
function U_y_Callback(hObject, eventdata, handles)
 handles.Uy=str2double(get(hObject,'String'));
if isnan(handles.Uy)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)

function U_y_CreateFcn(hObject, eventdata, handles)

%==============================================================
function U_z_Callback(hObject, eventdata, handles)
 handles.Uz=str2double(get(hObject,'String')); 
if isnan(handles.Uz)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

   
end
guidata(hObject,handles)
    
function U_z_CreateFcn(hObject, eventdata, handles)

%======================================================

function t_1_Callback(hObject, eventdata, handles)

 handles.t1=str2double(get(hObject,'String'));
if isnan(handles.t1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)

    
function t_1_CreateFcn(hObject, eventdata, handles)
    
%=============================================================
function t_2_Callback(hObject, eventdata, handles)
 handles.t2=str2double(get(hObject,'String'));
if isnan(handles.t2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
    
    
    
function t_2_CreateFcn(hObject, eventdata, handles)    
    
%=================================================================    

function t_3_Callback(hObject, eventdata, handles)

   handles.t3=str2double(get(hObject,'String'));
if isnan(handles.t3)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)  

function t_3_CreateFcn(hObject, eventdata, handles)
    
%====================================================================  
function L_1_Callback(hObject, eventdata, handles)
  handles.L1=str2double(get(hObject,'String'));     
if isnan(handles.L1)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

  
end
guidata(hObject,handles)

function L_1_CreateFcn(hObject, eventdata, handles)
%====================================================================

function L_2_Callback(hObject, eventdata, handles)
 handles.L2=str2double(get(hObject,'String'));      
if isnan(handles.L2)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)  

function L_2_CreateFcn(hObject, eventdata, handles)    
    
%=====================================================================    
function L_3_Callback(hObject, eventdata, handles)
 handles.L3=str2double(get(hObject,'String'));    
if isnan(handles.L3)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)
    
function L_3_CreateFcn(hObject, eventdata, handles)  
    
%==================================================================== 

function L_6_Callback(hObject, eventdata, handles)
     handles.L6=str2double(get(hObject,'String'));    
if isnan(handles.L6)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)

function L_6_CreateFcn(hObject, eventdata, handles)

%==================================================================== 

function L_5_Callback(hObject, eventdata, handles)
 handles.L5=str2double(get(hObject,'String'));    
if isnan(handles.L5)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')

    
end
guidata(hObject,handles)

function L_5_CreateFcn(hObject, eventdata, handles)

%==================================================================== 
function w__Callback(hObject, eventdata, handles)

         handles.w=str2double(get(hObject,'String'));
if isnan(handles.w)
    errordlg('            Invalid input  !','Error','modal')
    set(hObject,'string','')
end
guidata(hObject,handles)
function w__CreateFcn(hObject, eventdata, handles)    
%============================================================

function LC_SelectionChangeFcn(hObject, eventdata, handles)
if strcmp(get(hObject,'string'),'Load')
    handles.LC=2;
set(handles.U_x,'Enable','off');
set(handles.U_z,'Enable','off');
set(handles.U_y,'Enable','off');
set(handles.T_x,'Enable','on');
set(handles.T_z,'Enable','on'); 
set(handles.T_y,'Enable','on');
else
    handles.LC=1;
set(handles.U_x,'Enable','on');
set(handles.U_z,'Enable','on');
set(handles.U_y,'Enable','on');
set(handles.T_x,'Enable','off');
set(handles.T_z,'Enable','off');  
set(handles.T_y,'Enable','off');    
end
guidata(hObject,handles)


%====================================================================
function stp_SelectionChangeFcn(hObject, eventdata, handles)
    global S
if strcmp(get(hObject,'string'),'Implicit')
    handles.stp=1;
    
set(handles.step_time,'Enable','off');
set(handles.p_Ad1,'Enable','off');
set(handles.p_Ad2,'Enable','off');
set(handles.p_ads,'Enable','off');

  
else
    handles.stp=2;
    
set(handles.step_time,'Enable','on');
if handles.ELP1~=3
set(handles.p_Ad1,'Enable','on');
end

if handles.ad12==0
    if handles.ELP2~=3
set(handles.p_Ad2,'Enable','on');
    end
end
set(handles.p_ads,'Enable','on');    
    
end
guidata(hObject,handles)
%=====================================================================
function GDIR_SelectionChangeFcn(hObject, eventdata, handles)
 if strcmp(get(hObject,'string'),'Length')
    handles.gradebehav=2;
else
    handles.gradebehav=3;
 end
handles.gradebehav;
guidata(hObject,handles)   
    
%======================================================================

function Save_dir_Callback(hObject, eventdata, handles)

handles.directoryName = uigetdir('','Please select a folder to save to');
if handles.directoryName == 0      %# User pressed the "Cancel" button...
handles.directoryName = '';      %#   ...so choose the empty string for the folder
end
handles.directoryName
guidata(hObject,handles) 
%======================================================================

function checkbox14_Callback(hObject, eventdata, handles)
handles.holdon=get(hObject,'value');

guidata(hObject,handles)

% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
    set(handles.axes2);
     set(handles.axes3); 
      set(handles.axes4); 
       set(handles.axes5); 
        set(handles.axes6); 
         set(handles.axes7); 
brush on;



 %############################################################################
 
% --------------------------------------------------------------------
function save_handle_ClickedCallback(hObject, eventdata, handles)
data=handles;
uisave('data','.mat');

% --------------------------------------------------------------------
function open_handle_ClickedCallback(hObject, eventdata, handles)
   global S hOb72 ev72
   
   [filename1,filepath1]=uigetfile({'*.mat','.mat'},'Select Data File 1');
  cd(filepath1);
%   handles.syon=1;
handles1=load(filename1,'');
handles2=handles1.data;
 %====================================
 if ~exist('Temp')
    mkdir('Temp')
end
   
set(handles.E_ad1,'string','')
set(handles.E_ad2,'string','')
set(handles.v_Ad1,'string','')
set(handles.Sy_Ad1,'string','')
set(handles.p_Ad1,'string','')
set(handles.p_Ad2,'string','')
set(handles.v_ad2,'string','')
set(handles.Sy_ad2,'string','')
set(handles.NoLamad1,'string','')
set(handles.NoLamad2,'string','')
set(handles.listbox4,'string','')
set(handles.E_ads,'string','')
set(handles.v_ads,'string','')
set(handles.Sy_ads,'string','')
set(handles.p_ads,'string','')
set(handles.E_e_ads,'string','')
set(handles.E_m_ads,'string','')
set(handles.funcdeg_ads,'string','')
set(handles.No_part_ads,'string','')
set(handles.L_1,'string','')
set(handles.L_2,'string','')
set(handles.L_3,'string','')
set(handles.L_5,'string','')
set(handles.L_6,'string','')
set(handles.t_1,'string','')
set(handles.t_2,'string','')
set(handles.t_3,'string','')
set(handles.w_,'string','')
set(handles.T_x,'string','')
set(handles.T_y,'string','')
set(handles.T_z,'string','')
set(handles.U_x,'string','')
set(handles.U_y,'string','')
set(handles.U_z,'string','')
set(handles.step_time,'string','')
set(handles.mesh_thick,'string','')
set(handles.mesh_size,'string','')
set(handles.E_ad1,'string','')
set(handles.E_ad1,'string','')

set(handles.pop_ad1,'value',1)
set(handles.pop_ad2,'value',1)
set(handles.popadhesive,'value',1)
set(handles.radiobutton1,'value',1)
set(handles.Load,'value',0)
set(handles.Implicit,'value',1)
set(handles.ad_12,'value',0)
set(handles.Joint_type,'value',1)
set(handles.popadhesive,'value',1)
set(handles.tabad2,'data',['', '',''])
set(handles.tabad1,'data',['', '',''])
set(handles.tabad1,'RowName', {'L1', });
set(handles.tabad2,'RowName', {'L1', });
handles.gradebehav=2;


handles.LN=0;
handles.LN=0;
S.yn=0;
S.E1=str2double('');
S.E2=str2double('');
S.v12=str2double('');
S.G12=str2double('');
S.G13=str2double('');
S.G23=str2double('');
S.p=str2double('');
S.Name={};
handles.Name={};
handles.LBAD1=1;
handles.layupad1={};
handles.layupad2={};
handles.CM=[];
handles.layupad1_final=[];
handles.layupad2_final=[];
handles.nlad1=0.25;
handles.nlad2=0.25;
handles.ELP1=1;
handles.ELP2=1;
 handles.ad12=0;
handles.nonlinmesh=0;
handles.jointtype=1; 
handles.ad12=0;
handles.stp=1;                
handles.stptime=.01;         
handles.ELP2=1;
handles.ELP1=1;
handles.ELP=1; 
handles.LC=1;

handles.Save_Lam1_indicator=0;
handles.Save_Lam2_indicator=0;

handles.L1=str2double('');
handles.L2=str2double('');
handles.L3=str2double('');
handles.L5=str2double('');
handles.L6=str2double('');
handles.t1=str2double('');
handles.t2=str2double('');
handles.t3=str2double('');
handles.w=str2double('');    

handles.nopartition=str2double('');       
                          
handles.meshsize=str2double('');
handles.meshthick=str2double('');              
handles.pad1=str2double('');
handles.pad2=str2double('');

handles.Syad1=str2double('');
handles.Ead1=str2double('');
handles.vad1=str2double('');

handles.Syad2=str2double('');
handles.Ead2=str2double('');
handles.vad2=str2double('');              
handles.Syads=str2double('');

handles.Eads=str2double('');
handles.vads=str2double('');
handles.Eeads=str2double('');
handles.Emads=str2double('');
handles.vads=str2double('');
handles.funcdegree=str2double(''); 
handles.pads=str2double('');

handles.Ux=str2double('');
handles.Uy=str2double('');
handles.Uz=str2double('');
handles.Tx=str2double('');
handles.Ty=str2double('');
handles.Tz=str2double('');

handles.holdon=0; 
imshow('1.bmp', 'Parent', handles.axes1);

set(handles.Sy_Ad1,'Enable','off');
set(handles.Sy_ad2,'Enable','off');
set(handles.p_Ad1,'Enable','off');
set(handles.p_Ad2,'Enable','off');
set(handles.NoLamad1,'Enable','off');
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam1,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad1,'Enable','off');
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
set(handles.Sy_ads,'Enable','off');
set(handles.p_ads,'Enable','off'); 
set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');

set(handles.step_time,'Enable','off');
set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');
set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');
set(handles.E_ads,'Enable','on');
set(handles.T_x,'Enable','off');
set(handles.T_y,'Enable','off');
set(handles.T_z,'Enable','off');
set(handles.U_x,'Enable','on');
set(handles.U_y,'Enable','on');
set(handles.U_z,'Enable','on');



set(handles.resultpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
set(handles.datainputpanel,'visible','on');


handles.pwd0=pwd;
pw00=handles.pwd0;
aaa=find(pw00=='\');
pw00(aaa)='/';
handles.pwd0=pw00;

axes(handles.axes2);
hold off
plot(handles.axes2,1,1)
axes(handles.axes4);
hold off
plot(handles.axes4,1,1)
axes(handles.axes6);
hold off
plot(handles.axes6,1,1)
axes(handles.axes3);
hold off
plot(handles.axes3,1,1)
axes(handles.axes5);
hold off
plot(handles.axes5,1,1)
axes(handles.axes7);
hold off
plot(handles.axes7,1,1)







set(handles.axes7,'visible', 'off')
set(handles.axes5,'visible', 'off')
set(handles.axes3,'visible', 'off')

% handles.output = hObject;
% guidata(hObject, handles);
 %######################################

    

handles.jointtype=handles2.jointtype; 
handles.ad12=handles2.ad12;
handles.stp=handles2.stp;
handles.LC=handles2.LC;
handles.ELP2=handles2.ELP2;
handles.ELP1=handles2.ELP1;
handles.ELP=handles2.ELP;  
handles.gradebehav=handles2.gradebehav;
handles.L1=handles2.L1;
handles.L2=handles2.L2;
handles.L3=handles2.L3;
handles.L5=handles2.L5;
handles.L6=handles2.L6;
handles.t1=handles2.t1;
handles.t2=handles2.t2;
handles.t3=handles2.t3;
handles.w=handles2.w;                               
handles.meshsize=handles2.meshsize;
handles.meshthick=handles2.meshthick;                             
handles.stptime=handles2.stptime;         
handles.pad1=handles2.pad1;
handles.pad2=handles2.pad2;
handles.Syad1=handles2.Syad1;
handles.Ead1=handles2.Ead1;
handles.vad1=handles2.vad1;
handles.Syad2=handles2.Syad2;
handles.Ead2=handles2.Ead2;
handles.vad2=handles2.vad2;
handles.nlad1=handles2.nlad1;
handles.nlad2=handles2.nlad2;              
handles.Syads=handles2.Syads;
handles.Eads=handles2.Eads;
handles.vads=handles2.vads;
handles.Eeads=handles2.Eeads;
handles.Emads=handles2.Emads;
handles.vads=handles2.vads;
handles.nopartition=handles2.nopartition; 
handles.funcdegree=handles2.funcdegree; 
handles.pads=handles2.pads;
handles.layupad1_final=handles2.layupad1_final;
handles.layupad2_final=handles2.layupad2_final;
handles.Name=handles2.Name;
handles.layupad1=handles2.layupad1;
handles.layupad2=handles2.layupad2;
handles.CM=handles2.CM;
handles.Tx=handles2.Tx;
handles.Ty=handles2.Ty;
handles.Tz=handles2.Tz;
handles.Ux=handles2.Ux;
handles.Uy=handles2.Uy;
handles.Uz=handles2.Uz;
handles.Save_Lam1_indicator=handles2.Save_Lam1_indicator;
handles.Save_Lam2_indicator=handles2.Save_Lam2_indicator;
handles.LN= handles2.LN;
handles.nonlinmesh=handles2.nonlinmesh;

%Joint type------------------------------------------------------------

if handles.jointtype==1
    
imshow('1.bmp', 'Parent', handles.axes1);
imshow('Path1.bmp', 'Parent', handles.axes8); 


set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');

elseif handles.jointtype==2
    
imshow('2.bmp', 'Parent', handles.axes1); 
imshow('Path2.bmp', 'Parent', handles.axes8); 


set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');
elseif handles.jointtype==3
    
imshow('3.bmp', 'Parent', handles.axes1); 
imshow('Path3.bmp', 'Parent', handles.axes8); 

set(handles.L_5,'Enable','off');
set(handles.L_6,'Enable','off');


elseif handles.jointtype==4
imshow('4.bmp', 'Parent', handles.axes1); 
imshow('Path4.bmp', 'Parent', handles.axes8); 
 set(handles.L_5,'Enable','on');
set(handles.L_6,'Enable','on');  
end


%ELP1-----------------------------------------------------------------------
if handles.ELP1==1
set(handles.pop_ad1,'value',1);    
   
set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');

set(handles.t_1  ,'Enable','on');
if handles.ad12==1
set(handles.t_2  ,'Enable','on');
end

set(handles.v_Ad1,'String',num2str(handles.vad1));    
set(handles.E_ad1,'String',num2str(handles.Ead1));


set(handles.Sy_Ad1,'Enable','off');
set(handles.NoLamad1,'Enable','off');    
set(handles.SavLam1,'Enable','off');
set(handles.tabad1,'Enable','off');

if handles.stp==2
    set(handles.Explicit,'value',1); 
    set(handles.p_Ad1,'Enable','on');
    set(handles.p_Ad1,'String',num2str(handles.pad1));  
end

if handles.ELP2 ~=3 || handles.ad12==1
    
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
end   
    
elseif handles.ELP1==2
set(handles.pop_ad1,'value',2);    
    
set(handles.v_Ad1,'Enable','on');    
set(handles.E_ad1,'Enable','on');   
set(handles.Sy_Ad1,'Enable','on');

set(handles.t_1  ,'Enable','on');
if handles.ad12==1
set(handles.t_2  ,'Enable','on');
end

set(handles.v_Ad1,'String',num2str(handles.vad1));    
set(handles.E_ad1,'String',num2str(handles.Ead1));   
set(handles.Sy_Ad1,'String',num2str(handles.Syad1));

set(handles.NoLamad1,'Enable','off');    
set(handles.SavLam1,'Enable','off');
set(handles.tabad1,'Enable','off');

if handles.stp==2
    set(handles.Explicit,'value',1); 
    set(handles.p_Ad1,'Enable','on');
    set(handles.p_Ad1,'String',num2str(handles.pad1));  
end


if handles.ELP2 ~=3 || handles.ad12==1
    
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
end

else
set(handles.pop_ad1,'value',3);  
 
set(handles.p_Ad1,'Enable','off');
set(handles.v_Ad1,'Enable','off');    
set(handles.E_ad1,'Enable','off');   
set(handles.Sy_Ad1,'Enable','off');
set(handles.NoLamad1,'Enable','on');
set(handles.SavLam1,'Enable','on');
set(handles.tabad1,'Enable','on');
set(handles.listbox4,'Enable','on');
set(handles.LamDef,'Enable','on'); 
set(handles.EdiLam,'Enable','on');
set(handles.DelLam,'Enable','on');   

set(handles.t_1  ,'Enable','off');
if handles.ad12==1
set(handles.t_2  ,'Enable','off');
end

if handles.nlad1~=0.25
set(handles.NoLamad1,'String',num2str(handles.nlad1));
else
 set(handles.NoLamad1,'String','');
end

set(handles.tabad1,'Data',handles.layupad1);
set(handles.listbox4,'String',handles.Name) ;  
    
end
%ad12-------------------------------------------------------
if handles.ad12==0
    set(handles.ad_12,'Value',0);

%ELP2-------------------------------------------------
if handles.ELP2==1
 set(handles.pop_ad2,'value',1);  
 
set(handles.Sy_ad2,'Enable','off');
set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');

set(handles.t_2  ,'Enable','on');

set(handles.v_ad2,'String',num2str(handles.vad2));    
set(handles.E_ad2,'String',num2str(handles.Ead2));

% if handles.ELP1 ~=3
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');

% end

if handles.stp==2 && handles.ad12==0
    set(handles.p_Ad2,'Enable','on');
    set(handles.p_Ad2,'String',num2str(handles.pad2));
end

elseif handles.ELP2==2
 set(handles.pop_ad2,'value',2);     
if handles.stp==2 && handles.ad12==0
    set(handles.p_Ad2,'Enable','on');
    set(handles.p_Ad2,'String',num2str(handles.pad2));
end  
 
 set(handles.Sy_ad2,'Enable','on');
 set(handles.E_ad2,'Enable','on');
set(handles.v_ad2,'Enable','on');

set(handles.t_2  ,'Enable','on');

    set(handles.Sy_ad2,'String',num2str(handles.Syad2));
    set(handles.E_ad2,'String',num2str(handles.Ead2));
    set(handles.v_ad2,'String',num2str(handles.vad2));
    
% if handles.ELP1 ~=3
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');

% end   
else
set(handles.pop_ad2,'value',3);  

set(handles.p_Ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.v_ad2,'Enable','off');
set(handles.Sy_ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.NoLamad2,'Enable','on');
set(handles.SavLam2,'Enable','on'); 
set(handles.tabad2,'Enable','on');
set(handles.listbox4,'Enable','on');
set(handles.LamDef,'Enable','on'); 
set(handles.EdiLam,'Enable','on');
set(handles.DelLam,'Enable','on');

if handles.nlad2~=0.25
set(handles.NoLamad2,'String',num2str(handles.nlad2));
else
 set(handles.NoLamad2,'String','');
end

set(handles.tabad2,'Data',handles.layupad2);
set(handles.listbox4,'String',handles.Name)  

end

else
  set(handles.ad_12,'Value',1);
    
set(handles.Sy_ad2,'Enable','off');
set(handles.pop_ad2,'Enable','off');
set(handles.p_Ad2,'Enable','off');
set(handles.E_ad2,'Enable','off');
set(handles.v_ad2,'Enable','off');
set(handles.NoLamad2,'Enable','off');
set(handles.SavLam2,'Enable','off'); 
set(handles.tabad2,'Enable','off');
 
if handles.ELP1~=3   
set(handles.listbox4,'Enable','off');
set(handles.LamDef,'Enable','off'); 
set(handles.EdiLam,'Enable','off');
set(handles.DelLam,'Enable','off');
set(handles.t_2  ,'Enable','on'); 

else
    
    set(handles.t_2  ,'Enable','off');

end

end

%ELP-----------------------------------------------------------------------
    if handles.ELP==1
        if handles.stp==2
        set(handles.p_ads,'Enable','on');
        set(handles.p_ads,'String',num2str(handles.pads));
        end
   set(handles.popadhesive,'value',1);  
   
set(handles.E_ads,'Enable','on');  
set(handles.E_ads,'String',num2str(handles.Eads));
set(handles.v_ads,'String',num2str(handles.vads));

set(handles.Sy_ads,'Enable','off');
set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');    
    
    elseif handles.ELP==2
       if handles.stp==2
        set(handles.p_ads,'Enable','on');
        set(handles.p_ads,'String',num2str(handles.pads));
        end   
   set(handles.popadhesive,'value',2);       
set(handles.E_ads,'Enable','on');    
set(handles.Sy_ads,'Enable','on');

set(handles.E_ads,'String',num2str(handles.Eads));
set(handles.v_ads,'String',num2str(handles.vads));
set(handles.Sy_ads,'String',num2str(handles.Syads));

set(handles.E_e_ads,'Enable','off');
set(handles.E_m_ads,'Enable','off');
set(handles.funcdeg_ads,'Enable','off');
set(handles.No_part_ads,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.helpadhesFG,'Enable','off');     
        
    else
   set(handles.popadhesive,'value',3);    
         if handles.stp==2
        set(handles.p_ads,'Enable','on');
        set(handles.p_ads,'String',num2str(handles.pads));
        end  
   
set(handles.E_ads,'Enable','off');    
set(handles.Sy_ads,'Enable','off');

set(handles.E_e_ads,'Enable','on');
set(handles.E_m_ads,'Enable','on');
set(handles.funcdeg_ads,'Enable','on');
set(handles.No_part_ads,'Enable','on');
set(handles.radiobutton1,'Enable','on');
set(handles.radiobutton2,'Enable','on');
set(handles.helpadhesFG,'Enable','on');

 set(handles.v_ads,'String',num2str(handles.vads));
 set(handles.E_e_ads,'String',num2str(handles.Eeads));   
 set(handles.E_m_ads,'String',num2str(handles.Emads)); 
 set(handles.No_part_ads,'String',num2str(handles.nopartition));   
 set(handles.funcdeg_ads,'String',num2str(handles.funcdegree));  
 
 if handles.gradebehav==2
   set(handles.radiobutton1,'Value',1);  
 else
   set(handles.radiobutton2,'Value',1);   
 end

    end
%LC---------------------------------------------------------------------
if handles.LC==2;  
 set(handles.Load,'value',1);  
 
set(handles.U_x,'Enable','off');
set(handles.U_y,'Enable','off');
set(handles.U_z,'Enable','off'); 
set(handles.T_x,'Enable','on');
set(handles.T_y,'Enable','on');
set(handles.T_z,'Enable','on'); 
set(handles.T_x,'String',num2str(handles.Tx));
set(handles.T_z,'String',num2str(handles.Tz));
set(handles.T_y,'String',num2str(handles.Ty));
else
 set(handles.Load,'value',0);  
set(handles.U_x,'Enable','on');
set(handles.U_z,'Enable','on');
set(handles.U_y,'Enable','on');
set(handles.T_x,'Enable','off');
set(handles.T_z,'Enable','off'); 
set(handles.T_y,'Enable','off'); 
set(handles.U_x,'String',num2str(handles.Ux));
set(handles.U_z,'String',num2str(handles.Uz)); 
set(handles.U_z,'String',num2str(handles.Uy));
end

set(handles.L_1,'String',num2str(handles.L1));
set(handles.L_2,'String',num2str(handles.L2));
set(handles.L_3,'String',num2str(handles.L3));
set(handles.t_3,'String',num2str(handles.t3));

if handles.jointtype==4
set(handles.L_5,'String',num2str(handles.L5));
set(handles.L_6,'String',num2str(handles.L6));    
    
end

set(handles.w_,'String',num2str(handles.w));

if handles.ELP1~=3
set(handles.t_1,'String',num2str(handles.t1));
elseif handles.ad12==0 && handles.ELP2~=3 || handles.ad12==1 && handles.ELP1~=3
set(handles.t_2,'String',num2str(handles.t2));
end


if handles.stp==1
    
set(handles.Implicit, 'Value',1);
set(handles.step_time,'Enable','off')
set(handles.step_time,'string','')

elseif handles.stp==2
    
set(handles.Explicit, 'Value',1);
set(handles.step_time,'Enable','on')
set(handles.step_time,'string',num2str(handles.stptime))  

end


set(handles.mesh_thick,'String',num2str(handles.meshthick));
set(handles.mesh_size,'String',num2str(handles.meshsize));


if handles.nonlinmesh==1
    
    set(handles.ad_nonlin_mesh, 'value', 1);
end

guidata(hObject,handles)
    
 %#########################################################################   
 


function Run__CreateFcn(hObject, eventdata, handles)
 global hORun evRun 

    hORun=hObject;
    evRun=eventdata;
guidata(hObject,handles)  

 
function str=Run__Callback(hObject, eventdata, handles)
     global hORun evRun hObj88 eve88

if handles.ELP1==3 && ~isempty(handles.layupad1)
    
ll=handles.layupad1(:,1)
handles.Name
pp=[];
er=0;
tr=0
if  ~isempty((ll))   && length(find(ismember(ll,handles.Name)))~= length(ll);
    
   tr=1
else
   

% find(ismember(ll,handles.Name))
if  ~isempty(handles.Name) && ~isempty((ll)) %&& length(find(ismember(ll,handles.Name)))== length(ll)
for i =1:length(ll)
pp(i)= find(ismember(handles.Name,ll(i)));   
end   
for j=1:length(pp)
    
    if handles.CM(pp(j),7)==0 || isnan(handles.CM(pp(j),7)==0)
    er=1;
    end
end   
end

end   
end

tr2=0;
if handles.ELP2==3 && handles.ad12==0 && ~isempty(handles.layupad2)
    
ll2=handles.layupad2(:,1);
handles.Name;
pp2=[];
er2=0;
tr2=0
if  ~isempty((ll2))  && length(find(ismember(ll2,handles.Name)))~= length(ll2);
    
   tr2=1
else
   


if  ~isempty(handles.Name) && ~isempty((ll2))%&& length(find(ismember(ll2,handles.Name)))== length(ll2)
for i =1:length(ll2)
pp2(i)= find(ismember(handles.Name,ll2(i)));   
end   
er2=0;
for j=1:length(pp2)
    
    if handles.CM(pp2(j),7)==0 || isnan(handles.CM(pp2(j),7)==0)
    er2=1;
    end
end   
end   
 
end
end


handles.ELP2
 handles.Save_Lam2_indicator 
 handles.ad12==0
 handles.Ead2
 handles.vad2
handles.Syad2
if (handles.ELP1==1 &&( isnan(handles.Ead1)||isnan(handles.vad1)))...
        ||(handles.ELP1==2 &&( isnan(handles.Ead1)||isnan(handles.vad1)||isnan(handles.Syad1)))
    
    errordlg('Material Properties Of Adherent1 Is Incompelete!', 'Error','modal')
    
elseif (handles.ELP1==3 && handles.Save_Lam1_indicator ==0)
    
    errordlg('Please Save Lay-UP Data Adherent 1!', 'Error','modal')
    
elseif (handles.ad12==0)&&((handles.ELP2==1 &&( isnan(handles.Ead2)||isnan(handles.vad2)))...
        ||(handles.ELP2==2 &&( isnan(handles.Ead2)||isnan(handles.vad2)||isnan(handles.Syad2))))   
       
    errordlg('Material Properties Of Adherent2 Is Incompelete!', 'Error','modal')
    
elseif  (handles.ad12==0)&&(handles.ELP2==3 && handles.Save_Lam2_indicator ==0)
    
      errordlg('Please Save Lay-UP Data Adherent 2!', 'Error','modal')
      
elseif (handles.ELP==1 &&  ( isnan(handles.Eads)||isnan(handles.vads)))||...
       (handles.ELP==2 &&  ( isnan(handles.Eads)||isnan(handles.vads)|| isnan(handles.Syads)))
      
   errordlg('Material Properties Of Adhesive Is Incomplete!', 'Error','modal')
   
elseif  handles.ELP==3 && (isnan(handles.nopartition)||isnan(handles.Eeads)||isnan(handles.Emads)||isnan(handles.vads)||isnan(handles.funcdegree) ) 
   
    errordlg('Material Properties Of Adhesive Is Incomplete!', 'Error','modal')
   
   
elseif ( isnan(handles.L1)||isnan(handles.L2)||isnan(handles.L3))...
        ||isnan(handles.t3)|| isnan(handles.w)||(handles.jointtype==4&&(isnan(handles.L5)||isnan(handles.L6)));
        
    
    errordlg('Dimension Is Incompelete!', 'Error','modal')
    
elseif (isnan(handles.t1) && handles.ELP1 ~=3) ||(handles.ad12==0 && handles.ELP2~=3 &&isnan(handles.t2))...
        || (handles.ad12==1 && handles.ELP1~=3 &&isnan(handles.t2))...
     
    errordlg('Dimension Is Incompelete!', 'Error','modal')
    
elseif isnan(handles.meshsize) && isnan(handles.meshthick)
    
    errordlg('Mesh Properties Is Incomplete!', 'Error','modal')
    
elseif (handles.LC==1 && (isnan(handles.Ux)||isnan(handles.Uy)|| isnan(handles.Ux))) || ...
        (handles.LC==2 && (isnan(handles.Tx)||isnan(handles.Ty)|| isnan(handles.Tx)))
    
    errordlg('Load or Displacement Is Incomplete!', 'Error','modal')

elseif handles.stp==2 && (handles.ELP1==1 || handles.ELP1==2) && isnan(handles.pad1)...
        ||handles.stp==2 && handles.ad12==0 && (handles.ELP2==1 || handles.ELP2==2)&& isnan(handles.pad2)...
        || handles.stp==2 &&  isnan(handles.pads)...
    
    errordlg('Please Enter Densities!', 'Error','modal')
    
 elseif (handles.ELP1==3 && handles.stp==2 && er==1)||  (handles.ELP2==3 && handles.stp==2 && er2==1 && handles.ad12==0)  

     
 errordlg('Please check density of used Lamina!', 'Error','modal') 

 elseif (handles.ELP1==3 &&  tr==1)||  (handles.ELP2==3 && tr2==1 && handles.ad12==0)  

     
 errordlg('One or More Used Lamina Is Deleted, Please Modify it!', 'Error','modal') 
    
elseif handles.stp==2 && isnan(handles.stptime)
 
    errordlg('Please Enter Step-Time!', 'Error','modal')
    
elseif handles.FASSR==1 &&  handles.FAMcheck==0 && handles.FANcheck==0 && handles.FAScheck==0  
    errordlg('You should select at least on "Failure criterion"!', 'Error','modal')

elseif handles.FASSR==1 &&((handles.FAMcheck==1 && isnan(handles.alloM))...
        ||(handles.FAScheck==1 && isnan(handles.alloS))||(handles.FANcheck==1 && isnan(handles.alloN)))
    
    errordlg('Please enter  allowable stress in "Failure analysis section"!', 'Error','modal')

else

promptMessage = sprintf('Do You want to open Abaqus? NOTE:If "Yes" is selected  "GUI" IS NOT WORKING meanwhile Abaqus is open');
titleBarCaption = 'Yes or No';

if handles.rpsm_c~=1 
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No','Cancle','modal');


if strcmp(button, 'Yes')
opyn='script';
rr=1;
elseif strcmp(button, 'No')
opyn='noGUI';
rr=1;
else
rr=0;    
 
end

else
  rr=1;  
  opyn='noGUI';
end
 
    
    
jointtype=handles.jointtype; 
handles.ad12;
L1=handles.L1;
L2=handles.L2;
L3=handles.L3;
t1=handles.t1;
t2=handles.t2;
t3=handles.t3;

w=handles.w;

if handles.jointtype==4
 L4=handles.w;
 L5=handles.L5;
 L6=handles.L6;
end
 
    
    
nopart=handles.nopartition;       
                           
meshsize=handles.meshsize;
meshthic=handles.meshthick;              
stp=handles.stp;                
stptime=handles.stptime;         
ELP2=handles.ELP2;
ELP1=handles.ELP1;
Densadh1=handles.pad1;
Densadh2=handles.pad2;
Syadh1=handles.Syad1;
Eadh1=handles.Ead1;
vadh1=handles.vad1;
Syadh2=handles.Syad2;
Eadh2=handles.Ead2;
vadh2=handles.vad2;
nolayadh1=handles.nlad1;
nolayadh2=handles.nlad2;
ELP=handles.ELP;                
Syads=handles.Syads;
Eads=handles.Eads;
vads=handles.vads;
Ee=handles.Eeads;
Em=handles.Emads;
ve=handles.vads;
vm=handles.vads;
funcdeg=handles.funcdegree; 
Densads=handles.pads;
LC=handles.LC;
nonlinmesh=handles.nonlinmesh;

if handles.LC==1
Tz=0;
Tx=0;
Ty=0;
Ux=handles.Ux;
Uz=handles.Uz;
Uy=handles.Uy;
else
Tx=handles.Tx;
Tz=handles.Tz;
Ty=handles.Ty;
Ux=0;
Uz=0;
Uy=0
end



if handles.ad12==1
ELP2=ELP1;
Eadh2=Eadh1;
vadh2=vadh1;
Syadh2=Syadh1;
Densadh2=Densadh1;
handles.layupad2_final=handles.layupad1_final;
end


if ELP1==3
    t1=3;
    
end

if ELP2==3 && handles.ad12==0
    t2=3;
end

if ELP1==3 && handles.ad12==1
   
    t2=3;
end




if exist('Var.py')==2
 delete('Var.py');
end

fid = fopen('Var.py', 'w');


fprintf(fid,'jointtype = %d\n',jointtype);
fprintf(fid,'L1 = %0.12f\n',L1);
fprintf(fid,'t1 = %0.12f\n',t1);
fprintf(fid,'L2 = %0.12f\n',L2);
fprintf(fid,'t2 = %0.12f\n',t2);
fprintf(fid,'L3 = %0.12f\n',L3);
if handles.jointtype==4
fprintf(fid,'L4 = %0.12f\n',L4);
fprintf(fid,'L5 = %0.12f\n',L5); 
fprintf(fid,'L6 = %0.12f\n',L6); 
end
fprintf(fid,'t3 = %0.12f\n',t3);
fprintf(fid,'w = %0.12f\n',w);
fprintf(fid,'ELP1 = %d\n',ELP1);
fprintf(fid,'ELP2 = %d\n',ELP2);
fprintf(fid,'ELP = %d\n',ELP);
fprintf(fid,'Ux = %0.12f\n',Ux);
fprintf(fid,'Uz = %0.12f\n',Uz);
fprintf(fid,'Uy = %0.12f\n',Uy);
fprintf(fid,'Tx = %0.12f\n',Tx);
fprintf(fid,'Tz = %0.12f\n',Tz);
fprintf(fid,'Ty = %0.12f\n',Ty);
fprintf(fid,'LC = %d\n',LC);
fprintf(fid,'stp = %d\n',stp);
fprintf(fid,'meshsize = %0.12f\n',meshsize);
fprintf(fid,'meshthic = %0.12f\n',meshthic);
fprintf(fid,'nonlinmesh = %0.12f\n',nonlinmesh);
fprintf(fid,'vads = %0.12f\n',vads);


if ELP1 ~=3
fprintf(fid,'Eadh1 = %0.12f\n',Eadh1);
fprintf(fid,'vadh1 = %0.12f\n',vadh1);
end

if ELP1==2
fprintf(fid,'Syadh1 = %0.12f\n',Syadh1);
end

if ELP2 ~=3
fprintf(fid,'Eadh2 = %0.12f\n',Eadh2);
fprintf(fid,'vadh2 = %0.12f\n',vadh2);
end

if ELP2==2
fprintf(fid,'Syadh2 = %0.12f\n',Syadh2);
end

if ELP==2
fprintf(fid,'Syads = %0.12f\n',Syads);
end

if ELP ~=3
fprintf(fid,'Eads = %0.12f\n',Eads);
end

if ELP==3
fprintf(fid,'Ee = %0.12f\n',Ee);
fprintf(fid,'Em = %0.12f\n',Em);
fprintf(fid,'ve = %0.12f\n',ve);
fprintf(fid,'vm = %0.12f\n',vm);

fprintf(fid,'funcdeg = %0.12f\n',funcdeg);

end

if ELP ~=3
    nopart=1;
end

fprintf(fid,'nopart = %d\n',nopart);


if stp==2
fprintf(fid,'Densads = %0.12f\n',Densads);

end 

if stp==2 && ELP1 ~=3

fprintf(fid,'Densadh1 = %0.12f\n',Densadh1);

end 

if stp==2 && ELP2 ~=3

fprintf(fid,'Densadh2 = %0.12f\n',Densadh2);
end 



fprintf(fid,'stptime = %0.12f\n',stptime);

fprintf(fid,'nolayadh1 = %d\n',nolayadh1);
fprintf(fid,'nolayadh2 = %d\n',nolayadh2);      
[xs1 xs2]=size(handles.CM);
fprintf(fid,'Laminano = %d\n',xs1);

fprintf(fid,'Laminadata=[');
for i=1:xs1
fprintf(fid,'[');
fprintf(fid,'%f, ',handles.CM(i,:));
fprintf(fid,'],');
end
fprintf(fid,']\n');

[zs1 zs2]=size(handles.layupad1_final);
fprintf(fid,'layupdataadh1=[');
for i=1:zs1
fprintf(fid,'[');
fprintf(fid,'%f, ',handles.layupad1_final(i,:));
fprintf(fid,'],');
end
fprintf(fid,']\n');

[ts1 ts2]=size(handles.layupad2_final);
fprintf(fid,'layupdataadh2=[');
for i=1:ts1
fprintf(fid,'[');
fprintf(fid,'%f, ',handles.layupad2_final(i,:));
fprintf(fid,'],');
end
fprintf(fid,']\n');


if ELP==1|| ELP==2
gradebehav=1;
else
 gradebehav=handles.gradebehav;   
end


fprintf(fid,'gradebehav = %d\n',gradebehav);

cccc=clock;
a110=num2str(cccc(4));
a120=num2str(cccc(5));
a130=num2str(floor(cccc(6)));

if handles.jointtype==1
 imshow('Path1.bmp', 'Parent', handles.axes8);    
hhhh=strcat('SLJ-',date,'-',a110,'-',a120,'-',a130);
elseif handles.jointtype==2
hhhh=strcat('DLJ-',date,'-',a110,'-',a120,'-',a130);
elseif handles.jointtype==3
hhhh=strcat('T_Joint-',date,'-',a110,'-',a120,'-',a130);
elseif handles.jointtype==4
hhhh=strcat('Patch_Joint-',date,'-',a110,'-',a120,'-',a130);
end

a12=strcat('''',handles.pwd0,'/',hhhh,'.odb','''');
a22=a12;
a32= a12;
a42= a12;

fprintf(fid,'a12 = %s\n',a12);
fprintf(fid,'a22 = %s\n',a22);
fprintf(fid,'a32 = %s\n',a32);
fprintf(fid,'a42 = %s\n',a42);



fprintf(fid,'jobname = %s\n',strcat('''',hhhh,''''));
fclose(fid);

clr=rand(1,3);
delete('*.lck')

delete('*.ipm','*.prt','*.sim','*.ipm','*.sta','*.log','*.inp','*.com','*.dat','*.msg','*.odb','*.txt','*.odb_f')
delete('*.rpy','*.1','*.2','*.pac','*.pac','*.res','*.sel','*.stt','*.rec','*.rpy','*.log','*.loc','*.abq','*.mdl')
str={};
if handles.jointtype==1 && rr==1
system(['abaqus cae ',opyn,'=py.py']);

set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
set(handles.Res,'Value',1)
set(handles. FAPS,'Value',0) 
set(handles.inp_dat,'Value',0)

% set(handles.Modules_, 'value',2);

delete('*.ipm','*.prt','*.sim','*.ipm','*.sta','*.log','*.inp','*.com','*.dat','*.msg','*.odb_f')
delete('*.rpy','*.1','*.2','*.pac','*.pac','*.res','*.sel','*.stt','*.rec','*.rpy','*.log','*.loc','*.abq','*.mdl')


plo=importdata('MSLJ.txt');
plo1=importdata('SSLJ.txt');
plo2=importdata('NSLJ.txt');
% 
handles.Mmax=max(plo.data(:,2));
handles.Smax=max(abs(plo1.data(:,2)));
handles.Nmax=max(plo2.data(:,2));
guidata(hObject,handles) 

if  handles.rpsm_c==0 
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off
    
 plot(handles.axes3,1 ,1); 
 plot(handles.axes5,1 ,1); 
 plot(handles.axes7,1 ,1); 
 
 set(handles.axes3,'Visible','off') 
 set(handles.axes5,'Visible','off') 
 set(handles.axes7,'Visible','off') 
end

set(handles.axes2,'Visible','on') 


if handles.holdon==0 && handles.rpsm_c==0   
axes(handles.axes2);
hold off
plot(handles.axes2,1,1)
 
end


plot(handles.axes2,plo.data(:,1),plo.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1   
axes(handles.axes2);
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Misess Stress');





set(handles.axes4,'Visible','on') 
axes(handles.axes4);

if handles.holdon==0 && handles.rpsm_c==0   
axes(handles.axes4);
hold off
plot(handles.axes4,1,1)
end 

plot(handles.axes4,plo1.data(:,1),-1*plo1.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end


xlabel('Normalaized Distance in Adhesive');
ylabel('Shear Stress');
%==========================================
set(handles.axes6,'Visible','on') 
axes(handles.axes6);

if handles.holdon==0 && handles.rpsm_c==0   
axes(handles.axes6);
hold off
plot(handles.axes6,1,1)
end

plot(handles.axes6,plo2.data(:,1),plo2.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Normal Stress');

%=======================================================
if handles.rpsm_c==1   
set(handles.axes3,'Visible','on')    
axes(handles.axes3);  
plot(handles.axes3,handles.varpar,handles.Mmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Misess Stress');

set(handles.axes5,'Visible','on')    
axes(handles.axes5);  
plot(handles.axes5,handles.varpar,handles.Smax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Shear Stress');


set(handles.axes7,'Visible','on')    
axes(handles.axes7);  
plot(handles.axes7,handles.varpar,handles.Nmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Normal Stress');


end


%=================================
if  handles.FASSR==1 && handles.rpsm_c==0
FA_Run_Callback(hObj88, eve88, handles,1);
end

if (handles.FAMcheck==1 && handles.FATMcheck==1)||(handles.FAScheck==1 && handles.FATMcheck==1)...
        (handles.FANcheck==1 && handles.FATMcheck==1) && handles.fatmP==1
str=FA_Run_Callback(hObj88, eve88, handles,2);

end


%==================================


mkdir(hhhh)
movefile(strcat(hhhh,'.odb'),hhhh)
movefile('MSLJ.txt',hhhh)
movefile('SSLJ.txt',hhhh)
movefile('NSLJ.txt',hhhh)
movefile('SLJCAEfile.cae',hhhh)
movefile('SLJCAEfile.jnl',hhhh)

movefile(hhhh,'Temp')

elseif handles.jointtype==2 && rr==1
  imshow('Path2.bmp', 'Parent', handles.axes8); 
    system(['abaqus cae ',opyn,'=py.py']);
  
delete('*.ipm','*.prt','*.sim','*.ipm','*.sta','*.log','*.inp','*.com','*.dat','*.msg','*.odb_f')
delete('*.rpy','*.1','*.2','*.pac','*.pac','*.res','*.sel','*.stt','*.rec','*.rpy','*.log','*.loc','*.abq','*.mdl')
  
set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
set(handles.Res,'Value',1)
set(handles. FAPS,'Value',0) 
set(handles.inp_dat,'Value',0)

plo1=importdata('MSLJ1.txt');
plo2=importdata('MSLJ2.txt');

plo3=importdata('SSLJ1.txt');
plo4=importdata('SSLJ2.txt');

plo5=importdata('NSLJ1.txt');
plo6=importdata('NSLJ2.txt');

set(handles.axes2,'Visible','on') 


handles.Mmax1=max(plo1.data(:,2));
handles.Mmax2=max(plo2.data(:,2));
handles.Smax1=max(abs(plo3.data(:,2)));
handles.Smax2=max(abs(plo4.data(:,2)));
handles.Nmax1=max(plo5.data(:,2));
handles.Nmax2=max(plo6.data(:,2));


if  handles.rpsm_c==0 
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off
    
 plot(handles.axes3,1 ,1); 
 plot(handles.axes5,1 ,1); 
 plot(handles.axes7,1 ,1); 
 
 set(handles.axes3,'Visible','off') 
 set(handles.axes5,'Visible','off') 
 set(handles.axes7,'Visible','off') 
end

set(handles.axes2,'Visible','on') 
axes(handles.axes2);

if handles.holdon==0 && handles.rpsm_c==0   
hold off
plot(handles.axes2,1,1)
 
end

plot(handles.axes2,plo1.data(:,1),plo1.data(:,2),'Color',clr)
hold on
plot(handles.axes2,plo2.data(:,1),plo2.data(:,2),'Color',clr, 'LineStyle','--', 'LineWidth', 2)


if handles.holdon==1 || handles.rpsm_c==1   
axes(handles.axes2);
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Misess Stress');
%==================================
set(handles.axes4,'Visible','on') 
axes(handles.axes4);
if handles.holdon==0 && handles.rpsm_c==0   
hold off
plot(handles.axes4,1,1)
end


plot(handles.axes4,plo3.data(:,1),-1*plo3.data(:,2),'Color',clr)
hold on
plot(handles.axes4,plo4.data(:,1),-1*plo4.data(:,2),'Color',clr, 'LineStyle','--', 'LineWidth',2)
% plot(handles.axes5,[0:.11:1],100*ones(1,10),'Color','r')


if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Shear Stress');
%==========================================
set(handles.axes6,'Visible','on') 
axes(handles.axes6);
if handles.holdon==0 && handles.rpsm_c==0   

hold off
plot(handles.axes6,1,1)
end

plot(handles.axes6,plo5.data(:,1),plo5.data(:,2),'Color',clr)
hold on
plot(handles.axes6,plo6.data(:,1),plo6.data(:,2),'Color',clr, 'LineStyle','--', 'LineWidth', 2)


if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Normal Stress');
%=====================================================
%=======================================================
if handles.rpsm_c==1   
set(handles.axes3,'Visible','on')    
axes(handles.axes3);  
plot(handles.axes3,handles.varpar,handles.Mmax1,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
plot(handles.axes3,handles.varpar,handles.Mmax2,'Color',clr,'Marker','o','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Misess Stress');

set(handles.axes5,'Visible','on')    
axes(handles.axes5);  
plot(handles.axes5,handles.varpar,handles.Smax1,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
plot(handles.axes5,handles.varpar,handles.Smax2,'Color',clr,'Marker','o','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Shear Stress');


set(handles.axes7,'Visible','on')    
axes(handles.axes7);  
plot(handles.axes7,handles.varpar,handles.Nmax1,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
plot(handles.axes7,handles.varpar,handles.Nmax2,'Color',clr,'Marker','o','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Normal Stress');


end

%============================================================================================================
if  handles.FASSR==1 && handles.rpsm_c==0
FA_Run_Callback(hObj88, eve88, handles,1);
end

if (handles.FAMcheck==1 && handles.FATMcheck==1)||(handles.FAScheck==1 && handles.FATMcheck==1)...
        (handles.FANcheck==1 && handles.FATMcheck==1) && handles.fatmP==1
str=FA_Run_Callback(hObj88, eve88, handles,2);

end




%============================================================================================================
mkdir(hhhh)
movefile(strcat(hhhh,'.odb'),hhhh)
movefile('MSLJ1.txt',hhhh)
movefile('MSLJ2.txt',hhhh)
movefile('SSLJ1.txt',hhhh)
movefile('SSLJ2.txt',hhhh)
movefile('NSLJ1.txt',hhhh)
movefile('NSLJ2.txt',hhhh)
movefile('DLJCAEfile.cae',hhhh)
movefile('DLJCAEfile.jnl',hhhh)
movefile(hhhh,'Temp')   
%=========================================================================    
elseif handles.jointtype==3 && rr==1
    
imshow('Path3.bmp', 'Parent', handles.axes8); 
 system(['abaqus cae ',opyn,'=py.py']);

set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
set(handles.Res,'Value',1)
set(handles. FAPS,'Value',0) 
set(handles.inp_dat,'Value',0)

% set(handles.Modules_, 'value',2);

delete('*.ipm','*.prt','*.sim','*.ipm','*.sta','*.log','*.inp','*.com','*.dat','*.msg','*.odb_f')
delete('*.rpy','*.1','*.2','*.pac','*.pac','*.res','*.sel','*.stt','*.rec','*.rpy','*.log','*.loc','*.abq','*.mdl')


plo=importdata('M-TJOINT.txt');
plo1=importdata('S-TJOINT.txt');
plo2=importdata('N-TJOINT.txt');
set(handles.axes2,'Visible','on') 
axes(handles.axes2);
handles.Mmax=max(plo.data(:,2));
handles.Smax=max(abs(plo1.data(:,2)));
handles.Nmax=max(plo2.data(:,2));

if  handles.rpsm_c==0 
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off
    
 plot(handles.axes3,1 ,1); 
 plot(handles.axes5,1 ,1); 
 plot(handles.axes7,1 ,1); 
 
 set(handles.axes3,'Visible','off') 
 set(handles.axes5,'Visible','off') 
 set(handles.axes7,'Visible','off') 
end



if handles.holdon==0 && handles.rpsm_c==0   
axes(handles.axes2);
hold off
plot(handles.axes2,1,1)
end 

plot(handles.axes2,plo.data(:,1),plo.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Misess Stress');
%==================================
set(handles.axes4,'Visible','on') 
axes(handles.axes4);
if handles.holdon==0 && handles.rpsm_c==0   
hold off
plot(handles.axes4,1,1)
end 

plot(handles.axes4,plo1.data(:,1),-1*plo1.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Shear Stress');
%==========================================
set(handles.axes6,'Visible','on') 
axes(handles.axes6);
if handles.holdon==0 && handles.rpsm_c==0   

hold off
plot(handles.axes6,1,1)
end 

plot(handles.axes6,plo2.data(:,1),plo2.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Normal Stress');
%=====================================================
if handles.rpsm_c==1   
set(handles.axes3,'Visible','on')    
axes(handles.axes3);  
plot(handles.axes3,handles.varpar,handles.Mmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Misess Stress');

set(handles.axes5,'Visible','on')    
axes(handles.axes5);  
plot(handles.axes5,handles.varpar,handles.Smax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Shear Stress');


set(handles.axes7,'Visible','on')    
axes(handles.axes7);  
plot(handles.axes7,handles.varpar,handles.Nmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Normal Stress');


end
%========================================================================
if  handles.FASSR==1 && handles.rpsm_c==0
FA_Run_Callback(hObj88, eve88, handles,1);
end

if (handles.FAMcheck==1 && handles.FATMcheck==1)||(handles.FAScheck==1 && handles.FATMcheck==1)...
        (handles.FANcheck==1 && handles.FATMcheck==1) && handles.fatmP==1
str=FA_Run_Callback(hObj88, eve88, handles,2);

end
%===============================================================================


mkdir(hhhh)
movefile(strcat(hhhh,'.odb'),hhhh)
movefile('M-TJOINT.txt',hhhh)
movefile('S-TJOINT.txt',hhhh)
movefile('N-TJOINT.txt',hhhh)
movefile('T-JointCAEfile.cae',hhhh)
movefile('T-JointCAEfile.jnl',hhhh)
movefile(hhhh,'Temp')  


elseif handles.jointtype==4 && rr==1 
imshow('Path4.bmp', 'Parent', handles.axes8); 
 system(['abaqus cae ',opyn,'=py.py']);

set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
set(handles.Res,'Value',1)
set(handles. FAPS,'Value',0) 
set(handles.inp_dat,'Value',0)

% set(handles.Modules_, 'value',2);

delete('*.ipm','*.prt','*.sim','*.ipm','*.sta','*.log','*.inp','*.com','*.dat','*.msg','*.odb_f')
delete('*.rpy','*.1','*.2','*.pac','*.pac','*.res','*.sel','*.stt','*.rec','*.rpy','*.log','*.loc','*.abq','*.mdl')


plo=importdata('MPatch.txt');
plo1=importdata('SPatch.txt');
plo2=importdata('NPatch.txt');
set(handles.axes2,'Visible','on') 
axes(handles.axes2);
handles.Mmax=max(plo.data(:,2));
handles.Smax=max(abs(plo1.data(:,2)));
handles.Nmax=max(plo2.data(:,2));

if  handles.rpsm_c==0 
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off
    
 plot(handles.axes3,1 ,1); 
 plot(handles.axes5,1 ,1); 
 plot(handles.axes7,1 ,1); 
 
 set(handles.axes3,'Visible','off') 
 set(handles.axes5,'Visible','off') 
 set(handles.axes7,'Visible','off') 
end



if handles.holdon==0 && handles.rpsm_c==0   
axes(handles.axes2);
hold off
plot(handles.axes2,1,1)
end 

plot(handles.axes2,plo.data(:,1),plo.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Misess Stress');
%==================================
set(handles.axes4,'Visible','on') 
axes(handles.axes4);
if handles.holdon==0 && handles.rpsm_c==0   
hold off
plot(handles.axes4,1,1)
end 

plot(handles.axes4,plo1.data(:,1),-1*plo1.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Shear Stress');
%==========================================
set(handles.axes6,'Visible','on') 
axes(handles.axes6);
if handles.holdon==0 && handles.rpsm_c==0   

hold off
plot(handles.axes6,1,1)
end 

plot(handles.axes6,plo2.data(:,1),plo2.data(:,2),'Color',clr)

if handles.holdon==1 || handles.rpsm_c==1 
hold on
end

xlabel('Normalaized Distance in Adhesive');
ylabel('Normal Stress');
%=====================================================
if handles.rpsm_c==1   
set(handles.axes3,'Visible','on')    
axes(handles.axes3);  
plot(handles.axes3,handles.varpar,handles.Mmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Misess Stress');

set(handles.axes5,'Visible','on')    
axes(handles.axes5);  
plot(handles.axes5,handles.varpar,handles.Smax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Shear Stress');


set(handles.axes7,'Visible','on')    
axes(handles.axes7);  
plot(handles.axes7,handles.varpar,handles.Nmax,'Color',clr,'Marker','s','MarkerEdgeColor',clr,'MarkerFaceColor',clr)
hold on
xlabel(handles.lable);
ylabel(' Max Normal Stress');


end
%========================================================================
if  handles.FASSR==1 && handles.rpsm_c==0
FA_Run_Callback(hObj88, eve88, handles,1);
end

if (handles.FAMcheck==1 && handles.FATMcheck==1)||(handles.FAScheck==1 && handles.FATMcheck==1)...
        (handles.FANcheck==1 && handles.FATMcheck==1) && handles.fatmP==1
str=FA_Run_Callback(hObj88, eve88, handles,2);

end
%===============================================================================


mkdir(hhhh)
movefile(strcat(hhhh,'.odb'),hhhh)
movefile('MPatch.txt',hhhh)
movefile('NPatch.txt',hhhh)
movefile('SPatch.txt',hhhh)
movefile('PatchCAEfile.cae',hhhh)
movefile('PatchCAEfile.jnl',hhhh)
movefile(hhhh,'Temp')  
    

end




guidata(hObject,handles)
end


%Toggle button of the modules##############################################



function inp_dat_Callback(hObject, eventdata, handles)
handles.Inp_Dat=get(hObject,'Value');
set(handles.Res,'Value',0)
set(handles. FAPS,'Value',0) 
set(handles.inp_dat,'Value',1)
 set(handles.resultpanel,'visible','off');
set(handles.datainputpanel,'visible','on');
set(handles.FAPSpanel,'visible','off');
 guidata(hObject, handles)



function FAPS_Callback(hObject, eventdata, handles)
handles.Fan_Parstd=get(hObject,'Value');
set(handles.inp_dat,'Value',0)
set(handles.Res,'Value',0)
set(handles. FAPS,'Value',1) 
set(handles.resultpanel,'visible','off');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','on');
guidata(hObject, handles)


function Res_Callback(hObject, eventdata, handles)
handles.Result=get(hObject,'Value'); 
set(handles.inp_dat,'Value',0)
set(handles. FAPS,'Value',0) 
set(handles.Res,'Value',1) 
set(handles.resultpanel,'visible','on');
set(handles.datainputpanel,'visible','off');
set(handles.FAPSpanel,'visible','off');
guidata(hObject, handles) 




%Parametric study mode#########################################
function LOWLIMIT_Callback(hObject, eventdata, handles)
 handles.psm_LLIM=str2double(get(hObject,'string'));   
 guidata(hObject, handles);
 
function LOWLIMIT_CreateFcn(hObject, eventdata, handles)
%----------------------------------
function TOPLIMIT_Callback(hObject, eventdata, handles)
 handles.psm_TLIM=str2double(get(hObject,'string'));   
 guidata(hObject, handles);
 
function TOPLIMIT_CreateFcn(hObject, eventdata, handles)
%----------------------------------
function INTERV_Callback(hObject, eventdata, handles)
 handles.psm_INTRV=str2double(get(hObject,'string'));    
 guidata(hObject, handles);  
 
function INTERV_CreateFcn(hObject, eventdata, handles)
%----------------------------------
function uipanel39_SelectionChangeFcn(hObject, eventdata, handles)
handles.psm_var=get(hObject,'String');  
handles.psm_var
if strcmp(handles.psm_var,'E')==1
    handles.psm_Var=1; 
    handles.lable='E_A_d_h_e_s_i_v_e';
    
elseif strcmp(handles.psm_var,'Sy')==1
    handles.psm_Var=2; 
    handles.lable='Sy_A_d_h_e_s_i_v_e';
    
elseif strcmp(handles.psm_var,'L3')==1
    handles.psm_Var=3;
    handles.lable='L_A_d_h_e_s_i_v_e';
    
elseif strcmp(handles.psm_var,'w')==1
    handles.psm_Var=4;
    handles.lable='w_A_d_h_e_s_i_v_e';
    
elseif strcmp(handles.psm_var,'t3')==1
    handles.psm_Var=5;
    handles.lable='t_A_d_h_e_s_i_v_e';
    
end

handles.psm_Var;
handles.rpsm_c;

guidata(hObject, handles);  
    
function Runpsm1_Callback(hObject, eventdata, handles)
global hORun evRun
if handles. jointtype==4
errordlg('Parametric Study is not available for Patch-Joint!')
elseif   isnan(handles.psm_LLIM)|| isnan(handles.psm_TLIM)||isnan( handles.psm_INTRV)
errordlg('Please enter all fields of "Parametric Study Mode"', 'Error','modal')  
 elseif handles.ELP==3 &&  (handles.psm_Var==1  ||  handles.psm_Var==2)
errordlg('This Parameters is not available for FG adhesive','modal') 

else
%------------------------------------
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off  
plot(handles.axes3,1 ,1); 
plot(handles.axes5,1 ,1); 
plot(handles.axes7,1 ,1); 
axes(handles.axes2);
hold off
plot(handles.axes2,1,1) 
axes(handles.axes4);
hold off
plot(handles.axes4,1,1)   
axes(handles.axes6);
hold off
plot(handles.axes6,1,1)
%------------------------------------     
handles.rpsm_c=1;
vvv=[];

handles.X1=handles.L3;
handles.X2=handles.t3;
handles.X3=handles.w;
handles.X4=handles.Syads;
handles.X5=handles.Eads;

if handles.psm_INTRV==1

      vvv=(handles.psm_TLIM-handles.psm_LLIM)/2;

elseif handles.psm_INTRV==2
       
    vvv(1)=handles.psm_LLIM;
    vvv(2)=handles.psm_TLIM;

elseif handles.psm_INTRV>2
    
    it_num=handles.psm_INTRV;
    stp=(handles.psm_TLIM-handles.psm_LLIM)/(it_num-1);
      
    for i=1:it_num
         vvv(i)=handles.psm_LLIM+ stp*(i-1);
    end
    
    
end    
 
for i=1:length(vvv)

if handles.psm_Var==1
 
    handles.Eads=vvv(i)
 
elseif handles.psm_Var==2 

    handles.Syds=vvv(i)

elseif handles.psm_Var==3     
    
    handles.L3=vvv(i)
    
elseif handles.psm_Var==4     
  
    handles.w=vvv(i)  

elseif handles.psm_Var==5     
 
    handles.t3=vvv(i)   

end

handles.varpar=vvv(i);

Run__Callback(hORun, evRun, handles) ;

end

handles.L3=handles.X1;
handles.t3=handles.X2;
handles.w=handles.X3;
handles.Syads=handles.X4;
handles.Eads=handles.X5;
end
handles.rpsm_c=0;
guidata(hObject, handles);
 
%--------------------------------------------------------------------------
  
     
% %###########################################################################
%Temperature and Moistute effect
function T_M_LOW_Callback(hObject, eventdata, handles)
 handles.tm_low=str2double(get(hObject,'string'));    
 guidata(hObject, handles);  
function T_M_LOW_CreateFcn(hObject, eventdata, handles)
    
 %--------------   
function T_M_H_Callback(hObject, eventdata, handles)
 handles.tm_high=str2double(get(hObject,'string'));    
 guidata(hObject, handles);
function T_M_H_CreateFcn(hObject, eventdata, handles)

%---------------

function T_M_INT_Callback(hObject, eventdata, handles)
 handles.tm_int=str2double(get(hObject,'string'));    
 guidata(hObject, handles);
function T_M_INT_CreateFcn(hObject, eventdata, handles)
    
%--------------
function T_M_a_Callback(hObject, eventdata, handles)
 handles.tm_a=str2double(get(hObject,'string'));    
 guidata(hObject, handles);
function T_M_a_CreateFcn(hObject, eventdata, handles)
%---------------------
    
    
function T_M_check_Callback(hObject, eventdata, handles)  
 handles.tm_check=get(hObject,'value') ; 
 
 if handles.tm_check==1
    set(handles.T_M_E,'Enable','on')
    set(handles.b_T_or_M,'Enable','off')
    set(handles.T_M_a,'Enable','off')
    
 else
    set(handles.T_M_E,'Enable','off') 
    set(handles.b_T_or_M,'Enable','on')
    set(handles.T_M_a,'Enable','on')
 end
  guidata(hObject, handles);
  
%--------------------------  
function T_M_E_Callback(hObject, eventdata, handles)

str=get(hObject,'string') ;

handles.TM_f1 = str2func(['@(X)' str]);
    handles.TM_f1(3)
guidata(hObject, handles);
function T_M_E_CreateFcn(hObject, eventdata, handles)

%------------------------------------------------------

function T_M_run_Callback(hObject, eventdata, handles) 
    handles.FAMcheck
    handles.FAScheck
    handles.FANcheck
 
global hORun evRun
 if  handles.ELP ~=1
   errordlg('"Temperature and Moisture Effect" is just available for "Elastic" adhesive', 'Error','modal')  
 elseif isnan(handles.tm_low)|| isnan(handles.tm_high) || isnan(handles.tm_int)|| (isnan(handles.tm_a) && (isnan(handles.tm_b))&&  handles.tm_check==0) || (isempty(handles.TM_f1 ) &&   handles.tm_check==1 )
          errordlg('Please enter all fields of "Temperature and Moistire Effect"', 'Error','modal')  
elseif handles.tm_check==1 &&    isempty(handles.TM_f1)  
  
    errordlg('Please enter function of E(X), eg: X^2', 'Error','modal')
 elseif  handles.FATMcheck==1 && handles.FAMcheck==0 && handles.FAScheck==0 && handles.FANcheck==0   
     
     errordlg('Please select at least one filure criterion', 'Error','modal') 
     
     
 elseif (handles.FATMcheck==1 && handles.FAMcheck==1) && ((handles.FATMcheckM==1 && isempty(handles.FAMFunc1))||...
         (handles.FATMcheckM==0 && (isnan(handles.FAMS0)||isnan(handles.FAaM))))

     errordlg('Please fill all "Mises stress" criterion field', 'Error','modal')    
    
 elseif (handles.FATMcheck==1 && handles.FAScheck==1) && ((handles.FATMcheckS==1 && isempty(handles.FASFunc1))||...
         (handles.FATMcheckS==0 && (isnan(handles.FASS0)||isnan(handles.FAaS))))
        
     errordlg('Please fill all "Shear stress" criterion field', 'Error','modal')    
     

  elseif (handles.FATMcheck==1 && handles.FANcheck==1) &&  ((handles.FATMcheckN==1 && isempty(handles.FANFunc1))||...
         (handles.FATMcheckN==0 && (isnan(handles.FANS0)||isnan(handles.FAaN))))
     
     errordlg('Please fill all "Normal stress" criterion field', 'Error','modal')    
else
 %-------------------------------------------- 


 %------------------------------------
axes(handles.axes3);
hold off
axes(handles.axes5);
hold off
axes(handles.axes7);
hold off  
plot(handles.axes3,1 ,1); 
plot(handles.axes5,1 ,1); 
plot(handles.axes7,1 ,1); 
axes(handles.axes2);
hold off
plot(handles.axes2,1,1) 
axes(handles.axes4);
hold off
plot(handles.axes4,1,1)   
axes(handles.axes6);
hold off
plot(handles.axes6,1,1)
%------------------------------------ 
   handles.str={};
   
if handles.tm_check==1
    handles.TM_f=handles.TM_f1;
 else
   handles.TM_f=@(X)handles.tm_b*handles.Eads*exp( handles.tm_a*(X-handles.tm_low)/(handles.tm_high-handles.tm_low));
end


handles.rpsm_c=1;
vvv=[];
handles.X5=handles.Eads;

if handles.tm_int==1

      vvv=(handles.tm_high-handles.tm_low)/2;

elseif handles.tm_int==2
       
    vvv(1)=handles.tm_low;
    vvv(2)=handles.tm_high;

elseif handles.tm_int>2
    
    it_num=handles.tm_int;
    stp=(handles.tm_high-handles.tm_low)/(it_num-1);
      
    for i=1:it_num
         vvv(i)=handles.tm_low+ stp*(i-1);
    end
end    
%--------------------------------------------- 
for i=1:length(vvv)
E(i)=handles.TM_f(vvv(i));
end
handles.TM_f;
data=[vvv; E]';

f = figure;
set(f,'name','E(X)','numbertitle','off')
hAx1 = axes
set(f,'Position',[200 200 500 400],'Color', [.94 .94 .94])
g=handles.TM_f;
set(gca,'unit','normalized','Position',[.2 .47 .6 .5])
fplot(hAx1,g,[handles.tm_low,handles.tm_high])
t = uitable(f,'Data',data,'ColumnName',{'X', 'E(X)'},'unit','normalized','Position',[.25 .05 .405 .2]);
HhT1=uicontrol('Style', 'text', 'unit','normalized','Position', [.45, .37, .06,.05],'string','X');
HhT2=uicontrol('Style', 'text', 'unit','normalized','Position', [.05, .67, .06,.05],'string','E(X)');
HhT3=uicontrol('Style', 'text', 'unit','normalized','Position', [.25, .27, .4,.05],'string','Evaluating E in intervals');

%----------------------------------------------------------------------------------------------------------------------
STR={};
for i=1:length(vvv)
handles.ITTN=i;
handles.Eads=handles.TM_f(vvv(i));
 
handles.varpar=vvv(i);
handles.lable='X';
handles.fatmP=1;
STR1=STR;
STR=Run__Callback(hORun, evRun, handles);

if handles.FATMcheck==1
STR={STR{:},STR1{:}};
if handles.ITTN==1
handles.f = figure;
set(handles.f,'name','Faiure Assessment','numbertitle','off')
set(handles.f,'Position',[200 200 790 200],'Color', [1 1 1])
end
 gg = uicontrol(handles.f,'Style','listbox','string', STR, 'Units','normalized',  'Position',[0 0 1 1], 'FontSize',9);
set(gg,'BackgroundColor',[1 1 1]) 
end
guidata(hObject, handles);
end

handles.fatmP=0;
handles.Eads=handles.X5;
handles.rpsm_c=0;
guidata(hObject, handles);
 
 end

%##############################################################
%Failure Analysis
function FA_M_check_Callback(hObject, eventdata, handles)
 handles.FAMcheck=get(hObject,'value');
 guidata(hObject,handles)
FA_update(handles)  ;
%----------------------------------------------------------------------
function allo_M_CreateFcn(hObject, eventdata, handles)    

function allo_M_Callback(hObject, eventdata, handles)

handles.alloM=str2double(get(hObject,'String'));
guidata(hObject,handles)
%--------------------------------------------------------------------    
function FA_N_check_Callback(hObject, eventdata, handles)
 handles.FANcheck=get(hObject,'value');
 guidata(hObject,handles)    
 FA_update(handles)   
%-------------------------------------------------------------------        
function allo_N_CreateFcn(hObject, eventdata, handles)    

function allo_N_Callback(hObject, eventdata, handles)

handles.alloN=str2double(get(hObject,'String'));
guidata(hObject,handles)    
%-------------------------------------------------------------

function FA_S_check_Callback(hObject, eventdata, handles)
 handles.FAScheck=get(hObject,'value');
 guidata(hObject,handles)    
 FA_update(handles)          
%--------------------------------------------------------------------    
function allo_S_CreateFcn(hObject, eventdata, handles)

function allo_S_Callback(hObject, eventdata, handles)    
 
handles.alloS=str2double(get(hObject,'String'));
guidata(hObject,handles)   


%-------------------------------------------------------------------
function FA_update(handles) 
 
 if handles.FAMcheck==1
     if handles.FATMcheck==1
     set(handles.FA_TM_check_M,'Enable','on') 
    
     if handles.FATMcheckM==0
     set(handles.FA_a_M,'Enable','on')
     set(handles.FA_MS0,'Enable','on')    
     set(handles.FA_MSX,'Enable','off')
     else
     set(handles.FA_a_M,'Enable','off')
     set(handles.FA_MS0,'Enable','off')    
     set(handles.FA_MSX,'Enable','on')
     end
     
     set(handles.allo_M,'Enable','off')
     
     else handles.FATMcheck==0
    
     set(handles.allo_M,'Enable','on')
     set(handles.FA_a_M,'Enable','off')
     set(handles.FA_MS0,'Enable','off')    
     set(handles.FA_TM_check_M,'Enable','off')
     set(handles.FA_MSX,'Enable','off')
     end
     
 else
     set(handles.allo_M,'Enable','off')
     set(handles.FA_a_M,'Enable','off')
     set(handles.FA_MS0,'Enable','off')
     set(handles.FA_TM_check_M,'Enable','off')
     set(handles.FA_MSX,'Enable','off')
 end
 
%------------------------------------------------------------------------   
 if handles.FAScheck==1
     if handles.FATMcheck==1
     set(handles.FA_TM_check_S,'Enable','on') 
     
     if handles.FATMcheckS==0
     set(handles.FA_a_S,'Enable','on')
     set(handles.FA_SS0,'Enable','on')    
     set(handles.FA_SSX,'Enable','off')
     else
     set(handles.FA_a_S,'Enable','off')
     set(handles.FA_SS0,'Enable','off')    
     set(handles.FA_SSX,'Enable','on')
     end
     
     set(handles.allo_S,'Enable','off')
     
     else handles.FATMcheck==0
    
     set(handles.allo_S,'Enable','on')
     set(handles.FA_a_S,'Enable','off')
     set(handles.FA_SS0,'Enable','off')    
     set(handles.FA_TM_check_S,'Enable','off')
     set(handles.FA_SSX,'Enable','off')
     end
     
 else
     set(handles.allo_S,'Enable','off')
     set(handles.FA_a_S,'Enable','off')
     set(handles.FA_SS0,'Enable','off')
     set(handles.FA_TM_check_S,'Enable','off')
     set(handles.FA_SSX,'Enable','off')
 end
 %--------------------------------------------------------
  if handles.FANcheck==1
     if handles.FATMcheck==1
     set(handles.FA_TM_check_N,'Enable','on') 
     
     if handles.FATMcheckN==0
     set(handles.FA_a_N,'Enable','on')
     set(handles.FA_NS0,'Enable','on')    
     set(handles.FA_NSX,'Enable','off')
     else
     set(handles.FA_a_N,'Enable','off')
     set(handles.FA_NS0,'Enable','off')    
     set(handles.FA_NSX,'Enable','on')
     end
     
     set(handles.allo_N,'Enable','off')
     
     else handles.FATMcheck==0
    
     set(handles.allo_N,'Enable','on')
     set(handles.FA_a_N,'Enable','off')
     set(handles.FA_NS0,'Enable','off')    
     set(handles.FA_TM_check_N,'Enable','off')
     set(handles.FA_NSX,'Enable','off')
     end
     
 else
     set(handles.allo_N,'Enable','off')
     set(handles.FA_a_N,'Enable','off')
     set(handles.FA_NS0,'Enable','off')
     set(handles.FA_TM_check_N,'Enable','off')
     set(handles.FA_NSX,'Enable','off')
  end
 %------------------------------------------------------------------------   
function FA_TM_check_M_Callback(hObject, eventdata, handles)
 handles.FATMcheckM=get(hObject,'value');
 guidata(hObject,handles)    
 FA_update(handles)      
%--------------------------------------------------------------------------    
function FA_a_M_CreateFcn(hObject, eventdata, handles)  

function FA_a_M_Callback(hObject, eventdata, handles) 
handles.FAaM=str2double(get(hObject,'String'));
guidata(hObject,handles)   
%--------------------------------------------------------------------------    
function FA_MS0_CreateFcn(hObject, eventdata, handles)
    
function FA_MS0_Callback(hObject, eventdata, handles)
 handles.FAMS0=str2double(get(hObject,'String'));
guidata(hObject,handles)      
%--------------------------------------------------------------------------
function FA_MSX_CreateFcn(hObject, eventdata, handles)
    
function FA_MSX_Callback(hObject, eventdata, handles)  
 str=get(hObject,'String');
 handles.FAMFunc1 = str2func(['@(X)' str]);
 guidata(hObject,handles) 

     
%-------------------------------------------------------------------------
function FA_TM_check_S_Callback(hObject, eventdata, handles) 
 handles.FATMcheckS=get(hObject,'value');
 guidata(hObject,handles)    
 FA_update(handles)              
%-----------------------------------------------------------------------    
function FA_a_S_CreateFcn(hObject, eventdata, handles)
function FA_a_S_Callback(hObject, eventdata, handles)
handles.FAaS=str2double(get(hObject,'String'));
guidata(hObject,handles)      
%------------------------------------------------------------------------    
function FA_SS0_CreateFcn(hObject, eventdata, handles)
function FA_SS0_Callback(hObject, eventdata, handles)
handles.FASS0=str2double(get(hObject,'String'));
guidata(hObject,handles)     
%-------------------------------------------------------------------------    
function FA_SSX_CreateFcn(hObject, eventdata, handles)          
function FA_SSX_Callback(hObject, eventdata, handles)   
str=get(hObject,'String');
handles.FASFunc1 = str2func(['@(X)' str]);
guidata(hObject,handles)  
%------------------------------------------------------------------------
function FA_TM_check_N_Callback(hObject, eventdata, handles)   
 handles.FATMcheckN=get(hObject,'value');
 guidata(hObject,handles)    
 FA_update(handles)      
%--------------------------------------------------------------------------       
    
function FA_a_N_CreateFcn(hObject, eventdata, handles)
function FA_a_N_Callback(hObject, eventdata, handles)
handles.FAaN=str2double(get(hObject,'String'));
guidata(hObject,handles)  
%--------------------------------------------------------------------------    
function FA_NS0_CreateFcn(hObject, eventdata, handles)   
function FA_NS0_Callback(hObject, eventdata, handles)
handles.FANS0=str2double(get(hObject,'String'));
guidata(hObject,handles)  
%--------------------------------------------------------------------------
function FA_NSX_CreateFcn(hObject, eventdata, handles)    
function FA_NSX_Callback(hObject, eventdata, handles)
str=get(hObject,'String');
handles.FANFunc1 = str2func(['@(X)' str]);
guidata(hObject,handles) 
%--------------------------------------------------------------------------        





function FASS_R_Callback(hObject, eventdata, handles)
 handles.FASSR=get(hObject,'value');
  if handles.FASSR==1
      set(handles.FA_TM_check, 'Value',0)
      handles.FATMcheck=0;
  end
 FA_update(handles)

 guidata(hObject,handles) 
 
 %------------------------------------------------------------------   
function FA_TM_check_Callback(hObject, eventdata, handles)
handles.FATMcheck=get(hObject,'value');
 

  if handles.FASSR==1
      set(handles.FASS_R, 'Value',0)
      handles.FASSR=0;
  end


FA_update(handles)
guidata(hObject,handles)      

 
% function FASS_TMR_Callback(hObject, eventdata, handles)
%  handles.FASSTMR=get(hObject,'value');
%  
%    if handles.FASSR==1
%       set(handles.FASS_R, 'Value',0)
%   end
%  
%  FA_update(handles)
% 
%  guidata(hObject,handles)       
    
%--------------------------------------------------------------------------

    
%---------------------------------------------------------------------------
function FA_Run_CreateFcn(hObject, eventdata, handles)
global hObj88 eve88
hObj88=hObject;
eve88=eventdata;
guidata(hObject, handles)

function STR=FA_Run_Callback(hObject, eventdata, handles, fat)
global hObj88 eve88

if  fat==1
    handles.str={};
end

if  fat==2
    
 if handles.FAMcheck==1   
 if    handles.FATMcheckM==0
   handles.FAMFunc=@(X)handles.FAMS0*exp( handles.FAaM*(X-handles.tm_low)/(handles.tm_high-handles.tm_low));  
 else 
   handles.FAMFunc=handles.FAMFunc1;
 end 
 end

 if handles.FAScheck==1   
 if    handles.FATMcheckS==0
   handles.FASFunc=@(X)handles.FASS0*exp( handles.FAaS*(X-handles.tm_low)/(handles.tm_high-handles.tm_low));  
 else 
   handles.FASFunc=handles.FASFunc1;
 end 
 end 
 
  if handles.FANcheck==1   
 if    handles.FATMcheckN==0
   handles.FANFunc=@(X)handles.FANS0*exp( handles.FAaN*(X-handles.tm_low)/(handles.tm_high-handles.tm_low));  
 else 
   handles.FANFunc=handles.FANFunc1;
 end 
 end
 
    
end


if handles.jointtype~=2

                if handles.FAMcheck==1
                if fat==1; allM=handles.alloM; else ; allM= handles.FAMFunc(handles.varpar); end

                if handles.Mmax/allM >1;  FAM='Failed'; else; FAM= 'NotFailed'; end
                else 
                allM=0;    FAM= 'NA';
                end

                 if handles.FAScheck==1
                  if fat==1;allS=handles.alloS;; else ; allS= handles.FASFunc(handles.varpar); end
                  if handles.Smax/allS >1;  FAS='Failed'; else; FAS= 'NotFailed'; end
                else 
                allS=0;    FAS= 'NA';
                 end  

                if handles.FANcheck==1
                if fat==1;  allN=handles.alloN; else ; allN= handles.FANFunc(handles.varpar); end
                if handles.Nmax/allN >1;  FAN='Failed'; else; FAN= 'NotFailed'; end
                else 
                allN=0;    FAN= 'NA';
                end

            SP={'                            '} ;
            SP1={'          '};
            SP2={'Criterion                                    '};
            a1 =strcat(SP2,'Maximum Value',SP1,'Allowable Value',SP1,'Failure Assessment');
 
            a2=strcat('Misess Stress',SP,num2str((handles.Mmax)),SP,num2str((allM)),SP,FAM);
            a3=strcat('Shear   Stress' ,SP,num2str((handles.Smax)),SP,num2str((allS)),SP,FAS);
            a4=strcat('Normal Stress',SP,num2str((handles.Nmax)),SP,num2str((allN)),SP,FAN);

            str={a1{:},a2{:},a3{:},a4{:}} ;

else

        if handles.FAMcheck==1
       if fat==1; allM=handles.alloM; else ; allM= handles.FAMFunc(handles.varpar); end 
       if handles.Mmax1/allM >1;  FAM1='Failed'; else; FAM1= 'NotFailed'; end
       if handles.Mmax2/allM >1;  FAM2='Failed'; else; FAM2= 'NotFailed'; end
        else 
        allM=0;    FAM1= 'NA'; FAM2= 'NA';
        end

         if handles.FAScheck==1
         if fat==1;allS=handles.alloS;; else ; allS= handles.FASFunc(handles.varpar); end
         if handles.Smax1/allS >1;  FAS1='Failed'; else; FAS1= 'NotFailed'; end
         if handles.Smax2/allS >1;  FAS2='Failed'; else; FAS2= 'NotFailed'; end 
        else 
        allS=0;    FAS1= 'NA'; FAS2= 'NA';
         end  

        if handles.FANcheck==1
        if fat==1;  allN=handles.alloN; else ; allN= handles.FANFunc(handles.varpar); end
        if handles.Nmax1/allN >1;  FAN1='Failed'; else; FAN1= 'NotFailed'; end
        if handles.Nmax2/allN >1;  FAN2='Failed'; else; FAN2= 'NotFailed'; end
        else 
        allN=0;    FAN1= 'NA'; FAN2= 'NA';
        end

        SP={'                            '} ;
        SP1={'          '} ;
        SP2={'Criterion                                    '};
        a1 =strcat(SP2,'Maximum Value',SP1,'Allowable Value',SP1,'Failure Assessment');
   
        a2=strcat('Misess Stress Ad1',SP,num2str(handles.Mmax1),SP,num2str(allM),SP,FAM1);
        a3=strcat('Misess Stress Ad2',SP,num2str(handles.Mmax2),SP,num2str(allM),SP,FAM2);
        a4=strcat('Shear   Stress Ad1' ,SP,num2str(handles.Smax1),SP,num2str(allS,4),SP,FAS1);
        a5=strcat('Shear   Stress Ad2' ,SP,num2str(handles.Smax2),SP,num2str(allS),SP,FAS2);
        a6=strcat('Normal Stress Ad1',SP,num2str(handles.Nmax1),SP,num2str(allN),SP,FAN1);
        a7=strcat('Normal Stress Ad2',SP,num2str(handles.Nmax2),SP,num2str(allN),SP,FAN2);
        
        str={a1{:},a2{:},a3{:},a4{:},a5{:},a6{:},a7{:}} ;

end

if fat==1
    
handles.f = figure;
set(handles.f,'name','Faiure Assessment','numbertitle','off')
set(handles.f,'Position',[200 200 790 200],'Color', [1 1 1])
handles.str=str;
gg = uicontrol(handles.f,'Style','listbox','string', handles.str, 'Units','normalized',  'Position',[0 0 1 1], 'FontSize',9)
set(gg,'BackgroundColor',[1 1 1]) 
else fat==2
XX=strcat({'                                                                                    '},'X=',  num2str(handles.varpar) );
str1={XX{:}, str{:}};
handles.str={handles.str{:},str1{:}};
 handles.str;

end
STR=handles.str;
% 
% 
% 
% guidata(hObject,handles)

%---------------------------------------------------------------------
function b_T_or_M_CreateFcn(hObject, eventdata, handles)
function b_T_or_M_Callback(hObject, eventdata, handles)
 handles.tm_b=str2double(get(hObject,'string'));    
 guidata(hObject, handles);
 



function T_or_M_SelectionChangeFcn(hObject, eventdata, handles)
a=get(hObject,'String');  

 if strcmp(a,'Temperature')==1
   handles.TorM=1;
 else
   handles.TorM=2;
 end

 if  handles.TorM==1
set(handles.text140,'visible','on');
set(handles.text141,'visible','on');
set(handles.text142,'visible','on');
% set(handles.text137,'visible','on');
set(handles.text145,'visible','on');
set(handles.text149,'visible','on');
set(handles.text150,'visible','on');
set(handles.text146,'visible','on');
set(handles.text147,'visible','on');
set(handles.text148,'visible','on');
set(handles.text143,'visible','on');

set(handles.text79,'visible','off'); 
set(handles.text80,'visible','off'); 
set(handles.text82,'visible','off'); 
set(handles.text89,'visible','off'); 
set(handles.text124,'visible','off'); 
set(handles.text131,'visible','off'); 
set(handles.text91,'visible','off'); 
set(handles.text131,'visible','off'); 
set(handles.text133,'visible','off');
set(handles.text84,'visible','off');
set(handles.text126,'visible','off');
 else
set(handles.text140,'visible','off');
set(handles.text141,'visible','off');
set(handles.text142,'visible','off');
set(handles.text137,'visible','off');
set(handles.text145,'visible','off');
set(handles.text149,'visible','off');
set(handles.text150,'visible','off');
set(handles.text146,'visible','off');
set(handles.text147,'visible','off');
set(handles.text148,'visible','off');

set(handles.text84,'visible','on');
set(handles.text126,'visible','on');
set(handles.text79,'visible','on'); 
set(handles.text80,'visible','on'); 
set(handles.text82,'visible','on'); 
set(handles.text89,'visible','on'); 
set(handles.text124,'visible','on'); 
set(handles.text131,'visible','on'); 
set(handles.text91,'visible','on'); 
set(handles.text131,'visible','on'); 
set(handles.text133,'visible','on'); 
set(handles.text143,'visible','off'); 
 
 end
 
 
guidata(hObject,handles)


    
    
    
