class LinkedList{
  Node ptr;
  
  public LinkedList(int n, int pos){
    ptr = null;
    Node p = null;
    
    for(int i=0; i<n; i++){
      if(ptr == null){
        ptr = p = new Node(0, pos+i);
      }else{
        p.next = new Node(0, pos+i);
        p = p.next;
      }
    }
  }
  
}
