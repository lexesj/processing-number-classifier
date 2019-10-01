import io.github.lexesjan.machinelearning.NeuralNetwork;
import io.github.lexesjan.machinelearning.datawrapper.Image;
import io.github.lexesjan.machinelearning.util.MNISTLoader;
import java.util.Arrays;

final String FILE_NAME = "number";
final String IMAGE_EXTENSION = "png";
char guess;
Canvas canvas;
Button button0;
Button button1;
Button button2;
NeuralNetwork nn;
Image[] trainingData;
Image[] testData;

void settings() {
  size(640, 640);
}

void setup() {
  try {
    Image[][] data = MNISTLoader.loadDataWrapper(dataPath("mnist dataset"));
    trainingData = data[0];
    testData = data[1];
    nn = new NeuralNetwork(new int[]{trainingData[0].numRows(), 100, 10});
    button0 = new Button(10, 10, 100, 50, color(0), "train");
    button1 = new Button(button0.x() + button0.width() + 10, 10, button0.width(), button0.height(), color(0), "guess");
    button2 = new Button(button1.x() + button1.width() + 10, 10, button1.width(), button1.height(), color(0), "clear");
    canvas = new Canvas(width / 2 - 200, height / 2 - 200, 400, 400, color(255));
    guess = '?';
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}


void draw() {
  background(255);
  button0.draw();
  button1.draw();
  button2.draw();
  canvas.draw();
  filter(INVERT);
  textAlign(LEFT);
  text("The guess is " + guess, 10, height - 10);
}

void mouseClicked() {
  if (button0.mouseClicked() && button0.number() == 0) {
    println("Training neural network");
    nn.train(1, 3, 10, trainingData, testData);
  }
  if (button1.mouseClicked() && button1.number() == 1) {
    stroke(0);
    guess = (char) (guess() + '0');
  }
  if (button2.mouseClicked() && button2.number() == 2) {
    canvas.clear();
  }
}

void mouseMoved() {
  ((Canvas) canvas).mouseMoved();
}

void mouseDragged() {
  ((Canvas) canvas).mouseDragged();
}

int guess() {
  saveNumber(FILE_NAME, IMAGE_EXTENSION);
  Image number = null;
  try {
    number = new Image(NeuralNetwork.fileToMatrix(dataPath(FILE_NAME + "." + IMAGE_EXTENSION)), new SimpleMatrix(new double[][]{{1}}));
  } 
  catch (IOException e) {
  }
  number.normalise();
  number.flatten();
  number = new Image(number.getImageData(), nn.feedForward(number.getInput()));
  return number.getLabel();
}

void saveNumber(String name, String extension) {
  canvas.save("data/" + name + "." + extension);
}
