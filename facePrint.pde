// Library Imports for program 
import processing.video.*;
import gab.opencv.*;
import java.awt.*;
import java.io.File;

// Variables called in Program
OpenCV opencv;
Capture cam;
PImage smaller;
PImage finalImageMouth;
PImage finalImageNose;
PImage finalImageEyes;
Rectangle[] face;
Rectangle[] mouth;
Rectangle[] eye;
Rectangle[] nose;
String[] filenameEyes;
String[] filenameMouth;
String[] filenameNose;
int scale = 4;
String myText = "Type Your Name";
int i;
int[] locFace1;
int[] locFace2;
int xMouth;
int yMouth;
int xEye;
int yEye;
int xNose;
int yNose;
int testNum = 0;
int faceNum;
ArrayList<PImage> finalEyes = new ArrayList<PImage>();
ArrayList<PImage> finalNose = new ArrayList<PImage>();
ArrayList<PImage> finalMouth = new ArrayList<PImage>();

//File IO to create new data folders to pull images from later 
java.io.File Eyefolder = new java.io.File(dataPath("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partEyeNumbers"));
java.io.File Nosefolder = new java.io.File(dataPath("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partNoseNumbers"));
java.io.File Mouthfolder = new java.io.File(dataPath("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partMouthNumbers"));

// IO Filter to check if there are .jpgs in the Data folders.
java.io.FilenameFilter jpgFilter = new java.io.FilenameFilter() {
 boolean accept(File dir, String name) {
   return name.toLowerCase().endsWith(".jpg");
 }
};



//Setup that starts the webcam and creates the canvas size
void setup() {
  size(640, 480);
  textAlign(BOTTOM, RIGHT);
  textSize(30);
  fill(0);
  // starts the webcame capture
  cam = new Capture(this, 640, 480);
  cam.start();
  opencv = new OpenCV(this, cam.width/scale, cam.height/scale);
  smaller = createImage(opencv.width, opencv.height, RGB);
  
  // list files in data folders
  filenameEyes = Eyefolder.list(jpgFilter);
  filenameNose = Nosefolder.list(jpgFilter);
  filenameMouth = Mouthfolder.list(jpgFilter);
  
  // prints the number of files that are jpgs in data folders
  println(filenameEyes.length + " jpg files in specified directory");
  println(filenameNose.length + " jpg files in specified directory");
  println(filenameMouth.length + " jpg files in specified directory");
  
  // print the filenames in data folders
  for (int i = 0; i < filenameEyes.length; i++) println(filenameEyes[i]);
  for (int i = 0; i < filenameNose.length; i++) println(filenameNose[i]);
  for (int i = 0; i < filenameMouth.length; i++) println(filenameMouth[i]);
}

//Capture's webcam data
void captureEvent(Capture cam) {
  cam.read();
  smaller.copy(cam, 0, 0, cam.width, cam.height, 0, 0, smaller.width, smaller.height);
  smaller.updatePixels();
}

//Draws the webcam data 
void draw() {
  // Opencv to detect eyes nore and mouths and have each detections be a seperate variable
  opencv.loadImage(smaller);
  opencv.loadCascade(OpenCV.CASCADE_MOUTH);
  mouth = opencv.detect();
  opencv.loadCascade(OpenCV.CASCADE_NOSE);
  nose = opencv.detect();
  opencv.loadCascade(OpenCV.CASCADE_EYE);
  eye = opencv.detect();
  // splits detected features in to x and y locations 
  for (i = 0; i < mouth.length; i++)  {
    xMouth = mouth[i].x*scale;
    yMouth = mouth[i].y*scale;
  }
  for (i = 0; i < nose.length; i++)  {
    xNose = nose[i].x*scale;
    yNose = nose[i].y*scale;
  }
  for (i = 0; i < eye.length; i++)  {
    xEye = eye[i].x*scale;
    yEye = eye[i].y*scale;
  }
  image(cam.get(),0,0);
  
  // creates test cases for various overlays of facial features stored in data folders on users. 
  //Of note: Each feature drawn has a coresponding box to indicate what feature it should be: Black - Nose; Grey - Eye; White - Mouth; 
 // case 1 for eyes only 
  if (testNum == 1) {
    // the for loops prints an additional number of a select feature based on a randomly generate number between 1 and 6
    for ( i = 0; i < faceNum; i++) {
    tint(255, 126);
    image(finalEyes.get(i),xEye,yEye);
    }
    fill(127);
    rect(xEye, yEye, 10, 10);
  }
  // case 2 for mouths only
  else if (testNum == 2) {
    for ( i = 0; i < faceNum; i++) {
    tint(255, 126);
    image(finalMouth.get(i), xMouth, yMouth);
    }
    fill(255);
    rect(xMouth, yMouth, 20,20);
  }
  // case 3 for Noses only
  else if (testNum == 3) {
    for ( i = 0; i < faceNum; i++) {
    tint(255, 126);
    image(finalNose.get(i), xNose, yNose);
    }
    fill(0);
    rect(xNose, yNose, 15,15);
  }
  // case 4 for eyes and mouths 
  else if (testNum == 4) {
    tint(255, 126);
    image(finalEyes.get(0),xEye,yEye);
    fill(127);
    rect(xEye, yEye, 10,10);
    tint(255, 126);
    image(finalMouth.get(0), xMouth, yMouth);
    fill(255);
    rect(xMouth, yMouth, 20,20);
  }
  // case 5 for mouths and noses
  else if (testNum == 5) {
    tint(255, 126);
    image(finalMouth.get(0), xMouth, yMouth);
    fill(255);
    rect(xMouth, yMouth, 20,20);
    tint(255, 126);
    image(finalNose.get(0), xNose, yNose);
    fill(0);
    rect(xNose, yNose, 15,15);
  }
  // case 6 for eyes, noses and mouths
  else if (testNum == 6) {
    tint(255, 126);
    image(finalMouth.get(0), xMouth, yMouth);
    fill(255);
    rect(xMouth, yMouth, 20,20);
    tint(255, 126);
    image(finalNose.get(0), xNose, yNose);
    fill(0);
    rect(xNose, yNose, 15,15);
    tint(255, 126);
    image(finalEyes.get(0),xEye, yEye);
    fill(127);
    rect(xEye, yEye, 10,10);
  }
  
  //Text which diplays at bottom of screen to instruct users.   
  fill(255);
  text(myText, 0,0, width, height);
  textSize(24);
  text("Click mouse to save faces to image files",10,height-30);
}

// Mousepressed function which stores user's face and both subdivides and stores face into corresponding parts.  
void mousePressed() {
  opencv.loadImage(smaller);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  face = opencv.detect();
  opencv.loadCascade(OpenCV.CASCADE_NOSE);
  nose = opencv.detect();
  image(cam, 0, 0);
  // checks if there is a face on camera. If there is no face nothing will happen
  if (face != null) {
    //Check if there is a face and there is a nose detected. If so the nose is cropped and saved to a folder. The x- and y- locations are stored as a variables for later use
    for (int i = 0; i < nose.length; i++) {
      PImage cropped = createImage(nose[i].width*scale, nose[i].height*scale, RGB);
      cropped.copy(cam, nose[i].x*scale, nose[i].y*scale, nose[i].width*scale, nose[i].height*scale, 0, 0, nose[i].width*scale, nose[i].height*scale);
      cropped.updatePixels(  );
      cropped.save("facePartsNose/"+myText+"-faces-"+i+".jpg");
      xNose = nose[i].x*scale;
      yNose = nose[i].y*scale;
    }
    //Checks if there is a face and if there are eyes. If so the eyes are cropped and saved to a folder. The x- and y- locations are stored as a variables for later use 
    opencv.loadCascade(OpenCV.CASCADE_EYE);
    eye = opencv.detect();
    image(cam, 0, 0);
    for (int i = 0; i < eye.length; i++) {
      PImage cropped = createImage(eye[i].width*scale, eye[i].height*scale, RGB);
      cropped.copy(cam, eye[i].x*scale, eye[i].y*scale, eye[i].width*scale, eye[i].height*scale, 0, 0, eye[i].width*scale, eye[i].height*scale);
      cropped.updatePixels(  );
      cropped.save("facePartsEye/"+myText+"-faces-"+i+".jpg");
      xEye = eye[i].x*scale;
      yEye = eye[i].y*scale;
    }
    opencv.loadCascade(OpenCV.CASCADE_MOUTH);
    mouth = opencv.detect();
    //Checks if there is a face and if there is a mouth. If so the mouth is cropped and saved to a folder. The x- and y- locations are stored as a variables for later use. 
    image(cam, 0, 0);
    for (int i = 0; i < mouth.length; i++) {
      PImage cropped = createImage(mouth[i].width*scale, mouth[i].height*scale, RGB);
      cropped.copy(cam, mouth[i].x*scale, mouth[i].y*scale, mouth[i].width*scale, mouth[i].height*scale, 0, 0, mouth[i].width*scale, mouth[i].height*scale);
      cropped.updatePixels(  );
      cropped.save("facePartsMouth/"+myText+"-faces-"+i+".jpg");
      xMouth = mouth[i].x*scale;
      yMouth = mouth[i].y*scale;
    }
    image(cam, 0, 0);
    //Checks if there is a face. Crops and saves faces to a folder. 
    for (int i = 0; i < face.length; i++) {
      PImage cropped = createImage(face[i].width*scale, face[i].height*scale, RGB);
      cropped.copy(cam, face[i].x*scale, face[i].y*scale, face[i].width*scale, face[i].height*scale, 0, 0, face[i].width*scale, face[i].height*scale);
      cropped.updatePixels(  );
      cropped.save("face/"+myText+"-faces-"+i+".jpg");
  }
  }  
      background(0);
      image(cam, 0, 0);
      //Generates a random variable for number of layers in case 1-3 
      faceNum = int(random(1,6));
      // using ArrayList<string> iterate random images into the array faceNum times.
      for (int i = 0; i < faceNum; i++) {
        finalImageEyes = loadImage("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partEyeNumbers/" + filenameEyes[int(random(0,filenameEyes.length))]);
        finalImageNose = loadImage("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partNoseNumbers/" + filenameNose[int(random(0,filenameNose.length))]);
        finalImageMouth = loadImage("C:/Users/Javier/Desktop/LMC 6310/Processing/Project Faces/faceBase2Test/partMouthNumbers/" + filenameMouth[int(random(0,filenameMouth.length))]);
        finalEyes.add(finalImageEyes);
        finalNose.add(finalImageNose);
        finalMouth.add(finalImageMouth);
      };   
} 
     
//Sections indicates what happens if keys are pressed. 
void keyPressed() {
  // Triggers case 1 - Eyes from files places over user's eyes
  if (key == '1') {
    testNum = 1;
    println(testNum);
  }
  // Triggers case 2 - Mouths from files places over user's mouth
  else if (key == '2') {
    testNum = 2;
    println(testNum);
  }
  // Triggers case 3 - Noses from files places over user's nose
  else if (key == '3') {
    testNum = 3;
    println(testNum);
  }
  // Triggers case 4 -  Eyes and Mouths from files places over user's eyes and mouth. 
  else if (key == '4') {
    testNum = 4;
    println(testNum);
  }
  // Triggers case 5 -  Mouths and Noses from files places over user's mouth and nose. 
  else if (key == '5') {
    testNum = 5;
    println(testNum);
  }
  // Triggers case 5 - Eyes, Mouths, and Noses from files places over user's eyes, mouth, and nose.
  else if (key == '6') {
    testNum = 6;
    println(testNum);
  }
  // If keyCode is backspace remove the last character in the myText string
  else if (keyCode == BACKSPACE) {
    if (myText.length() > 0) {
    myText = myText.substring(0, myText.length()-1);
    }
  }
  // if keyCode is delete make the current space in a string nothing  
  else if (keyCode == DELETE) {
    myText = "";
  }
  // If keyCode is enter save the current frame in finalImages folder 
  else if (keyCode == ENTER) {
    saveFrame("finalImages/" + myText + ".jpg");
  }
  // If keyCode is anything other than keyCodes below OR keys above add them to myText string
   else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT ) {
    myText = myText + key;
  }    
}
