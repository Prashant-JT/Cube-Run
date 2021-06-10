public class Objects {  
  private ArrayList <Obstacle> objects;

  public Objects() {
    this.objects = new ArrayList<Obstacle>();
  }

  public void addBody(Obstacle obj) {
    this.objects.add(obj);
  }

  public ArrayList<Obstacle> getList() {
    return this.objects;
  }

  public void resetList () {
    this.objects.clear();
  }
}
