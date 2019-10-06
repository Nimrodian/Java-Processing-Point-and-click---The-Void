PFont health_bar; //Initialising a new PFont variable to display the health bar
PFont start_text; //Initialising a new PFont variable to display the start screen text and all other splash screen text.

PImage background; //Initialising a new PImage variable to display the background later on
PImage moon; //Initialising a new PImage variable to display the moon on the background later on
PImage start_screen; //Initialising a new PImage variable to display the start screen later on
PImage explosion; //Initialising a new PImage variable to display the explosion sequence when an enemy is destroyed

Soldier player_1; //Initialising a new instance of the "Soldier" class, called player_1
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //Initialising a new ArrayList to store the enemies as they are being spawned. This ArrayList makes use of the "Enemy" class

int counter = 0; //Counter variable to be used as a buffer to spawn the enemies with a delay of 1 second between each one. "if(counter % 60 == 0)" to run the code every second, as draw runs 60 times a second

int current_stage = 0; //A variable to be used as an indication of the current splash screen being displayed

int paused = 0; //A variable to be used as an indication as whether the game is currently paused or not

int current_speed = 1; //A variable to be used when creating new enemies in the draw method, being incremented when the players score reaches 500 more points

void setup() //Main setup method, for predefined things that will not be changed during execution
{
  size(800, 800); //Setting canvas size
  frameRate(60); //Setting FrameRate
  background = loadImage("space.png"); //Loading the image into the PImage Variable for the background
  background.resize(width, height); //Resizing the background to fit the canvas size
  start_screen = loadImage("splash_screen_2.jpg"); //Loading the image into the PImage variable for the splash screen(s) background
  start_screen.resize(width, height); //Resizing the splash screen backgrounds to fit the canvas size
  moon = loadImage("moon.png"); //Loading the image into the PImage variable for the moon that the player is placed on
  moon.resize(165, 165); //Resizing the moon image
  explosion = loadImage("explosion.png"); //Loading the image into the PImage variable for the explosion animation
  explosion.resize(60,60); //Resizing the explosion image
  player_1 = new Soldier(400, 400, 0, 100.00); //Actually creating the instance of "Soldier" passing it the values that are defined in the constructor
  health_bar = loadFont("BodoniMTCondensed-48.vlw");
  start_text = loadFont("BodoniMTCondensed-48.vlw");
}


void draw() //Draw Method that will run 60 times a second (the FrameRate I set in Setup())
{
  if(current_stage == 0) //if statement using the current stage variable, if the current stage is 0, it will display the start game splash screen using the method within.
  {
    start_screen();
  }
  
  else if(current_stage == 1) //else if the current stage is 1, it will run the main bulk of what the game is, no splash screens, just the game running, where you are destroying enemies etc.
  {
    display_background(); //Calling the method that displays the background
    player_1.update(); //Takes the instance of Soldier and calls the method update within its class
    check_collisions(); //Calling the method that will check if the Enemies have collided with the Soldier
    player_1.check_score(); //Takes the instance of Soldier and runs the method in its class to check the score
    counter++; //Increments the counter variable defined at the start by one 
    if(counter % 60 == 0) //If statement that will execute if the counter (previously incremented) when divided by 60 has no remainder, so essentially if it is divisible by 60. 
    {
      int size = int(random(1,5)); //Creates a random number between 1 and 5. Done to give the spawn of the enemies a random(ish) system to it
      if(size == 1) //if the random size number is 1 it will spawn the enemy at random coordinates in one area of the screen
      {
        enemies.add(new Enemy(random(5, 100), random(5, 795),current_speed));
      }
      else if(size == 2) //if the random size number is 2 it will spawn the enemy at random coordinates in another area of the screen
      {
        enemies.add(new Enemy(random(5, 100), random(700, 795),current_speed));
      }
      else if(size == 3) //if the random size number is 3 it will spawn the enemy at random coordinates in another area of the screen
      {
        enemies.add(new Enemy(random(700, 795), random(5, 795),current_speed));
      }
      else //if the random size number is 4 it will spawn the enemy at random coordinates in another area of the screen
      {
        enemies.add(new Enemy(random(5, 795), random(5, 100),current_speed));
      }
    }
    for(int i=0; i<enemies.size(); i++) //for loop that will run through every instance of the enemy arraylist, based on the "size()" of it 
    {
      if(enemies.get(i) != null) //if statement to catch null pointer exceptions, where the program is trying to do something with an instance of the arraylist that no longer exists.
      {
        enemies.get(i).update(); //For each enemy in the arraylist that isn't null, this line will call the update function in the enemy class to render the enemy in a new position
      }
    }
    draw_crosshair(); //calls the method that draws the double line crosshair that stays with the cursor
  }
  
  else if(current_stage == 3) //else if statement for the current stage being 3, if it is three it means the game is over (ran out of health) and the relevant game over splash screen will be displayed
  {
    end_screen(); //calls the method that will display the end game splash screen 
  }
  
  else if(current_stage == 4) //else if statement for if the current stage is 4
  {
    game_paused(); //if the current stage is 4 it will call the method that runs the "Paused" splash screen
  }
  else if(current_stage == 5) //else if statement for if the current stage is 5
  {
    game_rules(); //if the current stage is 5 it will call the method that displays the splash screen for how to play/rules 
  }
}

void game_rules() //method that is called if the game stage is 5, displaying the image and text for the game rules screen
{
  image(start_screen,0,0); //displays the image "start_screen" at coordinates 0, 0
  textFont(health_bar,40); //sets the current text being used to "health_bar" with a size of 25
  text("The game is endless, so aim for the highest score you can get!",(width/2)-(textWidth("The game is endless, so aim for the highest score you can get!")/2), (height/2)-(40/2)-120); //Following 5 lines, displays text in the coordinates listed after it 
  text("Click on the enemies with your cursor to destroy them.", (width/2)-(textWidth("Click on the enemies with your cursor to destroy them.")/2), (height/2)-(40/2)-60); //
  text("The enemies will gain speed as the game goes on so be careful!", (width/2)-(textWidth("The enemies will gain speed as the game goes on so be careful!")/2), (height/2)-(40/2)); //
  text("You have 10 lives, GOOD LUCK!", (width/2)-(textWidth("You have 10 lives, GOOD LUCK!")/2), (height/2)-(40/2)+60); //
  text("Press the 'S' key to begin",(width/2)-(textWidth("Press the 'S' key to begin")/2), (height)-60); //
  if(keyPressed == true) //if statement for if a key has been pressed on the keyboard
  {
    if(key == 's') //if the key pressed is the s key it will change the current game_stage back to 1, so the game will be unpaused
    {
      current_stage = 1; 
    }
  }
}

void game_paused() //method that will be called when the user pauses the game by pressing the 'p' key
{
  textFont(health_bar,80); 
  text("PAUSED",(width/2)-(textWidth("PAUSED")/2), (height/2)-(40/2)); //displays the text telling the user it is paused. at the relevant coordinates
  paused = 1; //changes the paused state to 1, waiting then to be changed back to 0.
}

void start_screen() //method that is called as soon as the code is ran (as this is the start splash screen)
{
  image(start_screen,0,0); //displays the image "start_screen" at the coordinates 0,0
  textFont(start_text,80); //sets the current text being used to "start_text" with a size of 80
  text("WELCOME TO THE VOID", (width/2)-(textWidth("WELCOME TO THE VOID")/2), (height/2)-(40/2)-80); //displays this text at those coordinates
  textFont(start_text,40); //sets the current text being used to "start_text" with a size of 40
  text("Press the 'S' key to begin", (width/2)-(textWidth("Press the 'S' key to begin")/2), (height/2)-(40/2)+40); 
  text("Or press the 'T' key for how to play", (width/2)-(textWidth("Or press the 'T' key for how to play")/2), (height/2)-(40/2) + 80);
  if(keyPressed == true) //if statement for if a key is pressed on the keyboard
  {
    if(key == 's') //if the key pressed is the s key, it will change the current stage of the game to 1 (the main bulk of the game)
    {
      current_stage = 1;
    }
  }
}

void end_screen() //method that displays the end game splash screen, called when the player has ran out of health
{
  image(start_screen,0,0); //displays the splash screen for the end screen
  fill(255); //sets the text colour to white

  //The following 5 lines displays the text written at the coordinates that are typed after them
  
  textFont(start_text,60); 
  text("Game Over!", (width/2)-(textWidth("Game Over!")/2), (height/2)-(40/2)-100);
  textFont(start_text,40); 
  text("You have lost all of your health", (width/2)-(textWidth("You have lost all of your health")/2), (height/2)-(40/2)-40); 
  text("Your final score was: " + player_1.score, (width/2)-(textWidth("Your final score was: "+ player_1.score)/2), (height/2)-(40/2)); 
  text("Press the 'R' key to restart", (width/2)-(textWidth("Press the 'R' key to restart")/2), (height/2)-(40/2)+80);
  text("Or press the 'Q' key to quit", (width/2)-(textWidth("Or press the 'Q' key to quit")/2), (height/2)-(40/2)+120);

  if(keyPressed == true) //if statement for when a key is pressed on the keyboard
  {
    if(key == 'r') //if the key that is pressed is the r key it will run the following indented code under it, essentially where everything is being reset, so the game can reset
    {
      for(int i=0; i<enemies.size(); i++) //for every enemy in the enemy arraylist (based on the size() function)
      {
        enemies.remove(i); //line of code that will remove the instance of the enemies in the arraylist 
      }
      player_1.score = 0; //sets the players score back to 0
      player_1.health = 100; //sets the players health back to 100
      current_stage = 0; //sets the current_stage back to 0 (start screen)
      current_speed = 1; //sets the speed variable/difficulty variable of the enemies back to 1
    }
    if(key == 'q') //if the key pressed is the q key it will run the "exit()" command, that terminates the program properly
    {
     exit(); 
    }
  }
}

void check_collisions() //method that checks if the attacking enemies have reached the Soldier
{
  for(int i=0; i<enemies.size(); i++) //for loop that will run through each instance of the arraylist of enemies
  {
    if(enemies.get(i).x > 365 && enemies.get(i).x < 435 && enemies.get(i).y > 365 && enemies.get(i).y < 435) //if statement that checks if the x and y coordinates of the instance of the attackers is within the range of the soldiers position (365,435)
    {
      player_1.health = player_1.health - 10; //decrements the players health by 10 points 
      enemies.remove(i); //removes the instance of the enemy that has reached the soldier
    }
  }
}

void display_background() //method that is ran in every draw instance for the stage 1, drawing the space background
{
  image(background, 0, 0); //displays the space background at 0,0 and the moon image in the centre of the screen
  image(moon, 320, 320);
  textFont(health_bar,24); //sets the current textFont to "health_bar" with size 20
  fill(255); //sets the text colour to white 
  draw_HUD(); //runs the method "draw_HUD" that will display the score and health of the player
}

void draw_HUD() //method that displays the score and health of the player on top of the background 
{
  fill(105); //sets the fill to grey
  rect(0,0,225,25); //draws a base rectangle at 225,25 to go under the health bar
  rect(660,0,138,25); //sets another base rectangle at 138,25
  fill(255); //sets the fill to white 
  float health_percentage = player_1.health/100; //creates a float variable that will store the decimal version of the players health, so for e.g 90 health would turn into 0.9
  text("HEALTH", 10, 20); //displays text at 10,20
  rect(95,5,120,15); //another base rectangle to go under text
  fill(255,0,0); //sets the fill to red
  rect(98,7,114*(health_percentage),11); //creates the main health bar, where the length of it depends on the health percentage float that we made previously in this method, so as the decimal decreases, so does the size of the rectangle
  fill(255); //sets the fill to white 
  text("SCORE: "+player_1.score,665,20); //displays the score, with the score variable coming after it, at coordinates 665, 20
  text("PRESS 'P' TO TOGGLE PAUSE", (width/2)-(textWidth("PRESS 'P' TO TOGGLE PAUSE")/2), height-40); //displays text telling the user how to pause and unpause at coordinates 220, 790  
}

void draw_crosshair() //method to draw the crosshair on the mouse cursor
{
  stroke(173, 255, 47); //sets the colour of the lines used for the crosshair 
  rect(mouseX-10, mouseY+2, 10, 2); //the following four lines will displays lines across the cursor to make it look like the mouse has a crosshair 
  rect(mouseX, mouseY+2, 12, 2); //
  rect(mouseX, mouseY, 2, -8); //
  rect(mouseX, mouseY, 2, +12); //
}

void mouseReleased() //method to register if the mouse has been clicked, running whenever it has been pressed
{
  stroke(220, 220, 220); //sets the line colour to a light grey
  line(player_1.x, player_1.y, mouseX, mouseY); //draws a line from the soldier to the cursor to give the impression that a bullet is being shot 
  is_shot(); //runs the method that will check if the mouse click was succesfully on top of an enemy 
}

void keyPressed() //method that is not called, but just ran whenever a key is pressed 
{
  if(keyPressed == true) //if a key is pressed
  {
    if(key == 'p') //if the key pressed is 'p' it will change the game state to 4, pausing it 
    {
      if ( current_stage == 4)
      {
        current_stage = 1;
      }
      else
      {
        current_stage = 4;
      }
    }
    if(key == 'o') //if the key pressed is 'o' it will change the game state back to 1, unpausing it 
    {
      current_stage = 1;
    }
    if(key == 't') //if the key pressed is 't' it will change the game state to 5, for the rules and how to play splash screen
    {
      current_stage = 5;
    }
  }
}

void is_shot() //method that is ran when the user clicks the mouse, this method will check if the mouse click was on an enemy or not 
{
  for (int i=0; i<enemies.size(); i++) //for loop that will run the following code for every element of the arraylist of enemies 
  {
    if (enemies.get(i) != null) { //null pointer check, to make sure the program does not try and do anything with an element of the arraylist that no longer actually exists 
      if (mouseX > enemies.get(i).x && mouseX < (enemies.get(i).x + 80) && mouseY > enemies.get(i).y && mouseY < (enemies.get(i).y + 50)) //if statment that will check the coordinates of the mouseX and mouseY when the mouse was clicked
      {                                                                                                                                   //against the x and y coordinates of each enemy in the arraylist 
        image(explosion,enemies.get(i).x,enemies.get(i).y); //displays the image "explosion" to show that the enemy has been destroyed, essentially another animation sequence
        enemies.remove(i); //removes the instance of the enemy from the arraylist if it has been clicked on 
        i--; // When something is removed from the array, the array elements don't have gaps. Removing an item moves all elements down, therefore, we decrement the index.
        player_1.score = player_1.score + 100; //increments the players score with 100 as they have been succesful in destroying an enemy 
        if(player_1.score % 500 == 0) //if statement that will increment the speed of the enemies being spawned if the score is divisible by 500, to increase the difficulty of the game gradually 
        {
          current_speed = current_speed + 1;
        }
      }
    }
  }
}