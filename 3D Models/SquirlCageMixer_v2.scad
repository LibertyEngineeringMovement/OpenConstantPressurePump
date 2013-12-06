//Build a simple hollow cup.
module scCup(){
difference(){
cylinder(h=40,r=45,center=true,$fa=0.01);
translate([0,0,2]) 
   cylinder(h=38,r=40,center=true,$fa=0.01);
}}

//Build a single dual angle blade
module singleBladeKO(){
union(){
translate([42.5,0,0]) rotate([0,0,-41]) cube([12.5,2.5,35],true);
rotate([0,0,-36]) 
translate([46.5,0,0]) 
rotate([0,0,-55]) 
cube([06,2.5,35],true);
}}

//Take the blade and spin it around
module manyBladesKO(){
for (i = [0:7.5:360]) {
rotate([0,0,i]) singleBladeKO();
}}

//manyBladesKO();

//Use the blades to cut the cup into a fan
module slottedCup(){
difference(){
scCup();
manyBladesKO();
}}

//Added a shallow cone for strength
module strongCup(){
union(){
slottedCup();
translate([0,0,-15]) 
   cylinder(h=5,r1=45,r2=2.5,center=true,$fa=0.01);
}}

//Add a cylinder for a motor spindal
module mountedCup(){
union(){
strongCup();
translate([0,0,-10]) 
   cylinder(h=15,r=5,center=true,$fa=0.01);
}}

//Core out the center, so that the motor spindal can fit through.
module scCore(){
difference(){
mountedCup();
translate([0,0,0]) 
   cylinder(h=41,r=3,center=true,$fa=0.01);
}}


module HousingPlate(z)
{
translate([0,0,z])
cylinder(h=2,r=53,center=true,$fa=0.01);
}

module BottomPlate()
{
HousingPlate(-22);
}

module TopPlate()
{
HousingPlate(22);
}

module WithDrillHole()
{
difference(){
BottomPlate();
translate([0,0,-22]) 
   cylinder(h=4,r=3,center=true,$fa=0.01);
}}

module WithVentHole()
{
difference(){
TopPlate();
translate([0,0,22]) 
   cylinder(h=4,r=22,center=true,$fa=0.01);
}}

module Shell(){
difference(){
cylinder(h=42,r=53,center=true,$fa=0.01);
translate([0,0,2]) 
   cylinder(h=50,r=51,center=true,$fa=0.01);
}}

module ShellCaps(){
WithDrillHole();
WithVentHole();
}

module ShellCaseCore(){
Shell();
ShellCaps();
}

module DuctShell()
{
translate([30,30,0]) 
cube(size = [42,60,42], center = true);
}

module DuctVent()
{
difference(){
difference(){
translate([30,30,0])cube(size = [46,60,46], center = true);
DuctShell();
}
cylinder(h=50,r=53,center=true,$fa=0.01);
}}

module ventedShell(){
difference(){
ShellCaseCore();
DuctShell();
}}

module screwmounts(){
translate([54,0,0]){
difference(){
cylinder(h=46,r=3.0,center=true,$fa=0.01);
cylinder(h=46,r=1.5,center=true,$fa=0.01);
}}}

module multipleScrewMounts(){
rotate(0,0,0) screwmounts();
rotate(120,0,0) screwmounts();
rotate(240,0,0) screwmounts();
}

module casingShell(){
union(){
union(){
ventedShell();
DuctVent();
}
multipleScrewMounts();
}}

module UpperCasing(){
difference(){
casingShell();
translate([0,0,-1]) cube(size=[120,120,44],center=true);
}}

module LowerCasing(){
difference(){
casingShell();
translate([0,0,22]) cube(size=[120,120,2],center=true);
}}


translate([0,0,2]) UpperCasing();
LowerCasing();

scCore();





