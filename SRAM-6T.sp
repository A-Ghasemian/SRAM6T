********************************************************************
.TITLE '6T-Sram'
***************************************************
*For optimal accuracy, convergence, and runtime
***************************************************
.options list node post
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-15 
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13
.param   TEMP=27
***************************************************
*Include relevant model files
***************************************************
.lib 'CNFET.lib' CNFET

***************************************************
*Beginning of circuit and device definitions
***************************************************
*Some CNFET parameters:
.param Vd=0.9
.param Ccsd=0      CoupleRatio=0
.param m_cnt=1     Efo=0.6     
.param Wg=0        Cb=40e-12
.param Lg=32e-9    Lgef=100e-9
.param Vfn=0       Vfp=0
.param m=31        n=0        
.param Hox=4e-9    Kox=16 

***********************************************************************
* Define power supply
***********************************************************************
Vdd      dp1     Gnd     Vd
VBL      BL      Gnd     PULSE( Vd 0 0 0 0 .01m .02m )
VWL      WL      Gnd     PULSE( Vd 0 0 0 0 .01m .02m )
***********************************************************************
* Main Circuits
***********************************************************************

*AL
XCNT3  NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*AR
XCNT4 BbL WL qb WL NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*Nr
XCNT5 qb q Gnd q NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*MN4
XCNT6 BL WL q WL PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*MN0
XCNT7 Vdd qb q qb NCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbn='Vfn' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*MN2
XCNT8 q qb Gnd Gnd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*MN3
XCNT9  PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

*MN5
XCNT5 TR  q Vdd Vdd PCNFET Lch=Lg  Lgeff='Lgef' Lss=32e-9  Ldd=32e-9  
+ Kgate='Kox' Tox='Hox' Csub='Cb' Vfbp='Vfp' Dout=0  Sout=0  Pitch=20e-9  n1=m  n2=n  tubes=3

***********************************************************************
* Measurements
***********************************************************************
*.plot WL  q BL
.tran .01u 0.06m
.print tran  V(q) V(BL)

***********************************************************************
.end 