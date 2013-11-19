module scCup(){
difference(){
cylinder(h=40,r=25,center=true,$fa=0.01);
translate([0,0,2]) 
   cylinder(h=38,r=20,center=true,$fa=0.01);
}}

module singleBladeKO(){
union(){
translate([22.5,0,0]) rotate([0,0,-41]) cube([12.5,2.5,35],true);
rotate([0,0,-25]) 
translate([26.5,0,0]) 
rotate([0,0,-55]) 
cube([06,2.5,35],true);
}}

module manyBladesKO(){
for (i = [0:15:360]) {
rotate([0,0,i]) singleBladeKO();
}}

//manyBladesKO();

module slottedCup(){
difference(){
scCup();
manyBladesKO();
}}

module strongCup(){
union(){
slottedCup();
translate([0,0,-15]) 
   cylinder(h=5,r1=25,r2=2.5,center=true,$fa=0.01);
}}

module mountedCup(){
union(){
strongCup();
translate([0,0,-10]) 
   cylinder(h=15,r=5,center=true,$fa=0.01);
}}

module scCore(){
difference(){
mountedCup();
translate([0,0,0]) 
   cylinder(h=41,r=2.5,center=true,$fa=0.01);
}}

scCore();


