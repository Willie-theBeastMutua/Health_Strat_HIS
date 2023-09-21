
def linear_search(list, target):
    indexi = 0

    for item in list:
        if item == target:
            return indexi
            
        indexi += 1
    return None
numbers = [1,2,3,4,5,6,7,8,9]
def verify(index):
    if index != None:
        print("Target found at:", index)
    else:
        print("target not found")
result = linear_search(numbers, 10)
verify(result)        