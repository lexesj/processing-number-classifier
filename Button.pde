public class Button extends Widget {
  private String label;
  
  public Button(float x, float y, float width, float height, int colour, String label) {
    super(x, y, width, height, colour);
    this.label = label;
  }
  
  public void draw() {
    fill(colour);
    rect(x, y, width, height);
    textAlign(CENTER);
    fill(255);
    text(label, x + width / 2, y + height / 2 + textAscent() / 2);
  }
  
  public boolean mouseClicked() {
    return super.isMouseOnWidget(mouseX, mouseY);
  }
}
