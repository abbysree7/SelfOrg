ParticleSystem ps; 
int j =0; 
void setup() { 
  size(500,400);
  ps = new ParticleSystem(new PVector(width/2,height/2)); 
  for (int i=1; i<50; i++) { 
    ps.addParticle(); 
  }

}

void draw() { 
background(0); 
ps.particlesCenter(); 
ps.moveParticles(); 
ps.display(); 
j+=1;
if (j == 200) { 
int randnum = round(random(1,2)); 
ps.sense(randnum); j=0; 
}
}

// A simple Particle class

class Particle { 
  PVector location; 
  PVector velocity; 
  PVector acceleration; 
  float lifespan;

  Particle(PVector l) { 
    velocity = new PVector(0,0); 
    location = l.get(); 
    lifespan = 255.0; 
  }

  void run(PVector change) { 
    update(change); 
    display(); 
  }

  // Method to update location 
  void update(PVector change) { 
    PVector error = new PVector(random(-1,1), random(-1,1)); 
    location.add(change); 
    location.add(error); 
    //lifespan -= 1.0;
  }

  // Method to display   
  void display() { 
    stroke(255,lifespan); 
    fill(255,lifespan); 
    ellipse(location.x,location.y,1,1); 
  } 
  void senseUpDown(float dtop) { 
    lifespan -= abs(location.y-dtop)*10; 
  }
  void senseRtLeft(float dleft) { 
    lifespan -= abs(location.x-dleft)*10;
  } // Is the particle still useful? 
  boolean isDead() {
    if (lifespan < 0.0) { 
      return true; 
    } else { 
      return false; 
    } 
  } 
}

// A class to describe a group of Particles 
// An ArrayList is used to manage the list of Particles

class ParticleSystem { 
  ArrayList<Particle> particles;
  PVector origin;
  PVector realorigin;

  ParticleSystem(PVector location) {
    origin = location.get();
    realorigin = origin;
    particles = new ArrayList<Particle>(); 
  }

  void addParticle() { 
    particles.add(new Particle(origin)); 
  } 
  void sense(int direction) {
    if (direction==1){
      float dtop = origin.y;
      line(origin.x, origin.y, origin.x, 0);
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i); 
        p.senseUpDown(dtop);
        if (p.isDead()) { 
          PVector newLoc = new PVector(p.location.x, origin.y); 
          particles.add(new Particle(newLoc));
          particles.remove(i);
        }
      } 
    }
    if (direction==2){ 
      float dleft = origin.x;
      line(origin.x, origin.y, 0, origin.y);
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i); p.senseRtLeft(dleft); 
        if (p.isDead()) { 
          PVector newLoc = new PVector(origin.x, p.location.y); 
          particles.add(new Particle(newLoc)); 
          particles.remove(i);

        } 
      } 
    } 
  } // Method to display
  void display() { 
    stroke(255); 
    fill(255,0,0); 
    ellipse(realorigin.x,realorigin.y,8,8); 
  }
  void moveParticles() { 
    PVector change = new PVector(random(-2,2),random(-2,2)); 
    origin.add(change); realorigin.add(change); 
    PVector error = new PVector(random(-1,1),random(-1,1)); 
    realorigin.add(error); 
    for (int i = particles.size()-1; i >= 0; i--) { 
      Particle p = particles.get(i); p.run(change); 
      if (p.isDead()) { particles.remove(i);
      } 
    } 
  } 
  void particlesCenter() { 
    float xaverage = 0; 
    float yaverage = 0; 
    for (int i = particles.size()-1; i >= 0; i--) { 
      Particle p = particles.get(i); 
      xaverage +=p.location.x; 
      yaverage +=p.location.y; 
    }
    xaverage = xaverage/particles.size(); 
    yaverage = yaverage/particles.size(); 
    stroke(255); 
    fill(0,255,0); 
    ellipse(xaverage,yaverage,8,8); 
  } 
}
