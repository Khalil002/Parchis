class CircularLinkedList{
  Node ptr;
  
  public CircularLinkedList(int n){
    ptr = null;
    Node p = null;
    for(int i=1; i<=n; i++){
      if(ptr == null){
        ptr = p = new Node(0, i);
      }else{
        p.next = new Node(0, i);
        p = p.next;
      }
      
    }
    p.next = ptr;
  }
  
  public Node getNode(int n){
    Node p = ptr;
    int i=1;
    while(i<n){
      
      p = p.next;
      i++;
      
    }
    return p;
  }
}
