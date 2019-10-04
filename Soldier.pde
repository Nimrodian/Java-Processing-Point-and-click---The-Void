PImage soldier_sprite; //Defining a PImage variable to be used as the soldiers image

class Soldier //Creating the Soldiers class
{
  int x,y,score; //defining the four variables that will be included in the constructor for soldier
  float health;
  Soldier(int x, int y, int score, float health) //This is the constructor the Soldier class, passing it four values that will be used; x, y, score and health
  {
    soldier_sprite = loadImage("soldier_extranew.png"); //Loading the relevant soldier image into the PImage variable defined at the start
    soldier_sprite.resize(110,60); //resizing the soldiers sprite to a more relevant size (110,60)
    this.x = x; //Saying that the x being passed into the constructor is the x that should be used as the coordinates of the soldier
    this.y = y; //Saying that the y being passed into the constructor is the x that should be used as the coordinates of the soldier
    this.health = health; //Saying that the health being passed in is the health that should be used for the soldier
    this.score = score; //Saying that the score being passed in is the score that should be used for the soldier
  }
  
  void update() //method that will update the state of the soldier
  {
    render(); //render will render the relevant image each time the soldier is being moved
    check_health(); //check_health will check to see if the health of the soldier is ever below or equal to zero (game over essentially)
  }

  void render() //method to render the image of the soldier based on the rotation of the mouse 
  {
    pushMatrix(); //pushMatrix is used to save the current state of the objects/images in the game so that when I go to rotate the image of the soldier, it does not rotate all of the enemies and the background as well 
    translate(width/2,height/2); //Translation about the centre of the screen (this is where the soldier is placed, bang on in the centre of the screen)
    float current_angle = atan2(mouseY - height/2, mouseX - width/2); //creates a float variable called current_angle and used atan2 (again) to get the angle between the mouseX and mouseY, and the centre of the screen (soldiers coordinates)
    rotate(current_angle); //this will rotate the canvas about the angle that was just created, making it so it looks like the soldier is pointing towards the mouse/cursor
    image(soldier_sprite, -20, -20); //displays the soldiers image at the coordinates -20,-20. These coordinates are used because the atan2 function skews it, before you popMatrix() back and go back to the old state
    stroke(255); //changes the stroke to white
    popMatrix(); //popMatrix after the pushMatrix to go back to the original state of the game after performing the relevant transformations of the image of the soldier
  } 
  
  void check_health() //method to check the health of the player
  {
    if(this.health <= 0.00) //if the health of the player is less than or equal to zero it will set the current_stage to 3 which will then call the game over splash screen in draw
    {
      current_stage = 3;
    }
  }
  
  boolean check_score() //a boolean function to return true if the score is divisible by 800, if it isnt' it will return false
  {
    if(this.score % 800 == 0)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
