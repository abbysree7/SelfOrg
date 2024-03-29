//Class Instatiation
Robot[] r=new Robot[1000];
int[] shapeX={1,3,5,7,9,11,4};
int[] shapeY={1,2,3,4,3,2,1};
int[] grids= new int[2*width*height];
int[] gradient=new int[(width*height)/5];


//Global Variables
int numofrobots=1000;
 
//Setup
void setup(){
  size(1000, 500);
  smooth();
  frameRate(78);
  
   //create robots
  for(int i=0;i<numofrobots;i++){
   r[i]=new Robot();
   fill(130);
   ellipseMode(CENTER);
   ellipse(r[i].x,r[i].y,2,2); 
  }
  //Display Robots
  for(int i=0;i<numofrobots;i++){
   r[i].display();
  }
}

//Looping
void draw(){
  background(255);
  showgradient();
  for(int i=0;i<numofrobots;i++){
    r[i].randomwalk();
    r[i].display();
  }
  if(int(random(height*width))%200==0){
//ratio of live robots
int liveratio=4;//4% of the robots are dead
  //kill robots
  int live = numofrobots*liveratio/100;
  for(int y=1;y<live;y++){
    int dead = int(random(numofrobots));
    r[dead].alive=false;
  }
  }
}

//Conditional Update
void update(){
  
}
void shapeDescription(){
     //Shape Description
    beginShape();
    for(int i=0;i<shapeX.length;i++)
      vertex(shapeX[i],shapeY[i]); 
    endShape(CLOSE);
    
}

void shapeFormation(){
  
  //If inside shape, don't go out
  
  //Form gradient map
 
  //
}

void showgradient(){
  strokeWeight(20);
  for(int i=0;i<width;i+=20){
    for(int j=0;j<height;j+=20){
      stroke(0,0,100,50);
      if((i>(width/3))&&(i<(2*width/3))&&(j>(height/3))&&(j<(2*height/3))){
       stroke((i*j)/2,0,0,50);
      } 
      point(i,j);
    }
  } 
}
