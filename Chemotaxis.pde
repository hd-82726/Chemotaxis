Bacteria[] bacteria = new Bacteria[50];

void setup()
{
  size(800, 600);

  for (int i = 0; i < bacteria.length; i++)
  {
    bacteria[i] = new Bacteria(
      (int) random(width),
      (int) random(height),
      color(random(255), random(255), random(255))
    );
  }
}

void draw()
{
  background(240);

  // Draw the mouse stimulus
  fill(255, 150, 0);
  ellipse(mouseX, mouseY, 20, 20);

  for (int i = 0; i < bacteria.length; i++)
  {
    bacteria[i].move();
    bacteria[i].show();
  }
}

class Bacteria
{
  int x;
  int y;
  int bacteriaColor;

  Bacteria(int startX, int startY, int startColor)
  {
    x = startX;
    y = startY;
    bacteriaColor = startColor;
  }

  void move()
  {
    // Find distance between bacteria and mouse
    float distance = dist(x, y, mouseX, mouseY);

    int direction = (int) random(4);
    float chance = random(1);

    // Move toward the mouse more often when close
    float bias = 0.5;

    if (distance < 100)
    {
      bias = 0.8;
    }
    else if (distance < 250)
    {
      bias = 0.65;
    }

    if (mousePressed && mouseButton == RIGHT)
    {
      // Move away from the mouse
      if (chance < bias)
      {
        if (abs(mouseX - x) > abs(mouseY - y))
        {
          if (mouseX > x)
          {
            x--;
          }
          else
          {
            x++;
          }
        }
        else
        {
          if (mouseY > y)
          {
            y--;
          }
          else
          {
            y++;
          }
        }
      }
      else
      {
        moveRandom(direction);
      }
    }
    else
    {
      // Move toward the mouse or wander randomly
      if (mousePressed && chance < bias)
      {
        if (abs(mouseX - x) > abs(mouseY - y))
        {
          if (mouseX > x)
          {
            x+=3;
          }
          else
          {
            x-=3;
          }
        }
        else
        {
          if (mouseY > y)
          {
            y+=3;
          }
          else
          {
            y-=3;
          }
        }
      }
      else
      {
        moveRandom(direction);
      }
    }

    // Keep bacteria inside the screen
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }

  void moveRandom(int direction)
  {
    if (direction == 0)
    {
      x++;
    }
    else if (direction == 1)
    {
      x--;
    }
    else if (direction == 2)
    {
      y++;
    }
    else
    {
      y--;
    }
  }

  void show()
  {
    fill(bacteriaColor);
    noStroke();
    ellipse(x, y, 40, 40);
  }
}
