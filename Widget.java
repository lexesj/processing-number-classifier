public abstract class Widget {
  public static int numWidgets = 0;
  protected float x, y, x2, y2, width, height;
  protected int colour, number;
  
  public Widget(float x, float y, float width, float height, int colour) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.colour = colour;
    number = numWidgets;
    numWidgets++;
  }
  
  public float x() {
   return x; 
  }
  
  public float y() {
   return y; 
  }
  
  public float width() {
   return width; 
  }
  
  public float height() {
   return height; 
  }
  
  public float number() {
   return number; 
  }
  
  public boolean isMouseOnWidget(float mouseX, float mouseY) {
    return isMouseOnWidget(mouseX, mouseY, 0);
  }
  
  public boolean isMouseOnWidget(float mouseX, float mouseY, float offset) {
    if(mouseX - offset >= x && mouseX + offset <= x + width && mouseY - offset >= y && mouseY + offset <= y + height) {
      return true;
    }
    return false;
  }
  
  public abstract void draw();
}
