import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
      buttons = new  MSButton[NUM_ROWS][NUM_COLS];
     for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r, c);
    //your code to initialize buttons goes here
    
    
    for(int i=0;i<13;i++)
    setMines();
}
public void setMines()
{
  int rOW=(int)(Math.random()*NUM_ROWS);
  int cOL=(int)(Math.random()*NUM_COLS);
  if(!mines.contains(buttons[rOW][cOL])){
  mines.add(buttons[rOW][cOL]);
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r=0;r<NUM_ROWS;r++)
     for(int c=0;c<NUM_COLS;c++)
       if(!buttons[r][c].isFlagged()&&!buttons[r][c].isClicked())
        return false;
    return true;
}
public void displayLosingMessage()
{
  for (int r=0; r<NUM_ROWS; r++){
    for (int c=0; c<NUM_COLS; c++){
      if (mines.contains(buttons[r][c])&& !buttons[r][c].isClicked()){
        buttons[r][c].flagged=false;
        buttons[r][c].clicked=true;
      }
    }
  }
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel("");
    buttons[9][10].setLabel("L");
    buttons[9][11].setLabel("O");
    buttons[9][12].setLabel("S");
    buttons[9][13].setLabel("E");  
}
public void displayWinningMessage()
{
    for(int i = mines.size()-1; i >= 0; i--){
    mines.remove(i);
  }    
    for (int r=0; r<NUM_ROWS; r++){
    for (int c=0; c<NUM_COLS; c++){ 
        buttons[r][c].flagged=false;
        buttons[r][c].clicked=true;
        buttons[r][c].setLabel("");
    }
  }
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][9].setLabel("");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
}
public boolean isValid(int r, int c)
{
    if(r>=0&&r<NUM_ROWS&&c>=0&&c<NUM_COLS)
    return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r=row-1;r<=row+1;r++){
     for(int c=col-1;c<=col+1;c++){
       if(isValid(r,c)&&mines.contains(buttons[r][c])){
         numMines++;
     }
    }
}
 return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
         clicked = true;
        if(keyPressed && keyCode == 16){
            flagged = !flagged;
            if(!flagged) clicked = false;
        } else if(mines.contains(this)){
            displayLosingMessage();
        } else if(countMines(myRow,myCol) > 0){
           myLabel = "" + countMines(myRow,myCol);
        } else {
            if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].clicked) 
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].clicked) 
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol+1)  && !buttons[myRow-1][myCol+1].clicked) 
                buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].clicked) 
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].clicked) 
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].clicked) 
                buttons[myRow-1][myCol-1].mousePressed();
            if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].clicked) 
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].clicked) 
                buttons[myRow-1][myCol].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
     return clicked;
    }
}
