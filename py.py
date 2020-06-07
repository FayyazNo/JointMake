
#SLJ Composite adherent and Functionally Graded (FG) adhesive
# This Code is Written By Fayyaz Nosouhi
# Tehran University February 2017
from abaqus import *
from abaqusConstants import *
import __main__
import section
import regionToolset
import displayGroupMdbToolset as dgm
import part
import material
import assembly
import step
import interaction
import load
import mesh
import optimization
import job
import sketch
import visualization
import xyPlot
import displayGroupOdbToolset as dgo


###Input===================================
###=Dimension==============================
##L1=100
##L2=100
##L3=25
##
##t1=4
##t2=4
##t3=1
##w=25                  
##nopart=50           # Number of partion=(Number of section )
##gradebehav=1        # if gradebehav=1 No grading in adhesive, gradebehav=2 grading in X direction (Length)
##                      # gradebehav=3 grading in Z direction(thickness)
##
##meshsize=.5
##meshthic=.1
##
##QT=1                  # QT=1 Quadratic Mesh QT=2 Triangular Mesh
###Step and Load========================================================
##stp=1                 # stp==1 Static and stp==2 Explicit
##stptime=1
##LC=2                  # LC==1 displacement  or  LC==2 Load
##Ux=1
##Uz=0
##Tx=2500/25
##Tz=0
###Adherent Materials Properties======================================================
##adherent12=1          # adherent12==1 No diffrent in Materials adherent12==2 diffrent in Materials 
##ELP1=2               # For adherent1: ELP1==1 Elastic and ELP1==2 ElastoPlastic and ELP1==3 Composite
##ELP2=2                # For adherent1: ELP2==1 Elastic and ELP2==2 ElastoPlastic and ELP2==3 Composite
##Densadh1=7800/10e9
##Densadh2=7800/10e9
##Syadh1=100
##Eadh1=70e3
##vadh1=.3
##Syadh2=100
##Eadh2=70e3
##vadh2=.3
##nolayadh1=8
##nolayadh2=8
##Laminano=3
##Laminadata=[[36.8e3, 8.27e3, .26, 4.14e3, 4.16e3, 4.14e3, 7800e-9], [25e3, 22e3, .33, 12e3, 15e3, 13e3, 7800e-9], [15e3, 15e3, .33, 17e3, 15e3, 12e3, 7800e-9]]
##layupdataadh1=[[1, .5, 0], [1, .5, 90], [1, .5, 45],[1, .5, -45],[1, .5, -45],[1, .5, 45],[1, .5, 90],[1, .5, 0],]
##layupdataadh2=[[1, .5, 0], [1, .5, 90], [1, .5, 45],[1, .5, -45],[1, .5, -45],[1, .5, 45],[1, .5, 90],[1, .5, 0],]
###=Adhesive Materials Properties==========================================
##ELP=2                 # ELP==1 Elastic and ELP==2 ElastoPlastic
##Densads=300/10e9
##Syads=20
##Eads=2e3
##vads=.4
##Ee=2e3
##Em=4e3
##ve=.4
##vm=.4
##funcdeg=2           # degree of the function that describe grading behavior of the adhesive and it could be
                    # funncdeg<0, funcdeg=1, funcdeg=2,4,6,...
#=========================================================
###Load Variables Which are Captured by Matlab GUI and Are Written To "Var.py" File
execfile('Var.py')

meshlength=meshsize/4.

                    
if (gradebehav ==2):
    prm=L3
elif (gradebehav ==3):
    prm=t3


def funcE(x,n):
    if n==1:
        if x<=prm/2.:
           funcE=((Em-Ee)*2./prm)*x+Ee
        elif x>prm/2.:
            funcE=((Ee-Em)*2./prm)*x+2.*Em-Ee
    elif n!=1:
        if x>=prm/2.:
         funcE=((Ee-Em)*(2./prm)**n)*(x-prm/2.)**n+Em
        elif x<=prm/2.:
           funcE=((Ee-Em)*(2./prm)**n)*(-x+prm/2.)**n+Em
    return funcE



def funcv(x,n):
    if n==1:
        if x<=prm/2.:
           funcv=((vm-ve)*2./prm)*x+ve
        elif x>prm/2.:
            funcv=((ve-vm)*2./prm)*x+2.*vm-ve
    elif n!=1:
        if x>=prm/2.:
         funcv=((ve-vm)*(2./prm)**n)*(x-prm/2.)**n+vm
        elif x<=prm/2.:
           funcv=((ve-vm)*(2./prm)**n)*(-x+prm/2.)**n+vm
    return funcv







if jointtype==1:

#=========================================================

    #adherent1
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(0.0, 0.0), point2=(L1, w))
    p = mdb.models['Model-1'].Part(name='Part-1', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-1']
    p.BaseShell(sketch=s)
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-1']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']

    #adherent2=================================================
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(L3, 0.0), point2=(L3-L2, w))
    p = mdb.models['Model-1'].Part(name='Part-2', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-2']
    p.BaseShell(sketch=s)
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-2']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']



    #adhesive=================================
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=STANDALONE)
    s1.rectangle(point1=(0.0, 0.0), point2=(L3, w))
    p = mdb.models['Model-1'].Part(name='Part-3', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-3']
    p.BaseSolidExtrude(sketch=s1, depth=t3)
    s1.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-3']
    del mdb.models['Model-1'].sketches['__profile__']

    #Adhesive dividing===========================

    p = mdb.models['Model-1'].parts['Part-3']
    f, e, d1 = p.faces, p.edges, p.datums
    ff=f.findAt((L3/10., 0, t3/10.),)
    ee=e.findAt((0, 0, t3/10.),)
    t = p.MakeSketchTransform(sketchPlane=ff, sketchUpEdge=ee, 
        sketchPlaneSide=SIDE1, origin=(0, 0, 0))
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=70.73, gridSpacing=1.76, transform=t)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-1'].parts['Part-3']
    e1, d2 = p.edges, p.datums
    p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)

    if nopart>=2:
        if gradebehav==2:
            for i in range(nopart-1):
                
                x1=(i+1)*float(L3)/(nopart)
                s.Line(point1=(x1, 0), point2=(x1, t3))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-1'].sketches['__profile__']
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                x1=(i+1)*float(L3)/(nopart)
                pickedCells = c.findAt(((x1-x1/200., 0, t3/10.),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10., 0),)
                pickedEdges =e.findAt((x1, 0, t3/10.),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)
        elif gradebehav==3:  
            for i in range(nopart-1):
                
                z1=(i+1)*float(t3)/(nopart)
                s.Line(point1=(0, z1), point2=(L3, z1))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-1'].sketches['__profile__']
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                z1=(i+1)*float(t3)/(nopart)
                pickedCells = c.findAt(((L3/1000., t3/10., z1-z1/200. ),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10., 0),)
                pickedEdges =e.findAt((L3/10., 0, z1),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)



    #Lamina defenition=============================
    if ELP1==3 or ELP2==3:
        for i in range(Laminano):
            mdb.models['Model-1'].Material(name='Lam'+str(i+1))
            mdb.models['Model-1'].materials['Lam'+str(i+1)].Elastic(type=LAMINA, table=((Laminadata[i][0], 
               Laminadata[i][1], Laminadata[i][2], Laminadata[i][3], Laminadata[i][4], Laminadata[i][5]), ))
            if stp==2:
                mdb.models['Model-1'].materials['Lam'+str(i+1)].Density(table=((Laminadata[i][6], ), ))
    #Adherent1  material defenition================

    if ELP1==1 :
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==2:
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        mdb.models['Model-1'].materials['Matadh1'].Plastic(table=((Syadh1, 0.0), (Syadh1, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==3:
        #Section of composite adherent1
        secLayadh1=[]
        for i in range (nolayadh1):
            gg=layupdataadh1[i][0]
            secLayadh1.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh1[i][1], orientAngle=layupdataadh1[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh1', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh1))



    #Adherent2 isotrope material defenition=====================================================
    if ELP2==1:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==2:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        mdb.models['Model-1'].materials['Matadh2'].Plastic(table=((Syadh2, 0.0), (Syadh2, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==3:
    #Section of composite adherent1
        secLayadh2=[]
        for i in range (nolayadh2):
            gg=layupdataadh2[i][0]
            secLayadh2.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh2[i][1], orientAngle=layupdataadh2[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh2', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh2))

        

    #Adhesive isotrope material defenition=============================================================

    if gradebehav == 1:
        mdb.models['Model-1'].Material(name='Materialads')
        mdb.models['Model-1'].materials['Materialads'].Elastic(table=((Eads, vads), ))
        if ELP==2:
            mdb.models['Model-1'].materials['Materialads'].Plastic(table=((Syads, 0.0), (Syads, 1.0)))
        if stp==2:
            mdb.models['Model-1'].materials['Materialads'].Density(table=((Densads, ), ))    
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-1'].Material(name='Materialads-'+str(i))
            x=float(prm)/nopart/2.+(i)*float(prm)/(nopart)
            Eadss=funcE(x,funcdeg)
            vadss=funcv(x,funcdeg)
            mdb.models['Model-1'].materials['Materialads-'+str(i)].Elastic(table=((Eadss, vadss), ))
            if stp==2:
                mdb.models['Model-1'].materials['Materialads-'+str(i)].Density(table=((Densads, ), ))  

    #Section Cration of Adhesive======================================================================
    if gradebehav == 1:
        mdb.models['Model-1'].HomogeneousSolidSection(name='Sectads', material='Materialads', thickness=None)
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-1'].HomogeneousSolidSection(name='Sectads-'+str(i), material='Materialads-'+str(i), thickness=None)
    #Section cration of adherents=====================================================================

    if ELP1==1 or ELP1==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh1', 
            preIntegrate=OFF, material='Matadh1', thicknessType=UNIFORM, 
            thickness=t1, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)


    if ELP2==1 or ELP2==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh2', 
            preIntegrate=OFF, material='Matadh2', thicknessType=UNIFORM, 
            thickness=t2, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)

    #Material orientation of Adherent1 and Adherent 2======================================
    p = mdb.models['Model-1'].parts['Part-1']
    f = p.faces
    faces = f.findAt(((L1/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-1'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    p = mdb.models['Model-1'].parts['Part-2']
    f = p.faces
    faces = f.findAt(((L2/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-2'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')
    #Section Assignment=======================================================================================
    if ELP1==1 or ELP1==2:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2., w/2., 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Sectadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP1==3:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2., w/2., 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)



    if ELP2==1 or ELP2==2:
        p = mdb.models['Model-1'].parts['Part-2']
        f = p.faces
        faces = f.findAt((((L3-L2)/2, w/2., 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Sectadh2', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP2==3:
        p = mdb.models['Model-1'].parts['Part-2']
        f = p.faces
        faces = f.findAt((((L3-L2)/2., w/2., 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)

        

    if gradebehav==1:
        p = mdb.models['Model-1'].parts['Part-3']
        c = p.cells
        cells = c.findAt(((L3/2.,w/2.,t3/2.),))
        cell=(cells,)
        p = mdb.models['Model-1'].parts['Part-3']
        p.SectionAssignment(region=cell, sectionName='Sectads', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif gradebehav==2:
        for i in range(nopart):
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
            print(x1)
            cells = c.findAt(((x1,w/2.,t3/2.),))
            cell=(cells,)
            p = mdb.models['Model-1'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)
    elif gradebehav==3:
        for i in range(nopart):
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2.
            cells = c.findAt(((L3/2.,w/2.,z1),))
            cell=(cells,)
            p = mdb.models['Model-1'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)


    #Assembly==============================================
    a = mdb.models['Model-1'].rootAssembly
    a.DatumCsysByDefault(CARTESIAN)
    p = mdb.models['Model-1'].parts['Part-1']
    a.Instance(name='Part-1-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-2']
    a.Instance(name='Part-2-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-3']
    a.Instance(name='Part-3-1', part=p, dependent=OFF)


    a = mdb.models['Model-1'].rootAssembly
    p1 = a.instances['Part-2-1']
    p1.translate(vector=(0, 0.0, t3))


    #Step defenition=======================================================================
    if stp==1:
        mdb.models['Model-1'].StaticStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    else:
        mdb.models['Model-1'].ExplicitDynamicsStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    #Tying adhesive and adherents===================================================================================

    if gradebehav==1 or gradebehav==3:
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = s1.findAt(((L1/2., w/2., 0),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-1')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2., w/2., 0),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-1')
        mdb.models['Model-1'].Tie(name='Constraint-1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side2Faces1 = s1.findAt((((L3-L2)/2., w/2., t3),))
        region1=a.Surface(side2Faces=side2Faces1, name='m_Surf-3')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2., w/2., t3),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-3')
        mdb.models['Model-1'].Tie(name='Constraint-2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
    elif  gradebehav==2:
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = s1.findAt(((L1/2., 0, 0),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-1')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
            side1Faces1.append(s1.findAt((x1, w/2., 0),))
            region2=(side1Faces1,)  
        mdb.models['Model-1'].Tie(name='Constraint-1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side1Faces1 = s1.findAt(((L3-L2/2., 0, t3),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
            side1Faces1.append(s1.findAt((x1, w/2., t3),))
            region2=(side1Faces1, )      
        mdb.models['Model-1'].Tie(name='Constraint-2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
    #Boundary Condition and Loading=========================================

    a = mdb.models['Model-1'].rootAssembly
    e1 = a.instances['Part-2-1'].edges
    edges1 = e1.findAt((((L3-L2),w/2, t3),))
    region = (edges1,)
    mdb.models['Model-1'].EncastreBC(name='BC-1', createStepName='Step-1', 
        region=region, localCsys=None)

    #==========================================================

    mdb.models['Model-1'].TabularAmplitude(name='Amp-1', timeSpan=STEP, 
        smooth=SOLVER_DEFAULT, data=((0.0, 0.0), (stptime, 1.0)))
    if LC==1:
        if 0==0:
            a = mdb.models['Model-1'].rootAssembly
            e1 = a.instances['Part-1-1'].edges
            edges1 = e1.findAt(((L1,w/2., 0),))
            region = (edges1,)
            mdb.models['Model-1'].DisplacementBC(name='BC-3', createStepName='Step-1', 
                region=region, u1=0.0, u2=0.0, ur3=0, amplitude='Amp-1', fixed=OFF, 
                distributionType=UNIFORM, fieldName='', localCsys=None)
            mdb.models['Model-1'].boundaryConditions['BC-3'].move('Step-1', 'Initial')
            mdb.models['Model-1'].boundaryConditions['BC-3'].setValuesInStep(
                stepName='Step-1', u1=Ux, u2=Uy, u3=Uz, ur1=0, ur2=0, ur3=0 )
    elif LC ==2:
         if Tx !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1, w/2., 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-6')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-1', createStepName='Step-1', 
                region=region, magnitude=-Tx, distributionType=UNIFORM, field='', 
                localCsys=None, traction=NORMAL)        
             
         if Tz !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1, w/2., 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Tz, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)        

         if Ty !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1, w/2., 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Ty, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)              
             


    if (Tz==0 and LC==2) :
        a = mdb.models['Model-1'].rootAssembly
        e1 = a.instances['Part-1-1'].edges
        side1Edges1 = e1.findAt(((L1, w/2, 0),))
        mdb.models['Model-1'].ZsymmBC(name='BC-4', createStepName='Step-1', 
            region=(side1Edges1, ), localCsys=None)






    #Meshing====================================================================
    a = mdb.models['Model-1'].rootAssembly
    partInstances =(a.instances['Part-1-1'], a.instances['Part-2-1'], 
        a.instances['Part-3-1'], )
    a.seedPartInstance(regions=partInstances, size=meshsize, deviationFactor=0.1, 
        minSizeFactor=0.1)


    if gradebehav !=3:
        e1 = a.instances['Part-3-1'].edges
        pickedEdges1 = e1.findAt(((0, 0, t3/2.),))
        pickedEdges2 = e1.findAt(((0, w, t3/2.),))
        pickedEdges=pickedEdges2+pickedEdges1
        a.seedEdgeBySize(edges=pickedEdges, size=meshthic, deviationFactor=0.1, 
            constraint=FINER)



    if gradebehav ==2:
        for i in range(4):
            e1 = a.instances['Part-3-1'].edges
            x=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
            pickedEdges1 = e1.findAt(((x, 0, t3),))
            pickedEdges2 = e1.findAt(((x, 0, 0),))
            pickedEdges=pickedEdges2+pickedEdges1
            a.seedEdgeBySize(edges=pickedEdges, size=meshlength, deviationFactor=0.1, 
                constraint=FINER)
        for i in range(nopart-3, nopart):
            e1 = a.instances['Part-3-1'].edges
            x=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
            pickedEdges1 = e1.findAt(((x, 0, t3),))
            pickedEdges2 = e1.findAt(((x, 0, 0),))
            pickedEdges=pickedEdges2+pickedEdges1
            a.seedEdgeBySize(edges=pickedEdges, size=meshlength, deviationFactor=0.1, 
                constraint=FINER)


    ##if QT==1:
    ##    a.setMeshControls(regions=partInstances, elemShape=QUAD_DOMINATED)
    ##else:
    ##    a.setMeshControls(regions=partInstances, elemShape=TRI)



    a.generateMesh(regions=partInstances)

    if stp==1:
        elemType1 = mesh.ElemType(elemCode=C3D20R, elemLibrary=STANDARD) 
        if nonlinmesh==1:
            if gradebehav==1:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                cells1 = c1.findAt((L3/2., w/2., t3/2.),)
                pickedRegions =((cells1), )
                a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
            elif gradebehav==2:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                for i in range(nopart):
                    x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
                    print(x1)
                    cells1 = c1.findAt(((x1,w/2,t3/2),))
                    pickedRegions=((cells1),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
            elif gradebehav==3:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                for i in range(nopart):
                    z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2.
                    print(z1)
                    cells1 = c1.findAt(((L3/2., w/2, z1),))
                    pickedRegions=((cells1),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))





    #Job Creation====================================================================
    mdb.Job(name=jobname, model='Model-1', description='', type=ANALYSIS, 
        atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
        memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
        explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
        modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
        scratch='', multiprocessingMode=DEFAULT, numCpus=1, numGPUs=0)

    mdb.jobs[jobname].submit(consistencyChecking=OFF)
    mdb.jobs[jobname].waitForCompletion()
    mdb.saveAs('SLJ'+'CAEfile')



    session.viewports['Viewport: 1'].assemblyDisplay.setValues(interactions=OFF, 
        constraints=OFF, connectors=OFF, engineeringFeatures=OFF)
    session.mdbData.summary()



    o3 = session.openOdb(name=a12)
    session.viewports['Viewport: 1'].setValues(displayedObject=o3)
    session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
        CONTOURS_ON_DEF, ))




    bn=session.odbs[a12].rootAssembly.instances['PART-3-1'].nodes

    def nodfinder(x, y, z, nodassem):
        cvt=[]
        for i in range (len(bn)):
            dist=abs(nodassem[i].coordinates[0]-x)+ abs(nodassem[i].coordinates[1]-y)+ abs(nodassem[i].coordinates[2]-z)
            cvt.append(dist)
        n1=cvt.index(min(cvt))
        highlight(nodassem[n1])
        return n1

    nn1=nodfinder(0, w/2., t3/2., bn)
    nn2=nodfinder(L3, w/2., t3/2., bn)



    session.Path(name='Path-1', type=NODE_LIST, expression=(('PART-3-1', (nn1, 
            nn2, )), ))


    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        INVARIANT, 'Mises'))
    pth = session.paths['Path-1']
    session.XYDataFromPath(name='XYData-1', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)
    x0 = session.xyDataObjects['XYData-1']
    session.writeXYReport(fileName='MSLJ.txt', appendMode=OFF, xyData=(x0, ))


    #===================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S13'))

    session.XYDataFromPath(name='XYData-2', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x1 = session.xyDataObjects['XYData-2']
    session.writeXYReport(fileName='SSLJ.txt', appendMode=OFF, xyData=(x1, ))

    #============================================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S33'))


    session.XYDataFromPath(name='XYData-3', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x2 = session.xyDataObjects['XYData-3']
    session.writeXYReport(fileName='NSLJ.txt', appendMode=OFF, xyData=(x2, ))


elif jointtype==2:

    #=========================================================

    mdb.Model(name='Model-2', modelType=STANDARD_EXPLICIT)
    session.viewports['Viewport: 1'].setValues(displayedObject=None)

    #adherent1
    s = mdb.models['Model-2'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(0.0, 0.0), point2=(L1, w))
    p = mdb.models['Model-2'].Part(name='Part-1', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-2'].parts['Part-1']
    p.BaseShell(sketch=s)
    s.unsetPrimaryObject()
    p = mdb.models['Model-2'].parts['Part-1']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-2'].sketches['__profile__']

    #adherent2=================================================
    s = mdb.models['Model-2'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(L3, 0.0), point2=(L3-L2, w))
    p = mdb.models['Model-2'].Part(name='Part-2', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-2'].parts['Part-2']
    p.BaseShell(sketch=s)
    s.unsetPrimaryObject()
    p = mdb.models['Model-2'].parts['Part-2']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-2'].sketches['__profile__']



    #adhesive=================================
    s1 = mdb.models['Model-2'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=STANDALONE)
    s1.rectangle(point1=(0.0, 0.0), point2=(L3, w))
    p = mdb.models['Model-2'].Part(name='Part-3', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-2'].parts['Part-3']
    p.BaseSolidExtrude(sketch=s1, depth=t3)
    s1.unsetPrimaryObject()
    p = mdb.models['Model-2'].parts['Part-3']
    del mdb.models['Model-2'].sketches['__profile__']

    #Adhesive dividing===========================

    p = mdb.models['Model-2'].parts['Part-3']
    f, e, d1 = p.faces, p.edges, p.datums
    ff=f.findAt((L3/10, 0, t3/10),)
    ee=e.findAt((0, 0, t3/10),)
    t = p.MakeSketchTransform(sketchPlane=ff, sketchUpEdge=ee, 
        sketchPlaneSide=SIDE1, origin=(0, 0, 0))
    s = mdb.models['Model-2'].ConstrainedSketch(name='__profile__', 
        sheetSize=70.73, gridSpacing=1.76, transform=t)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-2'].parts['Part-3']
    e1, d2 = p.edges, p.datums
    p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)

    if nopart>=2:
        if gradebehav==2:
            for i in range(nopart-1):
                
                x1=(i+1)*float(L3)/(nopart)
                s.Line(point1=(x1, 0), point2=(x1, t3))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-2'].sketches['__profile__']
            p = mdb.models['Model-2'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                x1=(i+1)*float(L3)/(nopart)
                pickedCells = c.findAt(((x1-x1/200, 0, t3/10),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10, 0),)
                pickedEdges =e.findAt((x1, 0, t3/10),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)
        elif gradebehav==3:  
            for i in range(nopart-1):
                
                z1=(i+1)*float(t3)/(nopart)
                s.Line(point1=(0, z1), point2=(L3, z1))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-2'].sketches['__profile__']
            p = mdb.models['Model-2'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                z1=(i+1)*float(t3)/(nopart)
                pickedCells = c.findAt(((L3/1000, t3/10, z1-z1/200 ),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10, 0),)
                pickedEdges =e.findAt((L3/10, 0, z1),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)


    #Lamina defenition=============================
    if ELP1==3 or ELP2==3:
        for i in range(Laminano):
            mdb.models['Model-2'].Material(name='Lam'+str(i+1))
            mdb.models['Model-2'].materials['Lam'+str(i+1)].Elastic(type=LAMINA, table=((Laminadata[i][0], 
               Laminadata[i][1], Laminadata[i][2], Laminadata[i][3], Laminadata[i][4], Laminadata[i][5]), ))
            if stp==2:
                mdb.models['Model-2'].materials['Lam'+str(i+1)].Density(table=((Laminadata[i][6], ), ))
    #Adherent1  material defenition================

    if ELP1==1 :
        mdb.models['Model-2'].Material(name='Matadh1')
        mdb.models['Model-2'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        if stp==2:
           mdb.models['Model-2'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==2:
        mdb.models['Model-2'].Material(name='Matadh1')
        mdb.models['Model-2'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        mdb.models['Model-2'].materials['Matadh1'].Plastic(table=((Syadh1, 0.0), (Syadh1, 1.0)))
        if stp==2:
           mdb.models['Model-2'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==3:
        #Section of composite adherent1
        secLayadh1=[]
        for i in range (nolayadh1):
            gg=layupdataadh1[i][0]
            secLayadh1.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh1[i][1], orientAngle=layupdataadh1[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-2'].CompositeShellSection(name='Seccompadh1', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh1))



    #Adherent2 isotrope material defenition=====================================================
    if ELP2==1:
        mdb.models['Model-2'].Material(name='Matadh2')
        mdb.models['Model-2'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        if stp==2:
           mdb.models['Model-2'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==2:
        mdb.models['Model-2'].Material(name='Matadh2')
        mdb.models['Model-2'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        mdb.models['Model-2'].materials['Matadh2'].Plastic(table=((Syadh2, 0.0), (Syadh2, 1.0)))
        if stp==2:
           mdb.models['Model-2'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==3:
    #Section of composite adherent1
        secLayadh2=[]
        for i in range (nolayadh2):
            gg=layupdataadh2[i][0]
            secLayadh2.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh2[i][1], orientAngle=layupdataadh2[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-2'].CompositeShellSection(name='Seccompadh2', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh2))

        

    #Adhesive isotrope material defenition=============================================================

    if gradebehav == 1:
        mdb.models['Model-2'].Material(name='Materialads')
        mdb.models['Model-2'].materials['Materialads'].Elastic(table=((Eads, vads), ))
        if ELP==2:
            mdb.models['Model-2'].materials['Materialads'].Plastic(table=((Syads, 0.0), (Syads, 1.0)))
        if stp==2:
            mdb.models['Model-2'].materials['Materialads'].Density(table=((Densads, ), ))    
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-2'].Material(name='Materialads-'+str(i))
            x=float(prm)/nopart/2.+(i)*float(prm)/(nopart)
            Eadss=funcE(x,funcdeg)
            vadss=funcv(x,funcdeg)
            mdb.models['Model-2'].materials['Materialads-'+str(i)].Elastic(table=((Eadss, vadss), ))
            if stp==2:
                mdb.models['Model-2'].materials['Materialads-'+str(i)].Density(table=((Densads, ), ))  

    #Section Cration of Adhesive======================================================================
    if gradebehav == 1:
        mdb.models['Model-2'].HomogeneousSolidSection(name='Sectads', material='Materialads', thickness=None)
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-2'].HomogeneousSolidSection(name='Sectads-'+str(i), material='Materialads-'+str(i), thickness=None)
    #Section cration of adherents=====================================================================

    if ELP1==1 or ELP1==2:
        mdb.models['Model-2'].HomogeneousShellSection(name='Sectadh1', 
            preIntegrate=OFF, material='Matadh1', thicknessType=UNIFORM, 
            thickness=t1, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)


    if ELP2==1 or ELP2==2:
        mdb.models['Model-2'].HomogeneousShellSection(name='Sectadh2', 
            preIntegrate=OFF, material='Matadh2', thicknessType=UNIFORM, 
            thickness=t2, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)

    #Material orientation of Adherent1 and Adherent 2======================================
    p = mdb.models['Model-2'].parts['Part-1']
    f = p.faces
    faces = f.findAt(((L1/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-2'].parts['Part-1'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    p = mdb.models['Model-2'].parts['Part-2']
    f = p.faces
    faces = f.findAt(((L2/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-2'].parts['Part-2'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    #Section Assignment=======================================================================================
    if ELP1==1 or ELP1==2:
        p = mdb.models['Model-2'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Sectadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP1==3:
        p = mdb.models['Model-2'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)

    if ELP2==1 or ELP2==2:
        p = mdb.models['Model-2'].parts['Part-2']
        f = p.faces
        faces = f.findAt((((L3-L2)/2, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Sectadh2', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP2==3:
        p = mdb.models['Model-2'].parts['Part-2']
        f = p.faces
        faces = f.findAt((((L3-L2)/2, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION) 

    if gradebehav==1:
        p = mdb.models['Model-2'].parts['Part-3']
        c = p.cells
        cells = c.findAt(((L3/2,w/2,t3/2),))
        cell=(cells,)
        p = mdb.models['Model-2'].parts['Part-3']
        p.SectionAssignment(region=cell, sectionName='Sectads', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif gradebehav==2:
        for i in range(nopart):
            p = mdb.models['Model-2'].parts['Part-3']
            c = p.cells
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            print(x1)
            cells = c.findAt(((x1,w/2,t3/2),))
            cell=(cells,)
            p = mdb.models['Model-2'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)
    elif gradebehav==3:
        for i in range(nopart):
            p = mdb.models['Model-2'].parts['Part-3']
            c = p.cells
            z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2
            cells = c.findAt(((L3/2,w/2,z1),))
            cell=(cells,)
            p = mdb.models['Model-2'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)


    #Assembly==============================================
    a = mdb.models['Model-2'].rootAssembly
    a.DatumCsysByDefault(CARTESIAN)
    p = mdb.models['Model-2'].parts['Part-1']
    a.Instance(name='Part-1-1', part=p, dependent=OFF)
    a.Instance(name='Part-1-2', part=p, dependent=OFF)
    p = mdb.models['Model-2'].parts['Part-2']
    a.Instance(name='Part-2-1', part=p, dependent=OFF)
    p = mdb.models['Model-2'].parts['Part-3']
    a.Instance(name='Part-3-1', part=p, dependent=OFF)
    a.Instance(name='Part-3-2', part=p, dependent=OFF)
    a = mdb.models['Model-2'].rootAssembly
    p2 = a.instances['Part-1-2']
    p2.translate(vector=(0, 0.0, t3))
    p2 = a.instances['Part-1-2']
    p2.translate(vector=(0, 0.0, t3))
    a.rotate(instanceList=('Part-1-2', ), axisPoint=(0.0, w/2., t3+t3), axisDirection=(100.0, 0.0, 0.0), angle=180.0)
    p3 = a.instances['Part-2-1']
    p3.translate(vector=(0, 0.0, t3))
    p4 = a.instances['Part-3-2']
    p4.translate(vector=(0, 0.0, t3))
    #Step defenition=======================================================================
    if stp==1:
        mdb.models['Model-2'].StaticStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    else:
        mdb.models['Model-2'].ExplicitDynamicsStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    #Tying adhesive and adherents===================================================================================


    if gradebehav==1 or gradebehav==3:
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side1Faces1 = s1.findAt((((L3-L2)/2, w/2, t3),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-3')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-2'].faces
        side1Faces1 = s1.findAt(((L3/2, w/2, t3),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-3')
        mdb.models['Model-2'].Tie(name='C3', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)    
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-1-2'].faces
        side2Faces1 = s1.findAt(((L1/2, w/2, 2.*t3),))
        region1=a.Surface(side1Faces=side2Faces1, name='m_Surf-4')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-2'].faces
        side1Faces1 = s1.findAt(((L3/2, w/2, 2.*t3),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-4')
        mdb.models['Model-2'].Tie(name='C4', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)  
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = s1.findAt(((L1/2, w/2, 0),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-1')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2, w/2, 0),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-1')
        mdb.models['Model-2'].Tie(name='C1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)    
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side2Faces1 = s1.findAt((((L3-L2)/2, w/2, t3),))
        region1=a.Surface(side2Faces=side2Faces1, name='m_Surf-2')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2, w/2, t3),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-2')
        mdb.models['Model-2'].Tie(name='C2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)   
      
    elif  gradebehav==2:
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = s1.findAt(((L1/2, 0, 0),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-5')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, 0),))
            region2=(side1Faces1,)  
        mdb.models['Model-2'].Tie(name='Constraint-1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side1Faces1 = s1.findAt(((L3-L2/2, 0, t3),))
        region1=a.Surface(side2Faces=side1Faces1, name='m_Surf-6')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, t3),))
            region2=(side1Faces1, )      
        mdb.models['Model-2'].Tie(name='Constraint-2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side1Faces1 = s1.findAt(((L3-L2/2, 0, t3),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-7')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-2'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, t3),))
            region2=(side1Faces1,)  
        mdb.models['Model-2'].Tie(name='Constraint-3', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-1-2'].faces
        side1Faces1 = s1.findAt(((L1/2, 0, 2.*t3),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-8')
        a = mdb.models['Model-2'].rootAssembly
        s1 = a.instances['Part-3-2'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, 2.*t3),))
            region2=(side1Faces1, )      
        mdb.models['Model-2'].Tie(name='Constraint-4', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)

       
    #Boundary Condition and Loading=========================================

    a = mdb.models['Model-2'].rootAssembly
    e1 = a.instances['Part-1-1'].edges
    edges1 = e1.findAt((L1, w/2., 0),)
    e2 = a.instances['Part-1-2'].edges
    edges2 = e2.findAt((L1, w/2., 2.*t3),)
    region = (edges1,)+(edges2,)
    mdb.models['Model-2'].EncastreBC(name='BC-1', createStepName='Step-1', 
        region=region, localCsys=None)

    #==========================================================
    mdb.models['Model-2'].TabularAmplitude(name='Amp-1', timeSpan=STEP, 
        smooth=SOLVER_DEFAULT, data=((0.0, 0.0), (stptime, 1.0)))
    if LC==1:
        if 0==0:
            a = mdb.models['Model-2'].rootAssembly
            e1 = a.instances['Part-2-1'].edges
            edges1 = e1.findAt(((L3-L2,w/2, t3),))
            region = (edges1,)
            mdb.models['Model-2'].DisplacementBC(name='BC-3', createStepName='Step-1', 
                region=region, u1=0.0, u2=0.0, ur3=0, amplitude='Amp-1', fixed=OFF, 
                distributionType=UNIFORM, fieldName='', localCsys=None)
            mdb.models['Model-2'].boundaryConditions['BC-3'].move('Step-1', 'Initial')
            mdb.models['Model-2'].boundaryConditions['BC-3'].setValuesInStep(
                stepName='Step-1', u1=-Ux, u2=Uy, u3=Uz)

    elif LC ==2:
         if Tx !=0:
            a = mdb.models['Model-2'].rootAssembly
            s1 = a.instances['Part-2-1'].edges
            side1Edges1 = s1.findAt(((L3-L2,w/2, t3),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-6')
            mdb.models['Model-2'].ShellEdgeLoad(name='Load-1', createStepName='Step-1', 
                region=region, magnitude=-Tx, distributionType=UNIFORM, field='', 
                localCsys=None, traction=NORMAL)        
             
         if Tz !=0:
            a = mdb.models['Model-2'].rootAssembly
            s1 = a.instances['Part-2-1'].edges
            side1Edges1 = s1.findAt(((L3-L2,w/2, t3),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-2'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Tz, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)       

         if Ty !=0:
            a = mdb.models['Model-2'].rootAssembly
            s1 = a.instances['Part-2-1'].edges
            side1Edges1 = s1.findAt(((L3-L2,w/2, t3),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-2'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Ty, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)   


##    if (Uz==0 and LC==1) or (Tz==0 and LC==2) :
##        a = mdb.models['Model-2'].rootAssembly
##        e1 = a.instances['Part-2-1'].edges
##        side1Edges1 = e1.findAt(((L3-L2,w/2, t3),))
##        mdb.models['Model-2'].ZsymmBC(name='BC-4', createStepName='Step-1', 
##            region=(side1Edges1, ), localCsys=None)

    #Meshing====================================================================
    a = mdb.models['Model-2'].rootAssembly
    partInstances =(a.instances['Part-1-1'], a.instances['Part-2-1'], 
        a.instances['Part-3-1'],  a.instances['Part-3-2'],  a.instances['Part-1-2'], )
    a.seedPartInstance(regions=partInstances, size=meshsize, deviationFactor=0.1, 
        minSizeFactor=0.1)


    if gradebehav !=3:
        e1 = a.instances['Part-3-1'].edges
        pickedEdges1 = e1.findAt(((0, 0, t3/2.),))
        pickedEdges2 = e1.findAt(((0, w, t3/2.),))
        e1 = a.instances['Part-3-2'].edges
        pickedEdges3 = e1.findAt(((0, 0, 3.*t3/2.),))
        pickedEdges4 = e1.findAt(((0, w, 3.*t3/2.),))
        pickedEdges=pickedEdges2+pickedEdges1+pickedEdges3+pickedEdges4
        a.seedEdgeBySize(edges=pickedEdges, size=meshthic, deviationFactor=0.1, 
            constraint=FINER)


    ##if QT==1:
    ##    a.setMeshControls(regions=partInstances, elemShape=QUAD_DOMINATED)
    ##else:
    ##    a.setMeshControls(regions=partInstances, elemShape=TRI)



    a.generateMesh(regions=partInstances)


    if stp==1:
        elemType1 = mesh.ElemType(elemCode=C3D20R, elemLibrary=STANDARD) 
        if nonlinmesh==1:
            if gradebehav==1:
                a = mdb.models['Model-2'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                cells1 = c1.findAt((L3/2., w/2., t3/2.),)
                c2 = a.instances['Part-3-2'].cells
                cells2 = c2.findAt((L3/2., w/2., 3*t3/2.),)
                pickedRegions =((cells1), )
                pickedRegions1 =((cells2), )
                a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
                a.setElementType(regions=pickedRegions1, elemTypes=(elemType1,))
            elif gradebehav==2:
                a = mdb.models['Model-2'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                c2 = a.instances['Part-3-2'].cells
                for i in range(nopart):
                    x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
                    print(x1)
                    cells1 = c1.findAt(((x1,w/2,t3/2),))
                    cells2 = c2.findAt(((x1,w/2,3.*t3/2),))
                    pickedRegions=((cells1),)
                    pickedRegions1=((cells2),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
                    a.setElementType(regions=pickedRegions1, elemTypes=(elemType1,))
            elif gradebehav==3:
                a = mdb.models['Model-2'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                c2 = a.instances['Part-3-2'].cells
                for i in range(nopart):
                    z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2.
                    print(z1)
                    cells1 = c1.findAt(((L3/2., w/2, z1),))
                    cells2 = c2.findAt(((L3/2., w/2, t3+z1),))
                    pickedRegions=((cells1),)
                    pickedRegions1=((cells2),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
                    a.setElementType(regions=pickedRegions1, elemTypes=(elemType1,))

    mdb.saveAs('DLJ'+'CAEfile')
    #Job Creation====================================================================
    mdb.Job(name=jobname, model='Model-2', description='', type=ANALYSIS, 
        atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
        memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
        explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
        modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
        scratch='', multiprocessingMode=DEFAULT, numCpus=1, numGPUs=0)

    mdb.jobs[jobname].submit(consistencyChecking=OFF)
    mdb.jobs[jobname].waitForCompletion()



    session.viewports['Viewport: 1'].assemblyDisplay.setValues(interactions=OFF, 
        constraints=OFF, connectors=OFF, engineeringFeatures=OFF)



    o3 = session.openOdb(name=a22)
    session.viewports['Viewport: 1'].setValues(displayedObject=o3)
    session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
        CONTOURS_ON_DEF, ))


    bn1=session.odbs[a22].rootAssembly.instances['PART-3-1'].nodes
    bn2=session.odbs[a22].rootAssembly.instances['PART-3-2'].nodes

    def nodfinder(x, y, z, nodassem):
        cvt=[]
        for i in range (len(nodassem)):
            dist=abs(nodassem[i].coordinates[0]-x)+ abs(nodassem[i].coordinates[1]-y)+ abs(nodassem[i].coordinates[2]-z)
            cvt.append(dist)
        n1=cvt.index(min(cvt))
        highlight(nodassem[n1])
        return n1

    nn1=nodfinder(0, w/2., t3/2., bn1)
    nn2=nodfinder(L3, w/2., t3/2., bn1)

    nn3=nodfinder(0, w/2., 3.*t3/2., bn2)
    nn4=nodfinder(L3, w/2., 3.*t3/2., bn2)


    session.Path(name='Path-1', type=NODE_LIST, expression=(('PART-3-1', (nn1, 
            nn2, )), ))
    session.Path(name='Path-2', type=NODE_LIST, expression=(('PART-3-2', (nn3, 
            nn4, )), ))



    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        INVARIANT, 'Mises'))
    pth = session.paths['Path-1']
    pth2 = session.paths['Path-2']

    session.XYDataFromPath(name='XYData-1', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)
    x0 = session.xyDataObjects['XYData-1']
    session.writeXYReport(fileName='MSLJ1.txt', appendMode=OFF, xyData=(x0, ))



    session.XYDataFromPath(name='XYData-2', path=pth2, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)
    x1 = session.xyDataObjects['XYData-2']
    session.writeXYReport(fileName='MSLJ2.txt', appendMode=OFF, xyData=(x1, ))
    #===================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S13'))

    session.XYDataFromPath(name='XYData-3', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x2 = session.xyDataObjects['XYData-3']
    session.writeXYReport(fileName='SSLJ1.txt', appendMode=OFF, xyData=(x2, ))

    session.XYDataFromPath(name='XYData-4', path=pth2, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x3 = session.xyDataObjects['XYData-4']
    session.writeXYReport(fileName='SSLJ2.txt', appendMode=OFF, xyData=(x3, ))

    #============================================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S33'))


    session.XYDataFromPath(name='XYData-5', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x4 = session.xyDataObjects['XYData-5']
    session.writeXYReport(fileName='NSLJ1.txt', appendMode=OFF, xyData=(x4, ))



    session.XYDataFromPath(name='XYData-6', path=pth2, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x5 = session.xyDataObjects['XYData-6']
    session.writeXYReport(fileName='NSLJ2.txt', appendMode=OFF, xyData=(x5, ))


elif jointtype==3:

    #adherent1=============
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(0, 0), point2=(L3, w))
    p = mdb.models['Model-1'].Part(name='Part-1', dimensionality=THREE_D, type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-1']
    p.BaseShell(sketch=s)
    mdb.models['Model-1'].parts['Part-1'].features['Shell planar-1']
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-1']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']
    p = mdb.models['Model-1'].parts['Part-1']
    f, e = p.faces, p.edges
    ff=f.findAt((L3/2., w, 0),)
    ee=e.findAt((L3, w/2., 0),)
    t = p.MakeSketchTransform(sketchPlane=f[0], sketchUpEdge=e[3], sketchPlaneSide=SIDE1, sketchOrientation=RIGHT, origin=(0, 0.0, 0))
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', sheetSize=309.84, gridSpacing=7.74, transform=t)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-1'].parts['Part-1']
    p.projectReferencesOntoSketch(sketch=s1, filter=COPLANAR_EDGES)
    s1.Line(point1=(L3/2., 0), point2=(L3/2., w))
    mdb.models['Model-1'].sketches['__profile__'].geometry[6]

    p = mdb.models['Model-1'].parts['Part-1']
    f1, e1 = p.faces, p.edges
    p.ShellExtrude(sketchPlane=ff, sketchUpEdge=ee, sketchPlaneSide=SIDE1, 
    sketchOrientation=RIGHT, sketch=s1, depth=L1, 
     flipExtrudeDirection=OFF)
    mdb.models['Model-1'].parts['Part-1'].features['Shell extrude-1']
    s1.unsetPrimaryObject()
    del mdb.models['Model-1'].sketches['__profile__']

    #adherent2=================================================
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
     sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=((L3-L2)/2., 0.0), point2=((L2+L3)/2., w))
    p = mdb.models['Model-1'].Part(name='Part-2', dimensionality=THREE_D, type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-2']
    p.BaseShell(sketch=s)
    mdb.models['Model-1'].parts['Part-2'].features['Shell planar-1']
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-2']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']

    #adhesive=================================
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
     sheetSize=200.0)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=STANDALONE)
    s1.rectangle(point1=(0.0, 0.0), point2=(L3, w))
    p = mdb.models['Model-1'].Part(name='Part-3', dimensionality=THREE_D, type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-3']
    p.BaseSolidExtrude(sketch=s1, depth=t3)
    mdb.models['Model-1'].parts['Part-3'].features['Solid extrude-1']
    s1.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-3']
    del mdb.models['Model-1'].sketches['__profile__']

    #Adhesive dividing===========================

    p = mdb.models['Model-1'].parts['Part-3']
    f, e, d1 = p.faces, p.edges, p.datums
    ff=f.findAt((L3/10, 0, t3/10.),)
    ee=e.findAt((L3, 0, t3/10.),)
    t = p.MakeSketchTransform(sketchPlane=ff, sketchUpEdge=ee, 
        sketchPlaneSide=SIDE1, origin=(0, 0, 0))
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=70.73, gridSpacing=1.76, transform=t)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=SUPERIMPOSE)
    p = mdb.models['Model-1'].parts['Part-3']
    e1, d2 = p.edges, p.datums
    p.projectReferencesOntoSketch(sketch=s, filter=COPLANAR_EDGES)

    if nopart>=2:
        if gradebehav==2:
            for i in range(nopart-1):
                
                x1=(i+1)*float(L3)/(nopart)
                s.Line(point1=(x1, 0), point2=(x1, t3))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-1'].sketches['__profile__']
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                x1=(i+1)*float(L3)/(nopart)
                pickedCells = c.findAt(((x1-x1/200, 0, t3/10),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10, 0),)
                pickedEdges =e.findAt((x1, 0, t3/10),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)
        elif gradebehav==3:  
            for i in range(nopart-1):
                
                z1=(i+1)*float(t3)/(nopart)
                s.Line(point1=(0, z1), point2=(L3, z1))
            p.PartitionFaceBySketch(sketchUpEdge=ee, faces=ff, sketch=s)
            s.unsetPrimaryObject()
            del mdb.models['Model-1'].sketches['__profile__']
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            for i in range(nopart-1):
                z1=(i+1)*float(t3)/(nopart)
                pickedCells = c.findAt(((L3/1000, t3/10, z1-z1/200 ),))
                e, d1 = p.edges, p.datums
                ee=e.findAt((0, w/10, 0),)
                pickedEdges =e.findAt((L3/10, 0, z1),)
                p.PartitionCellByExtrudeEdge(line=ee, cells=pickedCells, edges=(pickedEdges, ), sense=FORWARD)
    #Lamina defenition=============================
    if ELP1==3 or ELP2==3:
        for i in range(Laminano):
            mdb.models['Model-1'].Material(name='Lam'+str(i+1))
            mdb.models['Model-1'].materials['Lam'+str(i+1)].Elastic(type=LAMINA, table=((Laminadata[i][0], 
               Laminadata[i][1], Laminadata[i][2], Laminadata[i][3], Laminadata[i][4], Laminadata[i][5]), ))
            if stp==2:
                mdb.models['Model-1'].materials['Lam'+str(i+1)].Density(table=((Laminadata[i][6], ), ))
    #Adherent1  material defenition================

    if ELP1==1 :
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==2:
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        mdb.models['Model-1'].materials['Matadh1'].Plastic(table=((Syadh1, 0.0), (Syadh1, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==3:
        #Section of composite adherent1
        secLayadh1=[]
        for i in range (nolayadh1):
            gg=layupdataadh1[i][0]
            secLayadh1.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh1[i][1], orientAngle=layupdataadh1[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh1', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh1))



    #Adherent2 isotrope material defenition=====================================================
    if ELP2==1:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==2:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        mdb.models['Model-1'].materials['Matadh2'].Plastic(table=((Syadh2, 0.0), (Syadh2, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==3:
    #Section of composite adherent1
        secLayadh2=[]
        for i in range (nolayadh2):
            gg=layupdataadh2[i][0]
            secLayadh2.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh2[i][1], orientAngle=layupdataadh2[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh2', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh2))

        

    #Adhesive isotrope material defenition=============================================================

    if gradebehav == 1:
        mdb.models['Model-1'].Material(name='Materialads')
        mdb.models['Model-1'].materials['Materialads'].Elastic(table=((Eads, vads), ))
        if ELP==2:
            mdb.models['Model-1'].materials['Materialads'].Plastic(table=((Syads, 0.0), (Syads, 1.0)))
        if stp==2:
            mdb.models['Model-1'].materials['Materialads'].Density(table=((Densads, ), ))    
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-1'].Material(name='Materialads-'+str(i))
            x=float(prm)/nopart/2.+(i)*float(prm)/(nopart)
            Eadss=funcE(x,funcdeg)
            vadss=funcv(x,funcdeg)
            mdb.models['Model-1'].materials['Materialads-'+str(i)].Elastic(table=((Eadss, vadss), ))
            if stp==2:
                mdb.models['Model-1'].materials['Materialads-'+str(i)].Density(table=((Densads, ), ))  

    #Section Cration of Adhesive======================================================================
    if gradebehav == 1:
        mdb.models['Model-1'].HomogeneousSolidSection(name='Sectads', material='Materialads', thickness=None)
    elif (gradebehav ==2) or (gradebehav==3):
        for i in range(nopart):  
            mdb.models['Model-1'].HomogeneousSolidSection(name='Sectads-'+str(i), material='Materialads-'+str(i), thickness=None)
    #Section cration of adherents=====================================================================

    if ELP1==1 or ELP1==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh1', 
            preIntegrate=OFF, material='Matadh1', thicknessType=UNIFORM, 
            thickness=t1, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)


    if ELP2==1 or ELP2==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh2', 
            preIntegrate=OFF, material='Matadh2', thicknessType=UNIFORM, 
            thickness=t2, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)

    #Material orientation of Adherent1 and Adherent 2======================================
    p = mdb.models['Model-1'].parts['Part-1']
    f = p.faces
    faces = f.findAt(((L1/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-1'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    p = mdb.models['Model-1'].parts['Part-2']
    f = p.faces
    faces = f.findAt(((L2/10., w/10., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-2'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')




    #Section Assignment=======================================================================================
    if ELP1==1 or ELP1==2:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces1 = f.findAt(((L3/2.+L3/10., w/10., 0),))
        faces2 = f.findAt(((L3/10., w/10., 0),))
        faces3 = f.findAt(((L3/2., w/10., L1/10.),))
        faces=(faces1, )+(faces2, )
        faces1=(faces3, )
        region = p.Set(faces=faces,  name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Sectadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
        p.SectionAssignment(region=faces1, sectionName='Sectadh1', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP1==3:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces1 = f.findAt(((L3/2.+L3/10., w/10., 0),))
        faces2 = f.findAt(((L3/10., w/10., 0),))
        faces3 = f.findAt(((L3/2., w/10., L1/10.),))
        faces=(faces1, )+(faces2, )
        faces1=(faces3, )
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
        p.SectionAssignment(region=faces1, sectionName='Seccompadh1', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)


    if ELP2==1 or ELP2==2:
        p = mdb.models['Model-1'].parts['Part-2']
        f = p.faces
        faces = f.findAt(((0, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Sectadh2', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP2==3:
        p = mdb.models['Model-1'].parts['Part-2']
        f = p.faces
        faces = f.findAt(((0, w/2, 0),))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)

        

    if gradebehav==1:
        p = mdb.models['Model-1'].parts['Part-3']
        c = p.cells
        cells = c.findAt(((L3/2,w/2,t3/2),))
        cell=(cells,)
        p = mdb.models['Model-1'].parts['Part-3']
        p.SectionAssignment(region=cell, sectionName='Sectads', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif gradebehav==2:
        for i in range(nopart):
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            print(x1)
            cells = c.findAt(((x1,w/2,t3/2),))
            cell=(cells,)
            p = mdb.models['Model-1'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)
    elif gradebehav==3:
        for i in range(nopart):
            p = mdb.models['Model-1'].parts['Part-3']
            c = p.cells
            z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2
            cells = c.findAt(((L3/2,w/2,z1),))
            cell=(cells,)
            p = mdb.models['Model-1'].parts['Part-3']
            p.SectionAssignment(region=cell, sectionName='Sectads-'+str(i), offset=0.0, 
                offsetType=MIDDLE_SURFACE, offsetField='', 
                thicknessAssignment=FROM_SECTION)


    #Assembly==============================================
    a = mdb.models['Model-1'].rootAssembly
    a.DatumCsysByDefault(CARTESIAN)
    p = mdb.models['Model-1'].parts['Part-1']
    a.Instance(name='Part-1-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-2']
    a.Instance(name='Part-2-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-3']
    a.Instance(name='Part-3-1', part=p, dependent=OFF)


    a = mdb.models['Model-1'].rootAssembly
    p1 = a.instances['Part-2-1']
    p1.translate(vector=(0, 0.0, -t3))
    p2 = a.instances['Part-3-1']
    p2.translate(vector=(0, 0.0, -t3))

    #Step defenition=======================================================================
    if stp==1:
        mdb.models['Model-1'].StaticStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    else:
        mdb.models['Model-1'].ExplicitDynamicsStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')

    #Tying adhesive and adherents===================================================================================

    if gradebehav==1 or gradebehav==3:
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = (s1.findAt(((L3/5., w/2., 0),)), )+(s1.findAt(((L3/5.+L3/2., w/2., 0),)), )
        region1=a.Surface(side2Faces=side1Faces1, name='m_Surf-1')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2., w/2, 0),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-1')
        mdb.models['Model-1'].Tie(name='Constraint-1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side2Faces1 = s1.findAt(((L3/2., w/2, -t3),))
        region1=a.Surface(side1Faces=side2Faces1, name='m_Surf-3')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1 = s1.findAt(((L3/2., w/2, -t3),))
        region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-3')
        mdb.models['Model-1'].Tie(name='Constraint-2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
    elif  gradebehav==2:
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-1-1'].faces
        side1Faces1 = (s1.findAt(((L3/5., w/2., 0),)), )+(s1.findAt(((L3/5.+L3/2., w/2., 0),)), )
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-1')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, 0),))
            region2=(side1Faces1,)  
        mdb.models['Model-1'].Tie(name='Constraint-1', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-2-1'].faces
        side1Faces1 = s1.findAt(((L3/2, w/2., -t3),))
        region1=a.Surface(side1Faces=side1Faces1, name='m_Surf')
        a = mdb.models['Model-1'].rootAssembly
        s1 = a.instances['Part-3-1'].faces
        side1Faces1=[]
        for i in range(nopart):
            x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2
            side1Faces1.append(s1.findAt((x1, w/2, -t3),))
            region2=(side1Faces1, )      
        mdb.models['Model-1'].Tie(name='Constraint-2', master=region1, slave=region2, 
            positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
            thickness=ON)
    #Boundary Condition and Loading=========================================

    a = mdb.models['Model-1'].rootAssembly
    e1 = a.instances['Part-2-1'].edges
    edges1 = e1.findAt((((L3-L2)/2.,w/2., -t3),))
    edges2 = e1.findAt((((L3+L2)/2.,w/2., -t3),))
    region = (edges1,)+(edges2,)
    mdb.models['Model-1'].EncastreBC(name='BC-1', createStepName='Step-1', 
        region=region, localCsys=None)

    #==========================================================

    mdb.models['Model-1'].TabularAmplitude(name='Amp-1', timeSpan=STEP, 
        smooth=SOLVER_DEFAULT, data=((0.0, 0.0), (stptime, 1.0)))
    if LC==1:
        if 0==0:
            a = mdb.models['Model-1'].rootAssembly
            e1 = a.instances['Part-1-1'].edges
            edges1 = e1.findAt(((L3/2.,w/2, L1),))
            region = (edges1,)
            mdb.models['Model-1'].DisplacementBC(name='BC-3', createStepName='Step-1', 
                region=region, u1=0.0, u3=0.0, ur3=0, amplitude='Amp-1', fixed=OFF, 
                distributionType=UNIFORM, fieldName='', localCsys=None)
            mdb.models['Model-1'].boundaryConditions['BC-3'].move('Step-1', 'Initial')
            mdb.models['Model-1'].boundaryConditions['BC-3'].setValuesInStep(
                stepName='Step-1', u1=Ux, u2=Uy, u3=Uz)

    elif LC ==2:
         if Tx !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L3/2.,w/2, L1),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-6')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-1', createStepName='Step-1', 
                region=region, magnitude=Tx, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)        
             
         if Tz !=0:
            a = mdb.models['Model-2'].rootAssembly
            s1 = a.instances['Part-2-1'].edges
            side1Edges1 = s1.findAt(((L3-L2,w/2, t3),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-2'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Tz, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)        
             
         if Ty !=0:
            a = mdb.models['Model-2'].rootAssembly
            s1 = a.instances['Part-2-1'].edges
            side1Edges1 = s1.findAt(((L3-L2,w/2, t3),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-5')
            mdb.models['Model-2'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Ty, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)                    


##    if (Uz==0 and LC==1) or (Tz==0 and LC==2) :
##        a = mdb.models['Model-1'].rootAssembly
##        e1 = a.instances['Part-1-1'].edges
##        side1Edges1 = e1.findAt(((L3/2.,w/2, L1),))
##        mdb.models['Model-1'].ZsymmBC(name='BC-4', createStepName='Step-1', 
##            region=(side1Edges1, ), localCsys=None)






    #Meshing====================================================================
    a = mdb.models['Model-1'].rootAssembly
    partInstances =(a.instances['Part-1-1'], a.instances['Part-2-1'], 
        a.instances['Part-3-1'], )
    a.seedPartInstance(regions=partInstances, size=meshsize, deviationFactor=0.1, 
        minSizeFactor=0.1)


    if gradebehav !=3:
        e1 = a.instances['Part-3-1'].edges
        pickedEdges1 = e1.findAt(((0, 0, -t3/2),))
        pickedEdges2 = e1.findAt(((0, w, -t3/2),))
        pickedEdges=pickedEdges2+pickedEdges1
        a.seedEdgeBySize(edges=pickedEdges, size=meshthic, deviationFactor=0.1, 
            constraint=FINER)


    ##if QT==1:
    ##    a.setMeshControls(regions=partInstances, elemShape=QUAD_DOMINATED)
    ##else:
    ##    a.setMeshControls(regions=partInstances, elemShape=TRI)



    a.generateMesh(regions=partInstances)

    if stp==1:
        elemType1 = mesh.ElemType(elemCode=C3D20R, elemLibrary=STANDARD) 
        if nonlinmesh==1:
            if gradebehav==1:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                cells1 = c1.findAt((L3/2., w/2., -t3/2.),)
                pickedRegions =((cells1), )
                a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
            elif gradebehav==2:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                for i in range(nopart):
                    x1=(i)*float(L3)/(nopart)+float(L3)/(nopart)/2.
                    print(x1)
                    cells1 = c1.findAt(((x1,w/2,-t3/2),))
                    pickedRegions=((cells1),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))
            elif gradebehav==3:
                a = mdb.models['Model-1'].rootAssembly
                c1 = a.instances['Part-3-1'].cells
                for i in range(nopart):
                    z1=(i)*float(t3)/(nopart)+float(t3)/(nopart)/2.
                    print(z1)
                    cells1 = c1.findAt(((L3/2., w/2, -z1),))
                    pickedRegions=((cells1),)
                    a.setElementType(regions=pickedRegions, elemTypes=(elemType1,))


    #Job Creation====================================================================
    mdb.Job(name=jobname, model='Model-1', description='', type=ANALYSIS, 
        atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
        memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
        explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
        modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
        scratch='', multiprocessingMode=DEFAULT, numCpus=1, numGPUs=0)


    mdb.jobs[jobname].submit(consistencyChecking=OFF)
    mdb.jobs[jobname].waitForCompletion()
    mdb.saveAs('T-Joint'+'CAEfile')



    session.viewports['Viewport: 1'].assemblyDisplay.setValues(interactions=OFF, 
        constraints=OFF, connectors=OFF, engineeringFeatures=OFF)
    session.mdbData.summary()



    o3 = session.openOdb(name=a12)
    session.viewports['Viewport: 1'].setValues(displayedObject=o3)
    session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(
        CONTOURS_ON_DEF, ))




    bn=session.odbs[a12].rootAssembly.instances['PART-3-1'].nodes

    def nodfinder(x, y, z, nodassem):
        cvt=[]
        for i in range (len(bn)):
            dist=abs(nodassem[i].coordinates[0]-x)+ abs(nodassem[i].coordinates[1]-y)+ abs(nodassem[i].coordinates[2]-z)
            cvt.append(dist)
        n1=cvt.index(min(cvt))
        highlight(nodassem[n1])
        return n1

    nn1=nodfinder(0, w/2., -t3/2., bn)
    nn2=nodfinder(L3, w/2., -t3/2., bn)



    session.Path(name='Path-1', type=NODE_LIST, expression=(('PART-3-1', (nn1, 
            nn2, )), ))


    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        INVARIANT, 'Mises'))
    pth = session.paths['Path-1']
    session.XYDataFromPath(name='XYData-1', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)
    x0 = session.xyDataObjects['XYData-1']
    session.writeXYReport(fileName='M-TJOINT.txt', appendMode=OFF, xyData=(x0, ))


    #===================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S13'))

    session.XYDataFromPath(name='XYData-2', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x1 = session.xyDataObjects['XYData-2']
    session.writeXYReport(fileName='S-TJOINT.txt', appendMode=OFF, xyData=(x1, ))

    #============================================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S33'))


    session.XYDataFromPath(name='XYData-3', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=DEFORMED, 
        labelType=NORM_DISTANCE)

    x2 = session.xyDataObjects['XYData-3']
    session.writeXYReport(fileName='N-TJOINT.txt', appendMode=OFF, xyData=(x2, ))

elif jointtype==4:
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=STANDALONE)


    #Part1
    s1.rectangle(point1=(-L1/2., -L2/2.), point2=(L1/2., L2/2.))
    s1.rectangle(point1=(-L3/2., -L4/2.), point2=(L3/2., L4/2.))
    p = mdb.models['Model-1'].Part(name='Part-1', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-1']
    p.BaseShell(sketch=s1)
    s1.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-1']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']

    #Part2
    s = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s.geometry, s.vertices, s.dimensions, s.constraints
    s.setPrimaryObject(option=STANDALONE)
    s.rectangle(point1=(-L3/2., -L4/2.), point2=(L3/2., L4/2.))

    s.rectangle(point1=(-L5/2., -L6/2.), point2=(L5/2., L6/2.))
    p = mdb.models['Model-1'].Part(name='Part-2', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-2']
    p.BaseSolidExtrude(sketch=s, depth=t3)
    s.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-2']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']

    #Part3
    s1 = mdb.models['Model-1'].ConstrainedSketch(name='__profile__', 
        sheetSize=200.0)
    g, v, d, c = s1.geometry, s1.vertices, s1.dimensions, s1.constraints
    s1.setPrimaryObject(option=STANDALONE)
    s1.rectangle(point1=(-L5/2., -L6/2.), point2=(L5/2., L6/2.))
    p = mdb.models['Model-1'].Part(name='Part-3', dimensionality=THREE_D, 
        type=DEFORMABLE_BODY)
    p = mdb.models['Model-1'].parts['Part-3']
    p.BaseShell(sketch=s1)
    s1.unsetPrimaryObject()
    p = mdb.models['Model-1'].parts['Part-3']
    session.viewports['Viewport: 1'].setValues(displayedObject=p)
    del mdb.models['Model-1'].sketches['__profile__']
    #assembly==================================================================================
    a = mdb.models['Model-1'].rootAssembly
    session.viewports['Viewport: 1'].setValues(displayedObject=a)
    session.viewports['Viewport: 1'].assemblyDisplay.setValues(
        optimizationTasks=OFF, geometricRestrictions=OFF, stopConditions=OFF)

    a = mdb.models['Model-1'].rootAssembly
    a.DatumCsysByDefault(CARTESIAN)
    p = mdb.models['Model-1'].parts['Part-1']
    a.Instance(name='Part-1-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-2']
    a.Instance(name='Part-2-1', part=p, dependent=OFF)
    p = mdb.models['Model-1'].parts['Part-3']
    a.Instance(name='Part-3-1', part=p, dependent=OFF)

    p2 = a.instances['Part-3-1']
    p2.translate(vector=(0, 0.0, t3))

    #Lamina defenition=============================
    if ELP1==3 or ELP2==3:
        for i in range(Laminano):
            mdb.models['Model-1'].Material(name='Lam'+str(i+1))
            mdb.models['Model-1'].materials['Lam'+str(i+1)].Elastic(type=LAMINA, table=((Laminadata[i][0], 
               Laminadata[i][1], Laminadata[i][2], Laminadata[i][3], Laminadata[i][4], Laminadata[i][5]), ))
            if stp==2:
                mdb.models['Model-1'].materials['Lam'+str(i+1)].Density(table=((Laminadata[i][6], ), ))
    #Adherent1  material defenition================

    if ELP1==1 :
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==2:
        mdb.models['Model-1'].Material(name='Matadh1')
        mdb.models['Model-1'].materials['Matadh1'].Elastic(table=((Eadh1, vadh1), ))
        mdb.models['Model-1'].materials['Matadh1'].Plastic(table=((Syadh1, 0.0), (Syadh1, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh1'].Density(table=((Densadh1, ), ))
    elif ELP1==3:
        #Section of composite adherent1
        secLayadh1=[]
        for i in range (nolayadh1):
            gg=layupdataadh1[i][0]
            secLayadh1.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh1[i][1], orientAngle=layupdataadh1[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh1', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh1))



    #Adherent2 isotrope material defenition=====================================================
    if ELP2==1:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==2:
        mdb.models['Model-1'].Material(name='Matadh2')
        mdb.models['Model-1'].materials['Matadh2'].Elastic(table=((Eadh2, vadh2), ))
        mdb.models['Model-1'].materials['Matadh2'].Plastic(table=((Syadh2, 0.0), (Syadh2, 1.0)))
        if stp==2:
           mdb.models['Model-1'].materials['Matadh2'].Density(table=((Densadh2, ), ))
    elif ELP2==3:
    #Section of composite adherent1
        secLayadh2=[]
        for i in range (nolayadh2):
            gg=layupdataadh2[i][0]
            secLayadh2.append (section.SectionLayer(material='Lam'+str(int(gg)), thickness=layupdataadh2[i][1], orientAngle=layupdataadh2[i][2], numIntPts=3, plyName=''))
        mdb.models['Model-1'].CompositeShellSection(name='Seccompadh2', preIntegrate=OFF, 
            idealization=NO_IDEALIZATION, symmetric=False, thicknessType=UNIFORM, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, layup=tuple(secLayadh2))



    #Adhesive isotrope material defenition=============================================================

    if gradebehav == 1:
        mdb.models['Model-1'].Material(name='Materialads')
        mdb.models['Model-1'].materials['Materialads'].Elastic(table=((Eads, vads), ))
        if ELP==2:
            mdb.models['Model-1'].materials['Materialads'].Plastic(table=((Syads, 0.0), (Syads, 1.0)))
        if stp==2:
            mdb.models['Model-1'].materials['Materialads'].Density(table=((Densads, ), ))  

    #Section Cration of Adhesive======================================================================
    mdb.models['Model-1'].HomogeneousSolidSection(name='Sectads', material='Materialads', thickness=None)
        
    #Section cration of adherents=====================================================================

    if ELP1==1 or ELP1==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh1', 
            preIntegrate=OFF, material='Matadh1', thicknessType=UNIFORM, 
            thickness=t1, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)


    if ELP2==1 or ELP2==2:
        mdb.models['Model-1'].HomogeneousShellSection(name='Sectadh2', 
            preIntegrate=OFF, material='Matadh2', thicknessType=UNIFORM, 
            thickness=t2, thicknessField='', idealization=NO_IDEALIZATION, 
            poissonDefinition=DEFAULT, thicknessModulus=None, temperature=GRADIENT, 
            useDensity=OFF, integrationRule=SIMPSON, numIntPts=5)

    #Material orientation of Adherent1 and Adherent 2======================================
    p = mdb.models['Model-1'].parts['Part-1']
    f = p.faces
    faces = f.findAt(((L1/2.-L1/100.,L2/2-L2/100., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-1'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    p = mdb.models['Model-1'].parts['Part-3']
    f = p.faces
    faces = f.findAt(((L5/2.-L5/100.,L6/2-L6/100., 0),))
    region = regionToolset.Region(faces=faces)
    orientation=None
    mdb.models['Model-1'].parts['Part-3'].MaterialOrientation(region=region, 
        orientationType=GLOBAL, axis=AXIS_3, 
        additionalRotationType=ROTATION_NONE, localCsys=None, fieldName='')

    #Section Assignment=======================================================================================
    if ELP1==1 or ELP1==2:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2.-L1/100.,L2/2-L2/100., 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Sectadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP1==3:
        p = mdb.models['Model-1'].parts['Part-1']
        f = p.faces
        faces = f.findAt(((L1/2.-L1/100.,L2/2-L2/100., 0),))
        region = p.Set(faces=faces, name='Sectadh1')
        p.SectionAssignment(region=region, sectionName='Seccompadh1', offset=0.0, 
            offsetType=TOP_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)

    if ELP2==1 or ELP2==2:
        p = mdb.models['Model-1'].parts['Part-3']
        f = p.faces
        faces = f.findAt((((L5/2.-L5/100.,L6/2-L6/100., 0),)))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Sectadh2', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)
    elif ELP2==3:
        p = mdb.models['Model-1'].parts['Part-3']
        f = p.faces
        faces = f.findAt((((L5/2.-L5/100.,L6/2-L6/100., 0),)))
        region = p.Set(faces=faces, name='Sectadh2')
        p.SectionAssignment(region=region, sectionName='Seccompadh2', offset=0.0, 
            offsetType=BOTTOM_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION) 

    if gradebehav==1:
        p = mdb.models['Model-1'].parts['Part-2']
        c = p.cells
        cells = c.findAt(((L5/2.-L5/100.,L6/2-L6/10.,00),))
        cell=(cells,)
        p = mdb.models['Model-1'].parts['Part-2']
        p.SectionAssignment(region=cell, sectionName='Sectads', offset=0.0, 
            offsetType=MIDDLE_SURFACE, offsetField='', 
            thicknessAssignment=FROM_SECTION)

    #Step defenition=======================================================================
    if stp==1:
        mdb.models['Model-1'].StaticStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    else:
        mdb.models['Model-1'].ExplicitDynamicsStep(name='Step-1', previous='Initial',timePeriod=stptime)
        session.viewports['Viewport: 1'].assemblyDisplay.setValues(step='Step-1')
    #Tying adhesive and adherents=====================================================================
    #Tie adhesive and aherent 1


    a = mdb.models['Model-1'].rootAssembly
    s1 = a.instances['Part-1-1'].faces
    side1Faces1 = s1.findAt(((L1/2.-L1/100.,L2/2-L2/100., 0),))
    region1=a.Surface(side1Faces=side1Faces1, name='m_Surf-1')
    a = mdb.models['Model-1'].rootAssembly
    s1 = a.instances['Part-2-1'].faces
    side1Faces1 = s1.findAt(((L5/2.-L5/100.,L6/2-L6/100., 0),))
    region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-1')
    mdb.models['Model-1'].Tie(name='C1', master=region1, slave=region2, 
        positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
        thickness=ON)    

    #Tie adhesive and aherent 2
    a = mdb.models['Model-1'].rootAssembly
    s1 = a.instances['Part-3-1'].faces
    side1Faces1 = s1.findAt(((L5/2.-L5/100.,L6/2-L6/100., t3),))
    region1=a.Surface(side2Faces=side1Faces1, name='m_Surf-2')
    a = mdb.models['Model-1'].rootAssembly
    s1 = a.instances['Part-2-1'].faces
    side1Faces1 = s1.findAt(((L5/2.-L5/100.,L6/2-L6/100., t3),))
    region2=a.Surface(side1Faces=side1Faces1, name='s_Surf-2')
    mdb.models['Model-1'].Tie(name='C2', master=region1, slave=region2, 
        positionToleranceMethod=COMPUTED, adjust=ON, tieRotations=ON, 
        thickness=ON)  

    #Load and Boundary Condition================================================================================

    mdb.models['Model-1'].TabularAmplitude(name='Amp-1', timeSpan=STEP, 
        smooth=SOLVER_DEFAULT, data=((0.0, 0.0), (stptime, 1.0)))

    #Encaster--|
    a = mdb.models['Model-1'].rootAssembly
    e1 = a.instances['Part-1-1'].edges
    edges1 = e1.findAt((-L1/2., 0, 0),)

    ee=(edges1,) 
    mdb.models['Model-1'].EncastreBC(name='BC-0', createStepName='Step-1', region=ee, localCsys=None)


    if LC==1:
        a = mdb.models['Model-1'].rootAssembly
        e1 = a.instances['Part-1-1'].edges
        edges1 = e1.findAt(((L1/2., 0, 0),))
        region = (edges1,)
        mdb.models['Model-1'].DisplacementBC(name='BC-1', createStepName='Step-1', 
            region=region, u1=Ux, u2=Uy, u3=Uz, amplitude='Amp-1', fixed=OFF, 
            distributionType=UNIFORM, fieldName='', localCsys=None)
    elif LC==2:
        if Tx !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1/2.,0, 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-6')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-1', createStepName='Step-1', 
                region=region, magnitude=-Tx, distributionType=UNIFORM, field='', 
                localCsys=None, traction=NORMAL)            
        if Ty !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1/2.,0, 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-7')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-2', createStepName='Step-1', 
                region=region, magnitude=Ty, distributionType=UNIFORM, field='', 
                localCsys=None, traction=SHEAR)       
        if Tz !=0:
            a = mdb.models['Model-1'].rootAssembly
            s1 = a.instances['Part-1-1'].edges
            side1Edges1 = s1.findAt(((L1/2.,0, 0),))
            region = a.Surface(side1Edges=side1Edges1, name='Surf-8')
            mdb.models['Model-1'].ShellEdgeLoad(name='Load-3', createStepName='Step-1', 
                region=region, magnitude=Tz, distributionType=UNIFORM, field='', 
                localCsys=None, traction=TRANSVERSE)       
                  

    #Meshing====================================================================
    a = mdb.models['Model-1'].rootAssembly
    partInstances =(a.instances['Part-1-1'], a.instances['Part-2-1'], 
        a.instances['Part-3-1'], )
    a.seedPartInstance(regions=partInstances, size=meshsize, deviationFactor=0.1, 
        minSizeFactor=0.1)


    e1 = a.instances['Part-2-1'].edges
    pickedEdges1 = e1.findAt(((-L5/2.,-L6/2, t3/2.),))
    pickedEdges2 = e1.findAt(((L5/2., L6/2., t3/2.),))
    e1 = a.instances['Part-2-1'].edges
    pickedEdges3 = e1.findAt(((L5/2., -L6/2., t3/2.),))
    pickedEdges4 = e1.findAt(((-L5/2.,L6/2, t3/2.),))
    pickedEdges=pickedEdges2+pickedEdges1+pickedEdges3+pickedEdges4
    a.seedEdgeBySize(edges=pickedEdges, size=meshthic, deviationFactor=0.1, 
        constraint=FINER)


    ##if QT==1:
    ##    a.setMeshControls(regions=partInstances, elemShape=QUAD_DOMINATED)
    ##else:
    ##    a.setMeshControls(regions=partInstances, elemShape=TRI)
    ##


    a = mdb.models['Model-1'].rootAssembly
    f1 = a.instances['Part-1-1'].faces
    pickedRegions = (f1.findAt((L1/2.-L1/100, L2/2.-L2/100., 0),),)
    a.setMeshControls(regions=pickedRegions, algorithm=MEDIAL_AXIS)

    a = mdb.models['Model-1'].rootAssembly
    c1 = a.instances['Part-2-1'].cells
    pickedRegions = (c1.findAt((L5/2.-L5/100, L6/2.-L6/100., t3/2.),),)
    a.setMeshControls(regions=pickedRegions, algorithm=MEDIAL_AXIS)


    a = mdb.models['Model-1'].rootAssembly
    partInstances =(a.instances['Part-1-1'], a.instances['Part-2-1'], a.instances['Part-3-1'])
    a.generateMesh(regions=partInstances)



    mdb.saveAs('Patch'+'CAEfile')


    #JobCreation-----------------------------------------------------
    mdb.Job(name=jobname, model='Model-1', description='', type=ANALYSIS, 
        atTime=None, waitMinutes=0, waitHours=0, queue=None, memory=90, 
        memoryUnits=PERCENTAGE, getMemoryFromAnalysis=True, 
        explicitPrecision=SINGLE, nodalOutputPrecision=SINGLE, echoPrint=OFF, 
        modelPrint=OFF, contactPrint=OFF, historyPrint=OFF, userSubroutine='', 
        scratch='', multiprocessingMode=DEFAULT, numCpus=1, numGPUs=0)
    mdb.jobs[jobname].submit(consistencyChecking=OFF)
    session.mdbData.summary()

    mdb.jobs[jobname].waitForCompletion()



    #PostProcess============================================================
    o3 = session.openOdb(name=a42)
    session.viewports['Viewport: 1'].setValues(displayedObject=o3)
    session.viewports['Viewport: 1'].odbDisplay.display.setValues(plotState=(CONTOURS_ON_DEF, ))

    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(COMPONENT, 'S12'), )

    session.viewports['Viewport: 1'].odbDisplay.contourOptions.setValues(showMaxLocation=ON)


    bn1=session.odbs[a42].rootAssembly.instances['PART-2-1'].nodes


    def nodfinder(x, y, z, nodassem):
        cvt=[]
        for i in range (len(nodassem)):
            dist=abs(nodassem[i].coordinates[0]-x)+ abs(nodassem[i].coordinates[1]-y)+ abs(nodassem[i].coordinates[2]-z)
            cvt.append(dist)
        n1=cvt.index(min(cvt))
        highlight(nodassem[n1])
        return n1+1

    LLX=(L5-L3)/4.
    LLY=(L6-L4)/4.

    nn1=nodfinder(-L5/2.+LLX, -L6/2.+LLY, t3, bn1)
    nn2=nodfinder(L5/2.-LLX, -L6/2.+LLY,  t3, bn1)

    nn3=nodfinder(L5/2.-LLX, L6/2.-LLY, t3, bn1)
    nn4=nodfinder(-L5/2.+LLX, L6/2.-LLY, t3, bn1)
    nn5=nodfinder(-L5/2.+LLX, -L6/2.+LLY, t3, bn1)


    X1=(-L5/2.+LLX, -L6/2.+LLY, t3)
    X2=(L5/2.-LLX, -L6/2.+LLY,  t3)

    X3=(L5/2.-LLX, L6/2.-LLY, t3)
    X4=(-L5/2.+LLX, L6/2.-LLY, t3)
    X5=(-L5/2.+LLX, -L6/2.+LLY, t3)

    import displayGroupOdbToolset as dgo

    leaf = dgo.LeafFromPartInstance(partInstanceName=('PART-3-1', ))
    session.viewports['Viewport: 1'].odbDisplay.displayGroup.remove(leaf=leaf)
    leaf = dgo.LeafFromPartInstance(partInstanceName=('PART-1-1', ))
    session.viewports['Viewport: 1'].odbDisplay.displayGroup.remove(leaf=leaf)

    session.Path(name='Path-2', type=POINT_LIST, expression=(X1, X2, X3, X4, X5))



    session.Path(name='Path-1', type=NODE_LIST, expression=(('PART-2-1', (nn1,  nn2, nn3, nn4, nn5, )), ))



    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(INVARIANT, 'Mises'))
    pth = session.paths['Path-1']


    session.XYDataFromPath(name='XYData-1', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=UNDEFORMED, 
        labelType=NORM_DISTANCE)
    x0 = session.xyDataObjects['XYData-1']
    session.writeXYReport(fileName='MPatch.txt', appendMode=OFF, xyData=(x0, ))



    #===================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S13'))

    session.XYDataFromPath(name='XYData-2', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=UNDEFORMED, 
        labelType=NORM_DISTANCE)

    x2 = session.xyDataObjects['XYData-2']
    session.writeXYReport(fileName='SPatch.txt', appendMode=OFF, xyData=(x2, ))


    #============================================================
    session.viewports['Viewport: 1'].odbDisplay.setPrimaryVariable(
        variableLabel='S', outputPosition=INTEGRATION_POINT, refinement=(
        COMPONENT, 'S33'))


    session.XYDataFromPath(name='XYData-3', path=pth, includeIntersections=True, 
        pathStyle=PATH_POINTS, numIntervals=10, shape=UNDEFORMED, 
        labelType=NORM_DISTANCE)

    x4 = session.xyDataObjects['XYData-3']
    session.writeXYReport(fileName='NPatch.txt', appendMode=OFF, xyData=(x4, ))


























