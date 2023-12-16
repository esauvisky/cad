// (c) by Gaston Gloesener 2014

//

// THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS

// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN

// THE SOFTWARE.
use <threads.scad>;

// List of known card types (sizes)
SD=0;
SDHC=SD;
SDXC=SD;
SDIO=SD;
CompactFlashI=1;

CFI=CompactFlashI;
CompactFlashII=2;
CFII=CompactFlashII;

CompactFlash=CompactFlashII; // Uses typ II to fit both types
CF=CompactFlash;

miniSD=3;
miniSDHC=miniSD;
miniSDIO=miniSD;
microSD=4;
microSDHC=microSD;
microSDXC=microSD;
MemoryStick=5;
MemoryStickPRO=MemoryStick;
MemoryStickDuo=6;
MemoryStickPRODuo=MemoryStickDuo;
MemoryStickPRO_HG=MemoryStickDuo;
MemoryStickDuoXC=MemoryStickDuo;
MemoryStickMicro=7;
MemoryStickMicroXC=MemoryStickMicro;

CardSizes=[ // Width, Length, Thickness, Name           , Short name

            [  24  ,    32  ,    2.1 ,   "SD Card"      , "SD" ],

            [  43  ,    36  ,    3.3 ,   "CF Type I"    , "CF I"  ],

            [  43  ,    36  ,    5   ,   "CF Type II"   , "CF II" ],

            [  20  ,    21.5,    1.4 ,   "miniSD"       , "minSD" ],

            [  11  ,    15  ,    1   ,   "microSD"      , "micSD" ],

            [  21.5,    50  ,    2.8 ,   "Memory Stick" , "MS" ],

            [  20  ,    31  ,    1.6 ,   "Memory Stick Duo", "MSduo" ],

            [  12.5,    15  ,    1.2 ,   "Memory Stick micro", "MSmic" ]

          ];


//********************************************************
// START OF CONFIGURATION AREA
//********************************************************

Build=0; // 0= tube & cover, 1=tube, 2=cover

// SD card
CardType=miniSD; // Card type from the above list of card types


// Note about the card slots: Card slots are aranged in a row side by side with

// a given space in-between. The size of the Tube is computed to fit this number

// of slots. At some point the required tube diameter is such that additional slots

// can be added in the other direction. The programm will also add those slots

// except if disabled.

Slots=4; // Number of card slots in the main row

AdditionalSlots=true; // Generate additional slots if the tube size allow for it

Space=2; // Space between two slots (mm)

CardTol=0.5; // Tolerance of the card size, i.e. additional size (mm) of

             // the slot for the card not to get stuck


// Cover Text (requires OpenSCAD 2014.QX as minimum with "text" module enabled

// in the settings
// 2 Lines of text can be written on the cover. If only one line is required

// CoverText" must be empty. Of course both can be left empty

// Note that special characters must be specified as Unicode using "\u"

CoverText1=str(Slots," ",CardSizes[CardType][4]);
CoverText2="";
CoverTextFont="Times New Roman"; // Font to be used (see Help->Font List in IoenSCAD menu)
CoverTextHeight=0; // Height of the letters above th ebaseline. If this is "0",

                   // it will default to 1/4 of the cover size



// Marker: If Marker is true, the first slot will be marked by a notch at the

// upper slot edge, to signal it as 1st slot. This may be used for example

// to store free an full cards at oposite ends of the box. This will of course

// require at least one unoccupied slot to be able to distinguish both.
Marker=true;

// Grabber: half-cylindrical hole allowing to grab the cards of the main row
// Note that not all combinations of width and depth do result in
// a valid grabber. Look in the output of the program for "Valid Grabber" and
// "Matching Grabber". Both should be "true". A grabber is valid if the
// computed grabber "tool" matches both requested depth and width. This is because
// the mathematical solution may not ,match the pratical one, which goal is to

// have a a round grabbing hole.
// With some combinations of width and depth the mathematical solution generates a cylinder
// radius which is less than the depth of the grabber. This is where "Valid Grabber" will
// yell false. However the programm does generate an additional cuboid ontop of the
// cylinder so that the grabber will still have the requested size, but not the expected round shape.
//
// The grabber is called matching if the requested sizes do not exceed the
// actually selected card dimensions.
Grabber=true;      // Set to false to disable grabber generation
GrabberWidth=10;   // Grabber Width (along the card) (mm)
GrabberWF=0.5;     // GrabberWF is used as factor of the card width,
                   // eg. GrabberWF=0.8 will make the grabber
                   // 0.8*CardSlotWidth
// Note: The actual grabber width is the maximum of GrabberWidth and
//       GrabberWF

GrabberD=3;  // Grabber depth (mm)
GrabberExtension=2; // The grabber is extended by default
                    // at the first and last slot by the "Space" amount
                    // The GrabberExtension allows to change this value
                    // and is added to the grabber length at both end.
                    // Eliminating the extension completely can be achieved
                    // by setting this variable to "-Space"

Material=2; // Required material thickness toward outside (mm)




// Screw parametres: These parameters determine the screw thread used to

// screw the cover on the tube.
ScrewTurns=3; // Number of turns to screw the cover on the tube

              // if 0, ScrewHeight will be used
// Thread pitch is the width of the thread, while the height is obviously

// the height of the same. Th eprogram uses the ThreadPitch to compute the thread,

// while it might be more trivial to establish the height. So the next 2

// parameters establish the height and then compute the pitch. So you may change

// the ThreadHeight, or set a value to the pitch wich will disable ThreadHeight.

// You should keep a copy of the ThreadHeight formula however if ever you want to

// revert to ThreadHeight.

// IMPORTANT NOTE: The thread height should not be chosen to high,

// to avoid the pinting software to generate any supporting structure for it.



ThreadHeight=2.165;

ThreadPitch=ThreadHeight*2/sqrt(3); //
// ScrewH: Screw height, being th espace in mm occupied by th escrew thread on

// the tube. This parameter is only used if ScrewTurns is 0, else the height is

// computed using the number of requested turns and th ethread pitch.

ScrewH=6;



// DO NOT CHANGE THE FOLLOWING LINE

ScrewHeight=(ScrewTurns>0)?(ThreadPitch*ScrewTurns):ScrewH;
// DO NOT CHANGE THE PREVIOUS LINE


CoverH=ScrewHeight; // Inner height (should be at least equal to ScrewHeight)
CoverTol=1;


// IMPORTANT Notes about the cover:

//  - The total cover height is CoverH+Material where "Material" is forming the

//    actual cover. Usually CoverH should be left at ScrewHeight to just fit the

//    thread

//  - CoverTol is the difference of the inner cover radius and the outer tube

//    radius. The smaller this tollerance the more difficult it may be to screw

//    the cover to the tube. If you change teh screw thread pitch or the tolerance

//    you must pay close attention that the tolerance remains below the thread

//    height (not ScrewHeight), otherwise the screw will not work. The actual

//    thread height can be found in the runtime output.


//********************************************************
// END OF CONFIGURATION AREA
//********************************************************

CardW=CardSizes[CardType][0];  // Width
CardL=CardSizes[CardType][1];  // Length
CardT=CardSizes[CardType][2]; // Thickness
CardSlotW=CardW+CardTol;
CardSlotL=CardL+CardTol;
CardSlotT=CardT+CardTol;

echo("Selected card type:",CardSizes[CardType][3]);
echo("Card Width/Length/Thickness:",CardW,CardL,CardT);

//***************************************************************************

// Radius of Grabber holing cylinder to accomodate width and depth

GrabberW=Grabber?max(GrabberWF*CardSlotW,GrabberWidth):0;
GrabberR=(4*GrabberD*GrabberD+GrabberW*GrabberW)/(8*GrabberD);

TubeH=CardSlotL+Material;

echo("Tolerance L/W/T=",CardSlotL-CardL,CardSlotW-CardW,CardSlotT-CardT);

function pitagores(a,b) = sqrt(a*a+b*b);
function pi() = 3.141592;
function circle_length(r) = 2*pi()*r;

RequiredSpace=Slots*CardSlotT+(Slots-1)*Space; // Required linear space for the cards
RqR=pitagores(RequiredSpace,CardSlotW)/2; // Resulting minimal radius

R=RqR+Material;
ThreadH=ThreadPitch*sqrt(3)/2;

echo("Screw thread ptich/height:",ThreadPitch,ThreadH);
ThreadD=2*(R+ThreadH); // Thread diameter for tube

CoverTH=CoverH+Material;
CoverRi=ThreadD/2+CoverTol;
CoverRo=R+ThreadH+Material;

CoverTextH=(CoverTextHeight>0)?CoverTextHeight:(CoverRo/4);

echo("Required,Rqr,R=",RequiredSpace,RqR,R);

module card(n,marker=false)
{
 if(n>=0)
  {
   translate([-RequiredSpace/2+(n-1)*(CardSlotT+Space)+CardSlotT/2,0,CardSlotL+Material])
    union()
     {
      cube([CardSlotT,CardSlotW,2*CardSlotL], center=true);
      if(marker)
         translate([0,CardSlotW/2+0.25*Space,0])
         cube([CardSlotT/3,Space,2*CardSlotL], center=true);
     }
  }
 else
  { // Additional slots arranged along Y axis (2 each time)
    translate([0,-(CardSlotW/2+Space*(-n)+CardSlotT*(-n-1)+CardSlotT/2),CardSlotL+Material])
     cube([CardSlotW,CardSlotT,2*CardSlotL], center=true);
    translate([0,+(CardSlotW/2+Space*(-n)+CardSlotT*(-n-1)+CardSlotT/2),CardSlotL+Material])
     cube([CardSlotW,CardSlotT,2*CardSlotL], center=true);
  }
}

module Tube()
{
  gr=R;

  // Check if additional slots can fit in vertical direction
  rqw=(CardSlotW+2*Material)/2; // Required width (half of it)
  // R^2=dc^2+rqw^2 (where R is the tube radius and dc the distance from the center where
  // this space is available
  dc=sqrt(R*R-rqw*rqw);
  nvt=floor((dc-CardSlotW/2)/(CardSlotT+Space)); // Number of slots that can be aranged in the other directioin (each side)
  nv=(nvt>=0 && AdditionalSlots)?nvt:0;
  echo("Requested slots:",Slots);
  echo("Additoal possible slots:", 2*nvt);
  echo("Additoal slots:", 2*nv);
  echo("Total slots:", Slots+2*nv);
  union()
   {
      for(c=[1:Slots]) card(c,Marker && c==1);
            if(nv>=1 && AdditionalSlots) for(c=[1:nv]) card(-c);
      // Grabber
            echo("Grabber W/D=",GrabberW,GrabberD," R=",GrabberR);
            echo("Valid Grabber:",(GrabberR*2>=GrabberW) && (GrabberR>=GrabberD));
            echo("Matching Grabber:",(GrabberW<=CardSlotW) && (GrabberD<=CardSlotL));

            if(GrabberW>0)
            {
        translate([0,0,TubeH+GrabberR-GrabberD])
              union()
                {
                rotate([0,90,0]) cylinder(r=GrabberR,h=RequiredSpace+2*(Space+GrabberExtension),center=true,$fn=4*pi()*GrabberR);
                translate([0,0,2*GrabberR]) cube([RequiredSpace+2*(Space+GrabberExtension),2*GrabberR,4*GrabberR],center=true);
                }
            }
      }
}

module CoverText()
{
  t1x=0;
  t1y=(len(CoverText2)>0)?(CoverTextH*1):0;
  t2x=0;
  t2y=(len(CoverText2)>0)?(-CoverTextH*1):0;
  if(len(CoverText1)>0)
  {
   translate([0,0,CoverTH-Material/2]) union()
   {
    translate([t1x,t1y,0]) linear_extrude(height=Material) text(text=CoverText1,size=CoverTextH,
         font=CoverTextFont,
         halign="center",valign="center");
    if(len(CoverText2)>0)
    {
     translate([t2x,t2y,0]) linear_extrude(height=Material) text(text=CoverText2,size=CoverTextH,
         font=CoverTextFont,
         halign="center",valign="center");
    } // if
   } // union
  }
}

module Cover()
{
 translate([0,0,CoverTH]) // Recover plane alignment
  rotate([180,0,0]) // Correct orientation for printing
   difference()
    {
     cylinder(r=CoverRo,h=CoverTH,$fn=36);
     union()
      {
        metric_thread(2*CoverRi,ThreadPitch,ScrewHeight,internal=true);
        CoverText();
      }
    }
}

echo("Tube Diameter=",R*2);
echo("Tube height=",TubeH);

if(Build==0 || Build==1) Tube();
// if(Build==0 || Build==2) translate([(Build==0)?2.5*R:0,0,0]) Cover();
