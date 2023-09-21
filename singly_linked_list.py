# create class to define the node
class Node:
    data = None
    next_node = None 
    # add a constructor - to make class easier to create
    
    def __init__(self, data):
        self.data = data
    def __repr__(self):
        return "<Node data: %s>" % self.data
class linkedlist:
    # singly linked list    
    def __init__(self):
        self.head = None
    # checks if list is empty
    def is_empty(self):
        return self.head == None
    def size(self):
        # returns the number of nodes in the linked list
        current = self.head 
        count = 0
        
        while current:
            count += 1
            current = current.next_node 
        return count
    def add(self, data):
        new_node = Node(data)
        new_node.next_node = self.head
        self.head = new_node  
    def search(self, key):
        #search for the first node containing data that matches the key
        current = self.head
        
        while current:
            if current.data == key:
                return current
            else:
                current = current.next_node
        return None 
    def insert(self, data, index):
        # inserting a node in any index of the linked list
        if index == 0:
            self.add(data)
        if index > 0:
            new = Node(data)

            position = index
            current = self.head
            
            while position > 1:
                current = node.next_node 
                position -= 1
            prev = current
            next_node = current.next_node 
            prev.next_node = new
            new.next_node = next_node 
    def remove_key(self, data):
        # Removes node conitaining data that matches the key. key is data
        current = self.head
        prev = None 
        found = False
        
        while current and not found:
            if current.data == key and current is self.head:
                found = True 
                self.head = current.next_node
            elif current.data == key:
                found = True
                prev.next_node = current.next_node 
            else:
                prev = current
                current = current.next_node
        return current
    def __repr__(self):
        # repr implimentation to display string
        nodes = []
        current = self.head 
        
        while current:
            if current is self.head:
                nodes.append("[Head: %s]" % current.data)
            elif current.next_node is None:
                nodes.append("Tail: %s" % current.data)
            else: 
                nodes.append("[%s]" % current.data)
            current = current.next_node 
        return '-> '.join(nodes)