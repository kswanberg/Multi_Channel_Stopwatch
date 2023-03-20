// Multi-Channel Stopwatch 
// Author: Kelley Swanberg (Kyung Hee University, 2014) 
// Java-based application that records the times and durations of up to 499 instances each of five different channels of events against
// a flexible and user-friendly master stopwatch. Especially useful for post-experiment analysis of videoed behavioral data. 
// Data optionally exported as text file after each session.

PrintWriter output;

//Timer array lengths; use for defining different actions at timer start and stop points
int arraylength_m = 1; 
int arraylength_1 = 1; 
int arraylength_2 = 1; 
int arraylength_3 = 1; 
int arraylength_4 = 1; 
int arraylength_5 = 1; 

//pause status 
int pause = 0; 

//Timer arrays; use for storing start and stop points
int[][] times_m = new int[2][1000]; 
int[][] times1 = new int[2][1000]; 
int[][] times_2 = new int[2][1000]; 
int[][] times_3 = new int[2][1000]; 
int[][] times_4 = new int[2][1000]; 
int[][] times_5 = new int[2][1000]; 

//XMLCreate
int canmakeXML = 0; 

//May not use
int keyIndex = 0; 

//Define program run status
int startstop = 0; 

//Set up program interface
void setup() 
{
  size(600,600);
  background(#636363);
  stroke(0,0,10); 
}

//Display responsive buttons and GUI text
void draw() 
{   
   if (startstop == 0)
   {
     if (arraylength_m == 1)
     {
       background(#636363);
       textAlign(CENTER); 
       textSize(50);
       text("[Enter] = start timer.", 300, 500);
       textSize(10);
       text("Copyright (c) 2013 Kelley Swanberg. www.kelleyswanberg.com.", 300, 585);
     }
     else 
     {
       background(#636363);
       textAlign(CENTER); 
       textSize(50);
       canmakeXML = 1; 
       int timer_ms = millis(); 
       if (pause == 1)
       {
         text(times_m[1][arraylength_m-2], 300, 325); 
       }
       else
       {
         text(times_m[1][arraylength_m-1], 300, 325); 
       }
       text("Export data? [y]/[n]", 300, 400); 
       textSize(10);
       text("Copyright (c) 2013 Kelley Swanberg. www.kelleyswanberg.com.", 300, 585);
     } 
   }
   else if (startstop == 1)
   {
     if (pause == 0)
     {
       background(#D1D1D1);
       int timer_ms = millis(); 
       int timertime = (timer_ms - times_m[1][arraylength_m-1] - times_m[0][0]); 
       String timertime_s = timertime+""; 
       textAlign(CENTER); 
       textSize(50);
       text(timertime_s, 300, 325);  
       text("[Space] = pause timer.", 300, 430); 
       text("[Enter] = clear timer.", 300, 500);
       textSize(23);
       text("Press [1], [2], [3], [4], [5] to record distinct events!", 300, 560); 
       textSize(10);
       text("Copyright (c) 2013 Kelley Swanberg. www.kelleyswanberg.com.", 300, 585);
     }
     else
     {
        background(#636363);
        textSize(50);
        text(times_m[1][arraylength_m-1], 300, 325);
        text("[Space] = resume timer.", 300, 430); 
        text("[Enter] = clear timer.", 300, 500);
        textSize(10);
        text("Copyright (c) 2013 Kelley Swanberg. www.kelleyswanberg.com.", 300, 585);
     }
   }
   else if (startstop == 2)
   {
       background(#636363);
       textAlign(CENTER); 
       textSize(50);
       if (pause == 1)
       {
         text(times_m[1][arraylength_m-2], 300, 325); 
       }
       else
       {
         text(times_m[1][arraylength_m-1], 300, 325); 
       }
       text("Data.txt exported!", 300, 400); 
       text("[Enter] = clear timer.", 300, 500);
       textSize(10);
       text("Copyright (c) 2013 Kelley Swanberg. www.kelleyswanberg.com.", 300, 585);
       textSize(50);
   }
   if (keyIndex == 1 && startstop == 1) 
   { 
    textSize(30);
    ellipse(300,100,100,100);
    fill(#FF0000); 
    stroke(#FF0000); 
    text("key 1 pressed!", width/2, height/2.6); 
    } 
  else if (keyIndex == 2 && startstop == 1) 
    {
    textSize(30);
    ellipse(300,100,100,100);
    fill(#0FB300); 
    stroke(#0FB300); 
    text("key 2 pressed!", width/2, height/2.6); 
    } 
    else if (keyIndex == 3 && startstop == 1)
    {
    textSize(30);
    ellipse(300,100,100,100); 
    fill(#0715cd);
    stroke(#0715cd); 
    text("key 3 pressed!", width/2, height/2.6); 
    }
    else if (keyIndex == 4 && startstop == 1)
    {
    textSize(30);
    ellipse(300,100,100,100); 
    fill(#FF00FB);
    stroke(#FF00FB); 
    text("key 4 pressed!", width/2, height/2.6);
    }
    else if (keyIndex == 5 && startstop == 1)
    {
    textSize(30);
    ellipse(300,100,100,100);
    fill(#FFBB00);
    stroke(#FFBB00); 
    text("key 5 pressed!", width/2, height/2.6);
    }
    else 
    {
    ellipse(300,100,100,100); 
    fill(#333333); 
    stroke(0);
   } 
}

//Define different program responses for different keyboard keys 
void keyPressed() 
{
  if (keyCode == ENTER)
  {
    if (startstop == 0 || startstop == 2)
    {
        pause = 0; 
        startstop = 1;
        times_m[0][0] = millis();
        times_m[1][0] = 0; 
        arraylength_m = 1; 
        arraylength_1 = 1; 
        arraylength_2 = 1; 
        arraylength_3 = 1; 
        arraylength_4 = 1; 
        arraylength_5 = 1; 
    }
    else if (startstop == 1)
    {
      arraylength_m++; 
      times_m[0][arraylength_m-1] = millis();  
      times_m[1][arraylength_m-1] = 0; 
      for (int i = 0; i < arraylength_m-1; i++)
      {
        if ((i & 1)==0)
        {
        times_m[1][arraylength_m-1] = times_m[1][arraylength_m-1] + (times_m[0][arraylength_m-(i+1)]-times_m[0][arraylength_m-(i+2)]); 
        } 
      }
      startstop = 0; 
  }
  }
   else if (key == ' ' && startstop == 1)
  {
    if ((arraylength_m & 1)==1 && pause == 0)
    {
      arraylength_m++; 
      times_m[0][arraylength_m-1] = millis();  
      times_m[1][arraylength_m-1] = 0; 
      for (int i = 0; i < arraylength_m-1; i++)
      {
        if ((i & 1)==0)
        {
        times_m[1][arraylength_m-1] = times_m[1][arraylength_m-1] + (times_m[0][arraylength_m-(i+1)]-times_m[0][arraylength_m-(i+2)]); 
        } 
      }
      pause = 1; 
    }
    else
    {
     arraylength_m++; 
     times_m[0][arraylength_m-1] = millis();
     times_m[1][arraylength_m-1] = 0; 
      for (int i = 0; i < arraylength_m-1; i++)
      {
        if ((i & 1)==0)
        {
        times_m[1][arraylength_m-1] = times_m[1][arraylength_m-1] + (times_m[0][arraylength_m-(i+1)]-times_m[0][arraylength_m-(i+2)]); 
        } 
      }
     pause = 0;   
    }
  }
  else if (key == '1' && startstop == 1 && pause == 0) 
  {
    if ((arraylength_1 & 1)==1)
    {
      arraylength_1++; 
      
      if(arraylength_m == 1)
      {
          times1[0][arraylength_1-1] = millis()-times_m[0][arraylength_m-1]; 
      }
      else
      {
          times1[0][arraylength_1-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
      }
      times1[1][arraylength_1-1] = 0; 
      println(times1[0][arraylength_1-1]); 
      keyIndex = 1; 
    }
    else
    {
      keyIndex = 1; 
    }
  }
  else if (key == '2' && startstop == 1 && pause == 0)
  {
    if ((arraylength_2 & 1)==1)
    {
      arraylength_2++; 
      if(arraylength_m == 1)
      {
          times_2[0][arraylength_2-1] = millis()-times_m[0][arraylength_m-1]; 
      }
      else
      {
          times_2[0][arraylength_2-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
      }
      times_2[1][arraylength_2-1] = 0; 
      println(times_2[0][arraylength_2-1]);  
      keyIndex = 2; 
    }
    else
    {
      keyIndex = 2; 
    }
  }
  else if (key == '3' && startstop == 1 && pause == 0)
  {
    if ((arraylength_3 & 1)==1)
    {
      arraylength_3++; 
      if(arraylength_m == 1)
      {
          times_3[0][arraylength_3-1] = millis()-times_m[0][arraylength_m-1]; 
      }
      else
      {
          times_3[0][arraylength_3-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
      }
      times_3[1][arraylength_3-1] = 0; 
      println(times_3[0][arraylength_3-1]);  
      keyIndex = 3; 
    }
    else
    {
      keyIndex = 3; 
    }
  }
  else if (key == '4' && startstop == 1 && pause == 0)
  {
    if ((arraylength_4 & 1)==1)
    {
      arraylength_4++; 
      if(arraylength_m == 1)
      {
          times_4[0][arraylength_4-1] = millis()-times_m[0][arraylength_m-1]; 
      }
      else
      {
          times_4[0][arraylength_4-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
      }
      times_4[1][arraylength_4-1] = 0; 
      println(times_4[0][arraylength_4-1]);   
      keyIndex = 4; 
    }
    else
    {
      keyIndex = 4; 
    }
  }
  else if (key == '5' && startstop == 1 && pause == 0)
  {
    if ((arraylength_5 & 1)==1)
    {
      arraylength_5++; 
      if(arraylength_m == 1)
      {
          times_5[0][arraylength_5-1] = millis()-times_m[0][arraylength_m-1]; 
      }
      else
      {
          times_5[0][arraylength_5-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
      }
      times_5[1][arraylength_5-1] = 0; 
      println(times_5[0][arraylength_5-1]);   
      keyIndex = 5; 
    }
    else
    {
      keyIndex = 5; 
    }
  }
  else if (key == 'n' && canmakeXML == 1)
    {
        pause = 0; 
        startstop = 1;
        times_m[0][0] = millis();
        times_m[1][0] = 0; 
        arraylength_m = 1; 
        arraylength_1 = 1; 
        arraylength_2 = 1; 
        arraylength_3 = 1; 
        arraylength_4 = 1; 
        arraylength_5 = 1; 
    }
  else if (key == 'y' && canmakeXML == 1)
  {
    //int datalength = 2*(arraylength_m + arraylength_1 + arraylength_2 + arraylength_3 + arraylength_4 + arraylength_5 + 5);
    export(); 
    canmakeXML = 0; 
    startstop = 2; 
  }
  else
  {
    keyIndex = 0; 
  }
}

//Define different program responses for different keyboard key releases; important for individual timer start/stop events 
void keyReleased()
{
  if (key == '1' && startstop == 1 && pause == 0)
  {
  keyIndex = 0;
  arraylength_1++; 
  if (arraylength_m ==1)
  {
    times1[0][arraylength_1-1] = millis()-times_m[0][arraylength_m-1];
  }
  else
  {
    times1[0][arraylength_1-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
  }
    times1[1][arraylength_1-1] = (times1[0][arraylength_1-1]-times1[0][arraylength_1-2]);
  println(times1[0][arraylength_1-1]); 
  println("key 1 press duration (s): " + times1[1][arraylength_1-1]); 
  println( "key 1 presses: " + ((arraylength_1-1)*0.5));
  }
  else if (key == '2' && startstop == 1 && pause == 0)
  {
  keyIndex = 0;
  arraylength_2++; 
  if (arraylength_m ==1)
  {
    times_2[0][arraylength_2-1] = millis()-times_m[0][arraylength_m-1];
  }
  else
  {
    times_2[0][arraylength_2-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
  } 
  times_2[1][arraylength_2-1] = (times_2[0][arraylength_2-1]-times_2[0][arraylength_2-2]);
  println(times_2[0][arraylength_2-1]); 
  println("key 2 press duration (s): " + times_2[1][arraylength_2-1]); 
  println("key 2 presses: " + ((arraylength_2-1)*0.5));
  }
  else if (key == '3' && startstop == 1 && pause == 0)
  {
  keyIndex = 0;
  arraylength_3++; 
  if (arraylength_m ==1)
  {
    times_3[0][arraylength_3-1] = millis()-times_m[0][arraylength_m-1];
  }
  else
  {
    times_3[0][arraylength_3-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
  } 
  times_3[1][arraylength_3-1] = (times_3[0][arraylength_3-1]-times_3[0][arraylength_3-2]);
  println(times_3[0][arraylength_3-1]); 
  println("key 3 press duration (s): " + times_3[1][arraylength_3-1]); 
  println("key 3 presses: " + ((arraylength_3-1)*0.5));
  }
  else if (key == '4' && startstop == 1 && pause == 0)
  {
  keyIndex = 0;
  arraylength_4++; 
  if (arraylength_m ==1)
  {
    times_4[0][arraylength_4-1] = millis()-times_m[0][arraylength_m-1];
  }
  else
  {
    times_4[0][arraylength_4-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
  } 
  times_4[1][arraylength_4-1] = (times_4[0][arraylength_4-1]-times_4[0][arraylength_4-2]);
  println(times_4[0][arraylength_4-1]); 
  println("key 4 press duration (s): " + times_4[1][arraylength_4-1]); 
  println("key 4 presses: " + ((arraylength_4-1)*0.5));
  }
  else if (key == '5' && startstop == 1 && pause == 0)
  {
  keyIndex = 0;
  arraylength_5++; 
  if (arraylength_m ==1)
  {
    times_5[0][arraylength_5-1] = millis()-times_m[0][arraylength_m-1];
  }
  else
  {
    times_5[0][arraylength_5-1] = millis()-times_m[0][arraylength_m-1] + times_m[1][arraylength_m-2]; 
  } 
  times_5[1][arraylength_5-1] = (times_5[0][arraylength_5-1]-times_5[0][arraylength_5-2]);
  println(times_5[0][arraylength_5-1]); 
  println("key 5 press duration (s): " + times_5[1][arraylength_5-1]); 
  println("key 5 presses: " + ((arraylength_5-1)*0.5));
  }
  else
  {
  keyIndex = 0;
  }
}

void export()
{
  output = createWriter("data.txt");
    output.println("Program Run Times (program timer, stopwatch timer)");
    for(int i = 1; i < arraylength_m/2+1; i++)
    {
      for (int j = 0; j < 2; j++)
      {
        output.println(times_m[j][2*i-1]); 
      }
        output.println(' '); 
    }
    output.println("Program Pause Times (program timer, stopwatch timer)");
     for(int i = 0; i < arraylength_m/2; i++)
    {
      for (int j = 0; j < 2; j++)
      {
        output.println(times_m[j][2*i]); 
      }
        output.println(' '); 
    }
    
    output.println("Key 1 Press Times (press, release, duration)");
    for(int i = 0; i < arraylength_1; i++)
    {
      if ((i & 1)==1)
      {
        output.println(times1[0][i]); 
      }
      else 
      {
        for (int j = 0; j < 2; j++)
      {
        output.println(times1[j][i]); 
      }
        output.println(' '); 
      }
    }
    
    output.println("Key 1 Press Number: " + (arraylength_1-1)*0.5); 
    output.println(' ');
    
    int totalminutes_m = 0; 
    int testminutes_m = 0; 
    
    if (pause == 1)
    {
      testminutes_m = times_m[1][arraylength_m-2];  
    }
    else
    {
      testminutes_m = times_m[1][arraylength_m-1];   
    }
     
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_m > 0)
      {
        testminutes_m = testminutes_m - 60000;
        totalminutes_m++;  
      }
      else 
      {
        k = 1000; 
      }
    }
    
    int minutenumber_1 = 1; 
    int totalminutes_1 = 0; 
    int minutetime_1 = 0;
    int cutoff = 0; 
    int testminutes_1 = times1[0][arraylength_1-1];  
    
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_1 > 0)
      {
       
        testminutes_1 = testminutes_1 - 60000;
        totalminutes_1++; 
      }
      else 
      {
        k = 1000; 
      }
    }
    
    int minutenumber_2 = 1; 
    int totalminutes_2 = 0; 
    int minutetime_2 = 0;
    int testminutes_2 = times_2[0][arraylength_2-1]; 
   
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_2 > 0)
      {
       
        testminutes_2 = testminutes_2 - 60000;
        totalminutes_2++; 
      }
      else 
      {
        k = 1000; 
      }
    } 
    
    int minutenumber_3 = 1; 
    int totalminutes_3 = 0; 
    int minutetime_3 = 0;
    int testminutes_3 = times_3[0][arraylength_3-1]; 
   
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_3 > 0)
      {
       
        testminutes_3 = testminutes_3 - 60000;
        totalminutes_3++; 
      }
      else 
      {
        k = 1000; 
      }
    } 
    
    int minutenumber_4 = 1; 
    int totalminutes_4 = 0; 
    int minutetime_4 = 0;
    int testminutes_4 = times_4[0][arraylength_4-1]; 
   
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_4 > 0)
      {
       
        testminutes_4 = testminutes_4 - 60000;
        totalminutes_4++; 
      }
      else 
      {
        k = 1000; 
      }
    } 
    
    int minutenumber_5 = 1; 
    int totalminutes_5 = 0; 
    int minutetime_5 = 0;
    int testminutes_5 = times_5[0][arraylength_5-1]; 
   
    for (int k = 0; k < 1000; k++)
    {
      if (testminutes_5 > 0)
      {
       
        testminutes_5 = testminutes_5 - 60000;
        totalminutes_5++; 
      }
      else 
      {
        k = 1000; 
      }
    } 
    
    output.println("Key 1 Press Times by Minute");
    for(int j = 0; j < totalminutes_m; j++)
    {
      if (minutenumber_1 <= totalminutes_1) 
      {
        for(int i = cutoff; i < arraylength_1; i++)
        {
          //odd values in array
          if ((i & 1)==0)  
          {
            //maintain loop within same minute number
            if ((times1[0][i] >= (minutenumber_1*60000-60000)) && (times1[0][i] < 60000*minutenumber_1) && i < arraylength_1-1)
            {
              
              //account for non-extreme lower border case
              if (i>0 && (times1[0][i-1] < (minutenumber_1*60000-60000)))
              {
                minutetime_1 = times1[0][i] - ((minutenumber_1)*60000-60000);
              } 
 
              // simply add value of non-border case
              else 
              {
                minutetime_1 = minutetime_1 + times1[1][i];
              }
            }
            
            // account for upper border case and proceed to next minute number
            else if (times1[0][i] >= 60000*minutenumber_1 && i < arraylength_1-1 && (times1[0][i] < (60000*minutenumber_1 + 60000)))
            {
                if (i>0 && times1[0][i-1] < 60000*minutenumber_1 && times1[0][i-1] >= (60000*minutenumber_1-60000))
                {
                    minutetime_1 = minutetime_1 + (60000*minutenumber_1-times1[0][i-1]); 
                    output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms");
                    minutetime_1 = 0; 
                    minutenumber_1++; 
                    if (i < arraylength_1-1)
                    {
                      i = i-1; 
                    }
                } 
                else if (i>0 && times1[0][i-1] < (60000*minutenumber_1-60000))
                {
                    minutetime_1 = 60000; 
                    output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms");
                    minutetime_1 = 0; 
                    minutenumber_1++; 
                    if (i < arraylength_1-1)
                    {
                      i = i-1; 
                    }
                }
                else
                {
                    output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                    minutetime_1 = 0; 
                    minutenumber_1++;
                   if (i < arraylength_1-1)
                    {
                      i = i-1; 
                    }  
                }
            }
            
            // account for extreme upper border case
            else if ((times1[0][i] >= 60000*minutenumber_1 + 60000) && i < arraylength_1-1)
            {
              if (times1[0][i-1] < (60000*minutenumber_1-60000))
              {
               minutetime_1 = 60000; 
               output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
               minutetime_1 = 0; 
               minutenumber_1++; 
                if (i < arraylength_1-1)
                    {
                      i = i-1; 
                    } 
              }
              else if (times1[0][i-1] >= (60000*minutenumber_1-60000))
              {
                if (times1[0][i-1] < (60000*minutenumber_1))
                {
                   minutetime_1 = minutetime_1 + (60000*minutenumber_1)-times1[0][i-1]; 
                   output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                   minutetime_1 = 0; 
                   minutenumber_1++; 
                  if (i < arraylength_1-1)
                  {
                      i = i-1; 
                  }
                } 
                else if (times1[0][i-1] >= (60000*minutenumber_1))
                {
                   output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                   minutetime_1 = 0; 
                   minutenumber_1++; 
                  if (i < arraylength_1-1)
                  {
                      i = i-1; 
                  }
                } 
              }
                
            }
            else if (i == arraylength_1-1)
            {
               //account for lower border case
              if (i>0 && (times1[0][i-1] < (minutenumber_1*60000-60000)) && times1[0][i] < 60000*minutenumber_1)
              {
                minutetime_1 = minutetime_1 + (times1[0][i] - ((minutenumber_1)*60000-60000));
                output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                minutetime_1 = 0; 
                minutenumber_1++; 
              }
              
              // check for extreme upper border plus lower border case
              else if (i>0 && (times1[0][i-1] < (minutenumber_1*60000-60000)) && times1[0][i] >= 60000*minutenumber_1)
              {
                minutetime_1 = 60000; 
                output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                minutetime_1 = 0; 
                minutenumber_1++; 
              }
              
               // check for extreme upper border minus lower border case 
              else if (i>0 && (times1[0][i-1] >= (minutenumber_1*60000-60000)) && times1[0][i] > 60000*minutenumber_1)
              {
                if (times1[0][i-1] < (minutenumber_1*60000))
                {
                  minutetime_1 = minutetime_1 + (60000*minutenumber_1 - times1[0][i-1]); 
                  output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                  minutetime_1 = 0; 
                  minutenumber_1++;  
                }
                else if (times1[0][i-1] >= (minutenumber_1*60000))
                {
                  output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                  minutetime_1 = 0; 
                  minutenumber_1++; 
                }
              }
              
              // simply add value of non-border case
              else 
              {
                minutetime_1 = minutetime_1 + times1[1][i];
                output.println("Minute " + (minutenumber_1) + ": " + (minutetime_1) + " ms"); 
                minutetime_1 = 0; 
                minutenumber_1++; 
              }
            }
          }
        }
      }
      else 
      {
        if (minutenumber_1 <= totalminutes_m)
        {
         output.println("Minute " + (minutenumber_1) + ": 0 ms");
        }
         minutenumber_1++; 
      }
    }
    output.println(' ');
    
    output.println("Key 2 Press Times (press, release, duration)");
    for(int i = 0; i < arraylength_2; i++)
    {
      if ((i & 1)==1)
      {
        output.println(times_2[0][i]); 
      }
      else 
      {
        for (int j = 0; j < 2; j++)
      {
        output.println(times_2[j][i]); 
      }
        output.println(' '); 
      }
    }
    output.println("Key 2 Press Number: " + (arraylength_2-1)*0.5); 
    output.println(' ');
    
    output.println("Key 2 Press Times by Minute");
    for(int j = 0; j < totalminutes_m; j++)
    {
      if (minutenumber_2 <= totalminutes_2) 
      {
        for(int i = cutoff; i < arraylength_2; i++)
        {
          //odd values in array
          if ((i & 1)==0)  
          {
            //maintain loop within same minute number
            if ((times_2[0][i] >= (minutenumber_2*60000-60000)) && (times_2[0][i] < 60000*minutenumber_2) && i < arraylength_2-1)
            {
              
              //account for non-extreme lower border case
              if (i>0 && (times_2[0][i-1] < (minutenumber_2*60000-60000)))
              {
                minutetime_2 = times_2[0][i] - ((minutenumber_2)*60000-60000);
              } 
 
              // simply add value of non-border case
              else 
              {
                minutetime_2 = minutetime_2 + times_2[1][i];
              }
            }
            
            // account for upper border case and proceed to next minute number
            else if (times_2[0][i] >= 60000*minutenumber_2 && i < arraylength_2-1 && (times_2[0][i] < (60000*minutenumber_2 + 60000)))
            {
                if (i>0 && times_2[0][i-1] < 60000*minutenumber_2 && times_2[0][i-1] >= (60000*minutenumber_2-60000))
                {
                    minutetime_2 = minutetime_2 + (60000*minutenumber_2-times_2[0][i-1]); 
                    output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms");
                    minutetime_2 = 0; 
                    minutenumber_2++; 
                    if (i < arraylength_2-1)
                    {
                      i = i-1; 
                    }
                } 
                else if (i>0 && times_2[0][i-1] < (60000*minutenumber_2-60000))
                {
                    minutetime_2 = 60000; 
                    output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms");
                    minutetime_2 = 0; 
                    minutenumber_2++; 
                    if (i < arraylength_2-1)
                    {
                      i = i-1; 
                    }
                }
                else
                {
                    output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                    minutetime_2 = 0; 
                    minutenumber_2++;
                   if (i < arraylength_2-1)
                    {
                      i = i-1; 
                    }  
                }
            }
            
            // account for extreme upper border case
            else if ((times_2[0][i] >= 60000*minutenumber_2 + 60000) && i < arraylength_2-1)
            {
              if (times_2[0][i-1] < (60000*minutenumber_2-60000))
              {
               minutetime_2 = 60000; 
               output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
               minutetime_2 = 0; 
               minutenumber_2++; 
                if (i < arraylength_2-1)
                    {
                      i = i-1; 
                    } 
              }
              else if (times_2[0][i-1] >= (60000*minutenumber_2-60000))
              {
                if (times_2[0][i-1] < (60000*minutenumber_2))
                {
                   minutetime_2 = minutetime_2 + (60000*minutenumber_2)-times_2[0][i-1]; 
                   output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                   minutetime_2 = 0; 
                   minutenumber_2++; 
                  if (i < arraylength_2-1)
                  {
                      i = i-1; 
                  }
                } 
                else if (times_2[0][i-1] >= (60000*minutenumber_2))
                {
                   output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                   minutetime_2 = 0; 
                   minutenumber_2++; 
                  if (i < arraylength_2-1)
                  {
                      i = i-1; 
                  }
                } 
              }
                
            }
            else if (i == arraylength_2-1)
            {
               //account for lower border case
              if (i>0 && (times_2[0][i-1] < (minutenumber_2*60000-60000)) && times_2[0][i] < 60000*minutenumber_2)
              {
                minutetime_2 = minutetime_2 + (times_2[0][i] - ((minutenumber_2)*60000-60000));
                output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                minutetime_2 = 0; 
                minutenumber_2++; 
              }
              
              // check for extreme upper border plus lower border case
              else if (i>0 && (times_2[0][i-1] < (minutenumber_2*60000-60000)) && times_2[0][i] >= 60000*minutenumber_2)
              {
                minutetime_2 = 60000; 
                output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                minutetime_2 = 0; 
                minutenumber_2++; 
              }
              
               // check for extreme upper border minus lower border case 
              else if (i>0 && (times_2[0][i-1] >= (minutenumber_2*60000-60000)) && times_2[0][i] > 60000*minutenumber_2)
              {
                if (times_2[0][i-1] < (minutenumber_2*60000))
                {
                  minutetime_2 = minutetime_2 + (60000*minutenumber_2 - times_2[0][i-1]); 
                  output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                  minutetime_2 = 0; 
                  minutenumber_2++;  
                }
                else if (times_2[0][i-1] >= (minutenumber_2*60000))
                {
                  output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                  minutetime_2 = 0; 
                  minutenumber_2++; 
                }
              }
              
              // simply add value of non-border case
              else 
              {
                minutetime_2 = minutetime_2 + times_2[1][i];
                output.println("Minute " + (minutenumber_2) + ": " + (minutetime_2) + " ms"); 
                minutetime_2 = 0; 
                minutenumber_2++; 
              }
            }
          }
        }
      }
      else 
      {
        if (minutenumber_2 <= totalminutes_m)
        {
         output.println("Minute " + (minutenumber_2) + ": 0 ms");
        }
         minutenumber_2++; 
      }
    }
    output.println(' ');
    
    output.println("Key 3 Press Times (press, relase, duration)");
    for(int i = 0; i < arraylength_3; i++)
    {
      if ((i & 1)==1)
      {
        output.println(times_3[0][i]); 
      }
      else 
      {
        for (int j = 0; j < 2; j++)
      {
        output.println(times_3[j][i]); 
      }
        output.println(' '); 
      }
    }
    output.println("Key 3 Press Number: " + (arraylength_3-1)*0.5); 
    output.println(' ');
    
    output.println("Key 3 Press Times by Minute");
    for(int j = 0; j < totalminutes_m; j++)
    {
      if (minutenumber_3 <= totalminutes_3) 
      {
        for(int i = cutoff; i < arraylength_3; i++)
        {
          //odd values in array
          if ((i & 1)==0)  
          {
            //maintain loop within same minute number
            if ((times_3[0][i] >= (minutenumber_3*60000-60000)) && (times_3[0][i] < 60000*minutenumber_3) && i < arraylength_3-1)
            {
              
              //account for non-extreme lower border case
              if (i>0 && (times_3[0][i-1] < (minutenumber_3*60000-60000)))
              {
                minutetime_3 = times_3[0][i] - ((minutenumber_3)*60000-60000);
              } 
 
              // simply add value of non-border case
              else 
              {
                minutetime_3 = minutetime_3 + times_3[1][i];
              }
            }
            
            // account for upper border case and proceed to next minute number
            else if (times_3[0][i] >= 60000*minutenumber_3 && i < arraylength_3-1 && (times_3[0][i] < (60000*minutenumber_3 + 60000)))
            {
                if (i>0 && times_3[0][i-1] < 60000*minutenumber_3 && times_3[0][i-1] >= (60000*minutenumber_3-60000))
                {
                    minutetime_3 = minutetime_3 + (60000*minutenumber_3-times_3[0][i-1]); 
                    output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms");
                    minutetime_3 = 0; 
                    minutenumber_3++; 
                    if (i < arraylength_3-1)
                    {
                      i = i-1; 
                    }
                } 
                else if (i>0 && times_3[0][i-1] < (60000*minutenumber_3-60000))
                {
                    minutetime_3 = 60000; 
                    output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms");
                    minutetime_3 = 0; 
                    minutenumber_3++; 
                    if (i < arraylength_3-1)
                    {
                      i = i-1; 
                    }
                }
                else
                {
                    output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                    minutetime_3 = 0; 
                    minutenumber_3++;
                   if (i < arraylength_3-1)
                    {
                      i = i-1; 
                    }  
                }
            }
            
            // account for extreme upper border case
            else if ((times_3[0][i] >= 60000*minutenumber_3 + 60000) && i < arraylength_3-1)
            {
              if (times_3[0][i-1] < (60000*minutenumber_3-60000))
              {
               minutetime_3 = 60000; 
               output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
               minutetime_3 = 0; 
               minutenumber_3++; 
                if (i < arraylength_3-1)
                    {
                      i = i-1; 
                    } 
              }
              else if (times_3[0][i-1] >= (60000*minutenumber_3-60000))
              {
                if (times_3[0][i-1] < (60000*minutenumber_3))
                {
                   minutetime_3 = minutetime_3 + (60000*minutenumber_3)-times_3[0][i-1]; 
                   output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                   minutetime_3 = 0; 
                   minutenumber_3++; 
                  if (i < arraylength_3-1)
                  {
                      i = i-1; 
                  }
                } 
                else if (times_3[0][i-1] >= (60000*minutenumber_3))
                {
                   output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                   minutetime_3 = 0; 
                   minutenumber_3++; 
                  if (i < arraylength_3-1)
                  {
                      i = i-1; 
                  }
                } 
              }
                
            }
            else if (i == arraylength_3-1)
            {
               //account for lower border case
              if (i>0 && (times_3[0][i-1] < (minutenumber_3*60000-60000)) && times_3[0][i] < 60000*minutenumber_3)
              {
                minutetime_3 = minutetime_3 + (times_3[0][i] - ((minutenumber_3)*60000-60000));
                output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                minutetime_3 = 0; 
                minutenumber_3++; 
              }
              
              // check for extreme upper border plus lower border case
              else if (i>0 && (times_3[0][i-1] < (minutenumber_3*60000-60000)) && times_3[0][i] >= 60000*minutenumber_3)
              {
                minutetime_3 = 60000; 
                output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                minutetime_3 = 0; 
                minutenumber_3++; 
              }
              
               // check for extreme upper border minus lower border case 
              else if (i>0 && (times_3[0][i-1] >= (minutenumber_3*60000-60000)) && times_3[0][i] > 60000*minutenumber_3)
              {
                if (times_3[0][i-1] < (minutenumber_3*60000))
                {
                  minutetime_3 = minutetime_3 + (60000*minutenumber_3 - times_3[0][i-1]); 
                  output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                  minutetime_3 = 0; 
                  minutenumber_3++;  
                }
                else if (times_3[0][i-1] >= (minutenumber_3*60000))
                {
                  output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                  minutetime_3 = 0; 
                  minutenumber_3++; 
                }
              }
              
              // simply add value of non-border case
              else 
              {
                minutetime_3 = minutetime_3 + times_3[1][i];
                output.println("Minute " + (minutenumber_3) + ": " + (minutetime_3) + " ms"); 
                minutetime_3 = 0; 
                minutenumber_3++; 
              }
            }
          }
        }
      }
      else 
      {
        if (minutenumber_3 <= totalminutes_m)
        {
         output.println("Minute " + (minutenumber_3) + ": 0 ms");
        }
         minutenumber_3++; 
      }
    }
    output.println(' ');
    
    output.println("Key 4 Press Times (press, release, duration)");
    for(int i = 0; i < arraylength_4; i++)
    {
      if ((i & 1)==1)
      {
        output.println(times_4[0][i]); 
      }
      else 
      {
        for (int j = 0; j < 2; j++)
      {
        output.println(times_4[j][i]); 
      }
        output.println(' '); 
      }
    }
    output.println("Key 4 Press Number: " + (arraylength_4-1)*0.5); 
    output.println(' ');
    
    output.println("Key 4 Press Times by Minute");
    for(int j = 0; j < totalminutes_m; j++)
    {
      if (minutenumber_4 <= totalminutes_4) 
      {
        for(int i = cutoff; i < arraylength_4; i++)
        {
          //odd values in array
          if ((i & 1)==0)  
          {
            //maintain loop within same minute number
            if ((times_4[0][i] >= (minutenumber_4*60000-60000)) && (times_4[0][i] < 60000*minutenumber_4) && i < arraylength_4-1)
            {
              
              //account for non-extreme lower border case
              if (i>0 && (times_4[0][i-1] < (minutenumber_4*60000-60000)))
              {
                minutetime_4 = times_4[0][i] - ((minutenumber_4)*60000-60000);
              } 
 
              // simply add value of non-border case
              else 
              {
                minutetime_4 = minutetime_4 + times_4[1][i];
              }
            }
            
            // account for upper border case and proceed to next minute number
            else if (times_4[0][i] >= 60000*minutenumber_4 && i < arraylength_4-1 && (times_4[0][i] < (60000*minutenumber_4 + 60000)))
            {
                if (i>0 && times_4[0][i-1] < 60000*minutenumber_4 && times_4[0][i-1] >= (60000*minutenumber_4-60000))
                {
                    minutetime_4 = minutetime_4 + (60000*minutenumber_4-times_4[0][i-1]); 
                    output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms");
                    minutetime_4 = 0; 
                    minutenumber_4++; 
                    if (i < arraylength_4-1)
                    {
                      i = i-1; 
                    }
                } 
                else if (i>0 && times_4[0][i-1] < (60000*minutenumber_4-60000))
                {
                    minutetime_4 = 60000; 
                    output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms");
                    minutetime_4 = 0; 
                    minutenumber_4++; 
                    if (i < arraylength_4-1)
                    {
                      i = i-1; 
                    }
                }
                else
                {
                    output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                    minutetime_4 = 0; 
                    minutenumber_4++;
                   if (i < arraylength_4-1)
                    {
                      i = i-1; 
                    }  
                }
            }
            
            // account for extreme upper border case
            else if ((times_4[0][i] >= 60000*minutenumber_4 + 60000) && i < arraylength_4-1)
            {
              if (times_4[0][i-1] < (60000*minutenumber_4-60000))
              {
               minutetime_4 = 60000; 
               output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
               minutetime_4 = 0; 
               minutenumber_4++; 
                if (i < arraylength_4-1)
                    {
                      i = i-1; 
                    } 
              }
              else if (times_4[0][i-1] >= (60000*minutenumber_4-60000))
              {
                if (times_4[0][i-1] < (60000*minutenumber_4))
                {
                   minutetime_4 = minutetime_4 + (60000*minutenumber_4)-times_4[0][i-1]; 
                   output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                   minutetime_4 = 0; 
                   minutenumber_4++; 
                  if (i < arraylength_4-1)
                  {
                      i = i-1; 
                  }
                } 
                else if (times_4[0][i-1] >= (60000*minutenumber_4))
                {
                   output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                   minutetime_4 = 0; 
                   minutenumber_4++; 
                  if (i < arraylength_4-1)
                  {
                      i = i-1; 
                  }
                } 
              }
                
            }
            else if (i == arraylength_4-1)
            {
               //account for lower border case
              if (i>0 && (times_4[0][i-1] < (minutenumber_4*60000-60000)) && times_4[0][i] < 60000*minutenumber_4)
              {
                minutetime_4 = minutetime_4 + (times_4[0][i] - ((minutenumber_4)*60000-60000));
                output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                minutetime_4 = 0; 
                minutenumber_4++; 
              }
              
              // check for extreme upper border plus lower border case
              else if (i>0 && (times_4[0][i-1] < (minutenumber_4*60000-60000)) && times_4[0][i] >= 60000*minutenumber_4)
              {
                minutetime_4 = 60000; 
                output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                minutetime_4 = 0; 
                minutenumber_4++; 
              }
              
               // check for extreme upper border minus lower border case 
              else if (i>0 && (times_4[0][i-1] >= (minutenumber_4*60000-60000)) && times_4[0][i] > 60000*minutenumber_4)
              {
                if (times_4[0][i-1] < (minutenumber_4*60000))
                {
                  minutetime_4 = minutetime_4 + (60000*minutenumber_4 - times_4[0][i-1]); 
                  output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                  minutetime_4 = 0; 
                  minutenumber_4++;  
                }
                else if (times_4[0][i-1] >= (minutenumber_4*60000))
                {
                  output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                  minutetime_4 = 0; 
                  minutenumber_4++; 
                }
              }
              
              // simply add value of non-border case
              else 
              {
                minutetime_4 = minutetime_4 + times_4[1][i];
                output.println("Minute " + (minutenumber_4) + ": " + (minutetime_4) + " ms"); 
                minutetime_4 = 0; 
                minutenumber_4++; 
              }
            }
          }
        }
      }
      else 
      {
        if (minutenumber_4 <= totalminutes_m)
        {
         output.println("Minute " + (minutenumber_4) + ": 0 ms");
        }
         minutenumber_4++; 
      }
    }
    output.println(' ');
    
    output.println("Key 5 Press Times (press, release, duration)");
    for(int i = 0; i < arraylength_5; i++)
    {
      if ((i & 1)==1)
      {
        output.println(times_5[0][i]); 
      }
      else 
      {
        for (int j = 0; j < 2; j++)
      {
        output.println(times_5[j][i]); 
      }
        output.println(' '); 
      }
    }
    output.println("Key 5 Press Number: " + (arraylength_5-1)*0.5); 
    output.println(' ');
    
     output.println("Key 5 Press Times by Minute");
    for(int j = 0; j < totalminutes_m; j++)
    {
      if (minutenumber_5 <= totalminutes_5) 
      {
        for(int i = cutoff; i < arraylength_5; i++)
        {
          //odd values in array
          if ((i & 1)==0)  
          {
            //maintain loop within same minute number
            if ((times_5[0][i] >= (minutenumber_5*60000-60000)) && (times_5[0][i] < 60000*minutenumber_5) && i < arraylength_5-1)
            {
              
              //account for non-extreme lower border case
              if (i>0 && (times_5[0][i-1] < (minutenumber_5*60000-60000)))
              {
                minutetime_5 = times_5[0][i] - ((minutenumber_5)*60000-60000);
              } 
 
              // simply add value of non-border case
              else 
              {
                minutetime_5 = minutetime_5 + times_5[1][i];
              }
            }
            
            // account for upper border case and proceed to next minute number
            else if (times_5[0][i] >= 60000*minutenumber_5 && i < arraylength_5-1 && (times_5[0][i] < (60000*minutenumber_5 + 60000)))
            {
                if (i>0 && times_5[0][i-1] < 60000*minutenumber_5 && times_5[0][i-1] >= (60000*minutenumber_5-60000))
                {
                    minutetime_5 = minutetime_5 + (60000*minutenumber_5-times_5[0][i-1]); 
                    output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms");
                    minutetime_5 = 0; 
                    minutenumber_5++; 
                    if (i < arraylength_5-1)
                    {
                      i = i-1; 
                    }
                } 
                else if (i>0 && times_5[0][i-1] < (60000*minutenumber_5-60000))
                {
                    minutetime_5 = 60000; 
                    output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms");
                    minutetime_5 = 0; 
                    minutenumber_5++; 
                    if (i < arraylength_5-1)
                    {
                      i = i-1; 
                    }
                }
                else
                {
                    output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                    minutetime_5 = 0; 
                    minutenumber_5++;
                   if (i < arraylength_5-1)
                    {
                      i = i-1; 
                    }  
                }
            }
            
            // account for extreme upper border case
            else if ((times_5[0][i] >= 60000*minutenumber_5 + 60000) && i < arraylength_5-1)
            {
              if (times_5[0][i-1] < (60000*minutenumber_5-60000))
              {
               minutetime_5 = 60000; 
               output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
               minutetime_5 = 0; 
               minutenumber_5++; 
                if (i < arraylength_5-1)
                    {
                      i = i-1; 
                    } 
              }
              else if (times_5[0][i-1] >= (60000*minutenumber_5-60000))
              {
                if (times_5[0][i-1] < (60000*minutenumber_5))
                {
                   minutetime_5 = minutetime_5 + (60000*minutenumber_5)-times_5[0][i-1]; 
                   output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                   minutetime_5 = 0; 
                   minutenumber_5++; 
                  if (i < arraylength_5-1)
                  {
                      i = i-1; 
                  }
                } 
                else if (times_5[0][i-1] >= (60000*minutenumber_5))
                {
                   output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                   minutetime_5 = 0; 
                   minutenumber_5++; 
                  if (i < arraylength_5-1)
                  {
                      i = i-1; 
                  }
                } 
              }
                
            }
            else if (i == arraylength_5-1)
            {
               //account for lower border case
              if (i>0 && (times_5[0][i-1] < (minutenumber_5*60000-60000)) && times_5[0][i] < 60000*minutenumber_5)
              {
                minutetime_5 = minutetime_5 + (times_5[0][i] - ((minutenumber_5)*60000-60000));
                output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                minutetime_5 = 0; 
                minutenumber_5++; 
              }
              
              // check for extreme upper border plus lower border case
              else if (i>0 && (times_5[0][i-1] < (minutenumber_5*60000-60000)) && times_5[0][i] >= 60000*minutenumber_5)
              {
                minutetime_5 = 60000; 
                output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                minutetime_5 = 0; 
                minutenumber_5++; 
              }
              
               // check for extreme upper border minus lower border case 
              else if (i>0 && (times_5[0][i-1] >= (minutenumber_5*60000-60000)) && times_5[0][i] > 60000*minutenumber_5)
              {
                if (times_5[0][i-1] < (minutenumber_5*60000))
                {
                  minutetime_5 = minutetime_5 + (60000*minutenumber_5 - times_5[0][i-1]); 
                  output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                  minutetime_5 = 0; 
                  minutenumber_5++;  
                }
                else if (times_5[0][i-1] >= (minutenumber_5*60000))
                {
                  output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                  minutetime_5 = 0; 
                  minutenumber_5++; 
                }
              }
              
              // simply add value of non-border case
              else 
              {
                minutetime_5 = minutetime_5 + times_5[1][i];
                output.println("Minute " + (minutenumber_5) + ": " + (minutetime_5) + " ms"); 
                minutetime_5 = 0; 
                minutenumber_5++; 
              }
            }
          }
        }
      }
      else 
      {
        if (minutenumber_5 <= totalminutes_m)
        {
         output.println("Minute " + (minutenumber_5) + ": 0 ms");
        }
         minutenumber_5++; 
      }
    }
    output.println(' ');
    
    output.flush();
    output.close();
}

