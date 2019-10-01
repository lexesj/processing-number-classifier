import java.util.LinkedList;
import java.util.List;

public class Canvas extends Widget {
  private class Line extends Widget {
    float x2, y2, thickness;

    public Line(float x, float y, float x2, float y2, int colour, float thickness) {
      super(x, y, 0, 0, colour);
      this.x2 = x2;
      this.y2 = y2;
      this.thickness = thickness;
    }

    public void draw() {
      strokeWeight(thickness);
      line(x, y, x2, y2);
      strokeWeight(1);
    }
  }

  private float previousX, previousY;
  private List<Line> lines;

  public Canvas(float x, float y, float width, float height, int colour) {
    super(x, y, width, height, colour);
    lines = new LinkedList<Line>();
    previousX = 0;
    previousY = 0;
  }

  public void draw() {
    rect(x, y, width, height);
    line(x + width / 2, y, x + width / 2, y + height);
    line(x, y + height / 2, x + width, y + height / 2);
    drawLines();
  }

  public void drawLines() {
    for (Line line : lines) {
      line.draw();
    }
  }
  
  public void mouseDragged() {
    if (super.isMouseOnWidget(mouseX, mouseY, 10)) {
      lines.add(new Line(previousX, previousY, mouseX, mouseY, 0, 30));
    }
    mouseMoved();
  }
  
  public void mouseMoved() {
    previousX = mouseX;
    previousY = mouseY;
  }
  
  public void clear() {
    lines.clear();
  }
  
  public void save(String fileName) {
    rect(x, y, width, height);
    drawLines();
    filter(INVERT);
    PImage canvas = get((int) x + 5, (int) y + 5, (int) width - 5, (int) height - 5);
    canvas.resize(28, 28);
    canvas.loadPixels();
    canvas.save(fileName);
  }
}
