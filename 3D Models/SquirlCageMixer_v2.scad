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
   cylinder(h=41,r=2.5,center=true,$fa=0.01);
}}

scCore();


