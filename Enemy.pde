PImage spaceship,spaceship2,spaceship3; //creates the three PImage variables needed for the three images of the spaceships (different coloured lights)

class Enemy //The class for the enemies/spaceships
{
  float x, y; //defining the variables that will be included in the constructor of the enemy class
  int counter = 0; //counter to be used to change the image when running the animation sequence of the spaceships 
  int speed; //defines the speed variable that will be included in the constructor the this enemy class
  
  Enemy(float x, float y, int speed) //This is the constructor for the Enemy class, passing it the three values that will be used, x coord, y coord and speed
  {
    spaceship = loadImage("spaceship.png"); //following six lines of code will define the PImage variables that were created above and assign them to the relevant images, and then resize them all to be of size 80, 50
    spaceship2 = loadImage("spaceship2.png"); //
    spaceship3 = loadImage("spaceship3.png"); //
    spaceship.resize(80, 50); //
    spaceship2.resize(80, 50); // 
    spaceship3.resize(80, 50); //
    this.x = x; //Saying the x value used by the Enemy is the one that is being passed into the constructor 
    this.y = y; //Saying the y value used by the Enemy is the one that is being passed into the constructor 
    this.speed = speed; //Saying the speed value used by the Enemy is the one that is being passed into the constructor 
  }

  void update() //method that will be called each draw method to update the position of the enemy and then render it in the new position
  {
    render();
    move();
  }

  void render() //method to display the image of the enemy
  {
    image(spaceship, x, y); 
    if (counter >= 0 && counter <= 30) //if the counter that is being defined at the top is between 0 and 30 it will display the first spaceship image
    {
      image(spaceship, x, y);
    } 
    else if (counter > 30 && counter <= 60) //else if the counter is between 30 and 60 it will display the second image of the spaceship
    {
      image(spaceship2, x, y);
    } 
    else if (counter > 60 && counter <= 90) //else if the counter is between 60 and 90 it will display the third image of the spaceship
    {
      image(spaceship3,x,y);
    }
    else //if the counter is out of bounds of all of these if statements it will reset the counter back to zero so that it can run through the image sequence again
    {
      counter = 0;
    }
    counter = counter + 1; //increments the counter so that these if statments have purpose
  }

  void move() //method that will move the x and y coordinates of each Enemy 
  {
    float angle_between = atan2((380 - y), (380 - x)); //creates a float variable called "angle_between" and used the built in function atan2 to get an angle in radians between the coordinates of the Enemy and the coordinates of the Soldier (380,380)
    float new_x_cord = cos(angle_between) * (1*speed) + x; //gets a new x coordinate for the enemy by using Trigonometry and the cosine function to work out the angled direction and what number to add to the original x coordinate
    float new_y_cord = sin(angle_between) * (1*speed) + y; //gets a new y coordinate for the enemy by using Trigonometry and the sine function to work out the angled direction and what number to add to the original y coordinate
    x = new_x_cord; //making the X coordinate equal to the replacement x coordinate
    y = new_y_cord; //making the y coordinate equal to the replacement y coordinate
  }  
}
