public class Camera {
  private PVector loc;
  private ArrayList<Triangle> Triangles = new ArrayList<Triangle>();
  private float fromScreen = 300;
  
  public Camera() {
    this.loc = new PVector(0, 0, -300);
  }
  
  void proj(Triangle t) {
    if (!(t.points[0].z < loc.z && t.points[1].z < -1 * fromScreen && t.points[2].z < -1 * fromScreen)) {
      float[][] pT = new float[3][2];
      int count = 0;
      for (PVector point : t.points) {
        try {
          float scX = 0;
          float scY = 0;
          if (point.z <= -1 * fromScreen) {
            scX = (((fromScreen * point.x) / ((-1 * fromScreen + 1) + fromScreen)) + width/2);
            scY = (((fromScreen * point.y) / ((-1 * fromScreen + 1) + fromScreen)) + height/2);
          } else {      
            scX = (((fromScreen * point.x) / (point.z + fromScreen)) + width/2);
            scY = (((fromScreen * point.y) / (point.z + fromScreen)) + height/2);
          }
          pT[count][0] = scX;
          pT[count][1] = scY;
          count++;
        } 
        catch (Exception e) {
          break;
        }
      }
      fill(t.clr);
      //if (!quantize) noStroke();
      triangle(pT[0][0], pT[0][1], pT[1][0], pT[1][1], pT[2][0], pT[2][1]);
    }
  }
  void display() {
    for (Triangle t : Triangles) {
      t.update_close();
    }
    Collections.sort(Triangles);
    //Collections.sort(sc.getTriangles());
    //for (Triangle t : sc.getTriangles()) {
    //  proj(t);
    //}
    for (Triangle t : Triangles) {
      //if (t.ID != -1) 
      proj(t);
    }
  }
  void addTriangle (Triangle a) {
    Triangles.add(a);
  }
}
