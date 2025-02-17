use <triangulation.scad>;

// written for tail-recursion
// _subtotals[i] = list[0] + ... + list[i-1]
function _subtotals(list,soFar=[]) =
        len(soFar) >= 1+len(list) ? soFar :
        _subtotals(list,
            let(n1=len(soFar))
            concat(soFar, n1>0 ? soFar[n1-1]+list[n1-1] : 0));

function _flatten(list) = [for (a=list) for(b=a) b];

function _reverseTriangle(t) = [t[2], t[1], t[0]];

function _reverse(v) = [for(i=[len(v)-1:-1:0]) v[i]];

function _mod(a,b) =
    let (m=a%b)
    m < 0 ? b+m : m;

// smallest angle in triangle
function _minAngle(p1,p2,p3) =
    let(a = p2-p1,
        b = p3-p1,
        c = p3-p2,
        v1 = a*b,
        v2 = -(c*a))
        v1 == 0 || v2 == 0 ? 0 :
        let( na = norm(a),
             a1 = acos(v1 / (na*norm(b))),
             a2 = acos(v2 / (na*norm(c))) )
        min(a1,a2,180-(a1+a2));

// triangulate square to maximize smallest angle
function _doSquare(points,i11,i21,i22,i12,optimize=1) =
    points[i11]==points[i12] ? [[i11,i21,i22]] :
    points[i21]==points[i22] ? [[i22,i12,i11]] :
    !optimize ? [[i11,i21,i22], [i22,i12,i11]] :
    let (m1 = min(_minAngle(points[i11],points[i21],points[i22]), _minAngle(points[i22],points[i12],points[i11])),
        m2 = min(_minAngle(points[i11],points[i21],points[i12]),
                _minAngle(points[i21],points[i22],points[i12])) )
        m2 <= m1 ? [[i11,i21,i22], [i22,i12,i11]] :
                  [[i11,i21,i12], [i21,i22,i12]];

/*
function _inTriangle(v1,t) = (v1==t[0] || v1==t[1] || v1==t[2]);

function _findTheDistinctVertex(t1,t2) =
    let(in = [for(i=[0:2]) _inTriangle(t1[i],t2)])
    ! in[0] && in[1] && in[2] ? 0 :
    ! in[1] && in[0] && in[2] ? 1 :
    ! in[2] && in[0] && in[1] ? 2 :
    undef;

// make vertex i come first
function _rotateTriangle(t,i) =
    [for (j=[0:2]) t[(j+i)%3]];

function _optimize2Triangles(points,t1,t2) =
    let(i1 = _findTheDistinctVertex(t1,t2))
    i1 == undef ? [t1,t2] :
    let(i2 = _findTheDistinctVertex(t2,t1))
    i2 == undef ? [t1,t2] :
    _doSquare(points,t1[(i1+2)%3],t1[i1],t2[(i2+2)%3],t2[i2],optimize=1);

// a greedy optimization for a strip of triangles most of which adjoin one another; written for tail-recursion
function _optimizeTriangles(points,triangles,position=0,optimize=1,iterations=4) =
        !optimize || position >= iterations*len(triangles) ? triangles :
            _optimizeTriangles(points,
                let(
                    n = len(triangles),
                    position1=position%n,
                    position2=(position+1)%n,
                    opt=_optimize2Triangles(points,triangles[position1],triangles[position2]))
                    [for (i=[0:len(triangles)-1])
                        i == position1 ? opt[0] :
                        i == position2 ? opt[1] :
                            triangles[i]],
                position=position+1);
*/

function _removeEmptyTriangles(points,triangles) =
    [for(t=triangles)
        if(points[t[0]] != points[t[1]] && points[t[1]] != points[t[2]] && points[t[2]] != points[t[0]]) t];

// tail recursion
function _getClosest(points,index,count,ref,best=[undef,undef])
        = count <= 0 ? (best[0]==undef ? index : best[0]) :
          _getClosest(points,index+1,count-1,ref,
            best = best[0] == undef ||
            norm(points[index]-ref) < best[1] ?
            [index,norm(points[index]-ref)] : best);

function _getIndices(points,index1,n1,index2,n2,shift,i,optimize) =
        let (i1=[index2+_mod(i+shift,n2),
                 index2+_mod(i+1+shift,n2)])
        optimize < 0 ?
        [[_getClosest(points,index1,n1,points[i1[0]]),
          _getClosest(points,index1,n1,points[i1[1]])],
          i1] :
        [[index1+floor(i*n1/n2+0.5)%n1,
         index1+floor(((i+1)%n2)*n1/n2+0.5)%n1],
         i1];

// n1 and n2 should be fairly small, so this doesn't need
// tail-recursion
// this assumes n1<=n2
function _tubeSegmentTriangles0(points,index1,n1,index2,n2,shift=0,i=0,soFar=[],optimize=1)
    = i>=n2 ? _removeEmptyTriangles(points,soFar) :
            let(ii = _getIndices(points,index1,n1,index2,n2,shift,i,optimize),
                add = ii[0][0] == ii[0][1] ? [[ii[0][0],ii[1][0],ii[1][1]]] :
                    _doSquare(points,ii[0][0],ii[1][0],ii[1][1],ii[0][1],optimize=optimize))
                _tubeSegmentTriangles0(points,index1,n1,index2,n2,i=i+1,soFar=concat(soFar,add),shift=shift,optimize=optimize);

function _measureQuality(points, triangles, pos=0, sumThinnest=1e100) =
    pos >= len(triangles) ? sumThinnest :
        _measureQuality(points, triangles, pos=pos+1, sumThinnest=min(sumThinnest,_minAngle(points[triangles[pos][0]],points[triangles[pos][1]],points[triangles[pos][2]])));

function _bestTriangles(points,tt, pos=0, best=[0,-1/0]) =
        pos >= len(tt) || len(tt)<=1 ? tt[best[0]] :
        _bestTriangles(points, tt, pos=pos+1,
            best = let(q=_measureQuality(points,tt[pos]))
                        q>best[1] ? [pos,q] : best);

function _getMaxShift(o) = (!o || o==true || o < 0) ? 0 : o-1;

function _tubeSegmentTriangles(points,index1,n1,index2,n2,optimize=1) =
    _bestTriangles(points,[for (shift=[-_getMaxShift(optimize):_getMaxShift(optimize)]) _tubeSegmentTriangles0(points,index1,n1,index2,n2,shift=shift,optimize=optimize)]);

function _tubeSegmentFaces(points,index,n1,n2,optimize=1)
    = n1<n2 ? _tubeSegmentTriangles(points,index,n1,index+n1,n2,optimize=optimize) :
        [for (f=_tubeSegmentTriangles(points,index+n1,n2,index,n1,optimize=optimize)) _reverseTriangle(f)];

function _tubeMiddleFaces(points,counts,subtotals,optimize=1) = [ for (i=[1:len(counts)-1])
           for (face=_tubeSegmentFaces(points,subtotals[i-1],counts[i-1],counts[i],optimize=optimize)) face ];

function _endCap(points,indices,triangulate) = triangulate ? triangulate(points,indices) : [indices];

function _endCaps(points,counts,subtotals,startCap=true,endCap=true,triangulate=false) =
    let( n = len(counts),
         cap1 = counts[0]<=2 || !startCap ? [] : _endCap(points, [for(i=[0:counts[0]-1]) i], triangulate),
         cap2 = counts[n-1]<=2 || !endCap ? [] : _endCap(points, [for(i=[counts[n-1]-1:-1:0]) subtotals[n-1]+i], triangulate))
         concat(cap1,cap2);

function _tubeFaces(sections,startCap=true,endCap=true,optimize=1,triangulateEnds=false) =
                let(
        counts = [for (s=sections) len(s)],
        points = _flatten(sections),
        subtotals = _subtotals(counts))
            concat(_tubeMiddleFaces(points,counts,subtotals,optimize=optimize),_endCaps(points,counts,subtotals,startCap=startCap,endCap=endCap,triangulate=triangulateEnds));

function _removeDuplicates1(points,soFar=[[],[]]) =
        len(soFar[0]) >= len(points) ? soFar :
            _removeDuplicates1(points,
               let(
                mapSoFar=soFar[0],
                pointsSoFar=soFar[1],
                j=len(mapSoFar),
                k=search([points[j]], pointsSoFar)[0])
                k == []? [concat(mapSoFar,[len(pointsSoFar)]),
                            concat(pointsSoFar,[points[j]])] :
                           [concat(mapSoFar,[k]),pointsSoFar]);

function _removeDuplicates(points, faces) =
    let(fix=_removeDuplicates1(points),
        map=fix[0],
        newPoints=fix[1],
        newFaces=[for(f=faces) [for(v=f) map[v]]])
            [newPoints, newFaces];

function pointsAndFaces(sections,startCap=true,endCap=true,optimize=1,triangulateEnds=false) =
        let(
            points0=_flatten(sections),
            faces0=_tubeFaces(sections,startCap=startCap,endCap=endCap,optimize=optimize,triangulateEnds=triangulateEnds))
        _removeDuplicates(points0,faces0);

function sectionZ(section,z) = [for(xy=section) [xy[0],xy[1],z]];
function sectionX(section,x) = [for(yz=section) [x,yz[0],yz[1]]];
function sectionY(section,y) = [for(xz=section) [xz[0],y,xz[1]]];


function shiftSection(section,delta) = [for(p=section) [for(i=[0:len(delta)-1]) (p[i]==undef?0:p[i])+delta[i]]];

// the optimize parameter can be:
//   -1: nearest neighbor mesh optimization; this can produce meshes that are not watertight, and hence is not recommended unless you know what you are doing
//   0: no optimization at all
//   1: minimal optimization at the quad level
//   n>1: shift corresponding points in different layers by up to n-1 points to try to have the best triangles
module tubeMesh(sections,startCap=true,endCap=true,optimize=1,triangulateEnds=false) {
    pAndF = pointsAndFaces(sections,startCap=startCap,endCap=endCap,optimize=optimize,triangulateEnds=triangulateEnds);
    polyhedron(points=pAndF[0],faces=pAndF[1]);
}

// increase number of points from len(section) to n
function _interpolateSection(section,n) =
        let(m=len(section))
        n == m ? section :
        n < m ? undef :
            [for(i=[0:m-1])
                let(cur=floor(i*n/m),
                    k=floor((i+1)*n/m)-cur,
                    i2=(i+1)%m)
                    for(j=[0:k-1])
                        let(t=j/k)
                            section[i]*(1-t)+section[i2]*t];

function arcPoints(r=10,d=undef,start=0,end=180,center=[0,0]) =
            let(r=d==undef?r:d/2,
                n=getPointsAround(abs(end-start)))
                    [for(i=[0:n])
                        let(angle=start+i*(end-start)/n) center+r*[cos(angle),sin(angle)]];

function _segment(z0,z1,count) =
    [for(i=[0:count-1]) let(t=i/count) (1-t)*z0+t*z1];

function squarePoints(s,n=4) =
    let(xy = is_list(s) ? s : [s,s],
        perSide = n < 4 ? 1 : floor((n+2)/4))
        concat( _segment( [xy[0]/2,xy[1]/2], [-xy[0]/2,xy[1]/2], perSide),
    _segment( [-xy[0]/2,xy[1]/2], [-xy[0]/2,-xy[1]/2], perSide),
    _segment( [-xy[0]/2,-xy[1]/2], [xy[0]/2,-xy[1]/2], perSide),
    _segment( [xy[0]/2,-xy[1]/2], [xy[0]/2,xy[1]/2], perSide));

function roundedRectPoints(wh,radius=5,n=60,$fn=30) =
    [for(i=[0:$fn-1])
        let(angle = i / $fn * 360,
            s = angle <= 90 ? [1,1] :
                angle <= 180 ? [-1,1] :
                angle <= 270 ? [-1,-1] :
                [1,-1])
            [s[0]*(wh[0]/2-radius)+radius*cos(angle),s[1]*(wh[1]/2-radius)+radius*sin(angle)]];

function interpolateSection(pp,n=32) =
        n<=len(pp) ? pp :
        let(count=1+ceil((n-len(pp))/len(pp)))
        echo(count)
        [for(i=[0:len(pp)-1])
            for(j=[0:count-1])
                let(t=j/count,p1=pp[i],p2=pp[(i+1)%len(pp)])
                    (1-t)*p1+t*p2];
function roundedSquarePoints(wh=[10,10],radius=1,center=false,$fn=16) =
    let(dx = center ? 0 : wh[0]/2,
        dy = center ? 0 : wh[1]/2)
    [
    for (segment=[
        [wh[0]/2-corner,wh[1]/2-corner,0],
        [-wh[0]/2+corner,wh[1]/2-corner,90],
        [-wh[0]/2+corner,-wh[1]/2+corner,180],
        [wh[0]/2-corner,-wh[1]/2+corner,270] ])
        for (i=[0:$fn/4])
            let(angle=i/($fn/4)*90+segment[2])
                [dx+segment[0]+corner*cos(angle),dy+segment[1]+corner*sin(angle)]  ];

function ngonPoints(n=4,r=10,d=undef,rotate=0,z=undef) =
            let(r=d==undef?r:d/2)
            z==undef ?
            r*[for(i=[0:n-1]) let(angle=i*360/n+rotate) [cos(angle),sin(angle)]] :
            [for(i=[0:n-1]) let(angle=i*360/n+rotate) [r*cos(angle),r*sin(angle),z]];

function starPoints(n=10,r1=5,r2=10,rotate=0,z=undef) =
          z==undef ?
            [for(i=[0:2*n-1]) let(angle=i*180/n+rotate) (i%2?r1:r2) * [cos(angle),sin(angle)]] :
            [for(i=[0:2*n-1]) let(angle=i*180/n+rotate, r=i%2?r1:r2) [r*cos(angle),r*sin(angle),z]];

function roundedSquarePoints(size=[10,10],radius=2,z=undef) =
    let(n=$fn?$fn:32,
        x=len(size)>=2 ? size[0] : size,
        y=len(size)>=2 ? size[1] : size,
        centers=[[x-radius,y-radius],[radius,y-radius],[radius,radius],[x-radius,radius]],
        section=[for(i=[0:n-1])
            let(center=centers[floor(i*4/n)],
                angle=360*i/n)
            center+radius*[cos(angle),sin(angle)]])
        z==undef ? section : sectionZ(section,z);

function getPointsAround(radius, angle=360) =
    max(3, $fn ? ceil($fn*angle/360) :
        max(floor(0.5+angle/$fa), floor(0.5+2*radius*PI*angle/360/$fs)));

// warning: no guarantee of perfect convexity
module mySphere(r=10,d=undef) {
    GA = 2.39996322972865332 * 180 / PI;
    radius = d==undef ? r : d/2;
    pointsAround = getPointsAround(radius);
    numSlices0 = (pointsAround + pointsAround % 2)/2;
    numSlices = numSlices0 + (numSlices0%2);
    sections = radius*[for(i=[0:numSlices])
                    i == 0 ? [[0,0,-1]] :
                    i == numSlices ? [[0,0,1]] :
                    let(
                        lat = (i-numSlices/2)/(numSlices/2)*90,
                        z1 = sin(lat),
                        r1 = cos(lat),
                        count = max(3,floor(0.5 + pointsAround * abs(r1))))
                        ngonPoints(count,r=r1,z=z1)];
    data = pointsAndFaces(sections,optimize=-1);
    polyhedron(points=data[0], faces=data[1]);
}

function twistSectionXY(section,theta,autoShift=false) =
    let(
    n = len(section),
    shift=autoShift ? floor(n*_mod(theta,360)/360) : 0)
    [for (a=[0:len(section)-1])
        let(p=section[_mod(a-shift,n)])
        [for(i=[0:len(p)-1])
        i == 0 ? p[0]*cos(theta)-p[1]*sin(theta) :
        i == 1 ? p[0]*sin(theta)+p[1]*cos(theta) :
        p[i]]];

module morphExtrude(section1,section2=undef,height=undef,twist=0,numSlices=10,curve="t",curveParams=[[]],startCap=true,endCap=true,optimize=1,triangulateEnds=false) {

    section2 = section2==undef ? section1 : section2;

    fc = curve == "t" ? "t" : compileFunction(curve);
    function getCurve(t) = (curve=="t" ? t : eval(fc,concat([["t",t]],curveParams)));

    n = max(len(section1),len(section2));

    section1interp = _interpolateSection(section1,n);
    section2interp = _interpolateSection(section2,n);
    sections = height == undef ?
                      [for(i=[0:numSlices])
                        let(t=i/numSlices)
                        (1-t)*section1interp+t*section2interp] :
                      [for(i=[0:numSlices])
                        let(t=i/numSlices,
                            t1=getCurve(t),
                            theta = -t*twist,
                            section=(1-t1)*section1interp+t1*section2interp)
                        twistSectionXY(sectionZ(section,height*t),theta)];

    tubeMesh(sections,startCap=startCap,endCap=endCap,optimize=optimize,triangulateEnds=triangulateEnds);
}

module cone(r=10,d=undef,height=10) {
    radius = d==undef ? r : d/2;

    pointsAround = getPointsAround(radius);

    morphExtrude(ngonPoints(n=pointsAround,r=radius), [[0,0]], height=height,optimize=0);
}

module prism(base=[[0,0,0],[1,0,0],[0,1,0]], vertical=[0,0,1]) {
    morphExtrude(base,[for(v=base) v+vertical],numSlices=1);
}

//<skip>
translate([15,0,0]) morphExtrude(ngonPoints(30,d=6), ngonPoints(2,d=4), height=10);

// for some reason this gives a CGAL error if we put in r1=0 and endCap=false
translate([24,0,0]) morphExtrude(ngonPoints(30,r=3), starPoints(4,r1=0.001,r2=4), height=10);
mySphere($fn=130,r=10);
translate([36,0,0]) morphExtrude(ngonPoints(4,r=4),ngonPoints(4,r=4,rotate=45),height=10);
//translate([46,0,0]) morphExtrude([ [0,0], [20,0], [20,10], [0,10] ], [ [ 10,5 ] ], height=20, curve="sin(90*t)" );
translate([80,0,0]) morphExtrude([ [0,0], [20,0], [20,10], [0,10] ], [ [ 10,5 ] ], height=20, twist=90);
//</skip>
