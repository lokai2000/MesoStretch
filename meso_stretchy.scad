
mesosegsY  = 5; 
mesosegsX  = 20; 

mesodiam   = 3;
mesodis    = 6;
mesowidth  = 0.8;
mesoheight = 5;

$fn=32;

module seg(X,Y,top=1, down=0, left=0, right=1 ){
  
  deltaX  = mesodiam - mesowidth;
  offsetX = deltaX * X;
  deltaY  = mesodiam + mesodis;
  offsetY = deltaY * Y;

  
  if (top>=1) {
    difference(){
      translate([mesodiam/2+offsetX,mesodiam/2+offsetY]) circle(d=mesodiam);
      translate([mesodiam/2+offsetX,mesodiam/2+offsetY]) circle(d=mesodiam-2*mesowidth);
      translate([mesodiam/2+offsetX,mesodiam+offsetY]) square(size=mesodiam,center=true);
    }
  }

  if (down>=1) {
    difference(){
      translate([mesodiam/2+offsetX,mesodiam/2+offsetY+mesodis]) circle(d=mesodiam);
      translate([mesodiam/2+offsetX,mesodiam/2+offsetY+mesodis]) circle(d=mesodiam-2*mesowidth);
      translate([mesodiam/2+offsetX,offsetY+mesodis]) square(size=mesodiam,center=true);
    }
  }
  
  if (left==1) {
    translate([offsetX,offsetY+mesodiam/2]) square([mesowidth,mesodis]);
    if (top>=2){
      translate([offsetX,offsetY+mesodiam/2+mesodis]) square([mesowidth,mesodiam/2]);      
    }
    if (down>=2){
      translate([offsetX,offsetY]) square([mesowidth,mesodiam/2]);      
    }
  }
  if (right==1) {
    translate([offsetX+mesodiam-mesowidth,offsetY+mesodiam/2]) square([mesowidth,mesodis]);
    if (top>=3){
      translate([offsetX+mesodiam-mesowidth,offsetY+mesodiam/2+mesodis]) square([mesowidth,mesodiam/2]);      
    }
    if (down>=3){
      translate([offsetX+mesodiam-mesowidth,offsetY]) square([mesowidth,mesodiam/2]);      
    }
  }
    
} 


module mesoLine(Y){
  
  if ( (Y%2) == 0) {
    seg(0,Y,2,0,1,1);
    for (i=[1:mesosegsX-1]){
      if ( (i%2) == 1 ){
        if (i==mesosegsX-1){
          seg(i,Y,0,3,0,1);
        } else {
          seg(i,Y,0,1,0,1);
        }
      } else {
        if (i==mesosegsX-1){
          seg(i,Y,3,0,0,1);
        } else {
          seg(i,Y,1,0,0,1);
        }
      }
    }    
  } else {
    seg(0,Y,0,2,1,1);
    for (i=[1:mesosegsX-1]){
      if ( (i%2) == 1 ){
        if (i==mesosegsX-1){
          seg(i,Y,3,0,0,1);
        } else {
          seg(i,Y,1,0,0,1);
        }
      } else {
        if (i==mesosegsX-1){
          seg(i,Y,0,3,0,1);
        } else {
          seg(i,Y,0,1,0,1);
        }
      }
    }    
  }
  
}

module mesoStretchBase(){
  
  deltaX  = mesodiam - mesowidth;
  deltaY  = mesodiam + mesodis;

  for (j=[0:mesosegsY-1]){
    mesoLine(j);
  }
  for (j=[1:mesosegsY-1]){
    for (i=[0:mesosegsX-1]){
      if ((j%2)==0){
        if ( (i%2) == 0 ){
          translate([mesodiam/2 + deltaX * i, deltaY * j]) circle(d=mesowidth);
        }
      } else {
        if ( (i%2) == 1 ){
          translate([mesodiam/2 + deltaX * i, deltaY * j]) circle(d=mesowidth);
        }
      }
    }
  }
}

module mesoStretch(){
  linear_extrude(height=mesoheight, center=false) mesoStretchBase();
}


mesoStretch();

