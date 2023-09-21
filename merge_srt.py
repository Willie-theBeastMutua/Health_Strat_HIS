def merge_sort(list):
    #algo steps -  sorts a list in ascending order
    #divide the ist in the midpoint
    #conquer: recusively sort the sublists
    #merge the sorted sublists
    if len(list) <= 1:
        return list
    
    left_half, right_half = split(list)
    left = merge_sort(left_half)
    right = merge_sort(right_half)
    
    return merge(left, right)
def split(list):
    #divides the unsorted list at midpoint and return two sublists
    midpoint = len(list) // 2
    
    left = list[:midpoint]
    right = list[midpoint:]
    return left,right
def merge(left, right):
    # merges two lists while sorting them and returns a new merged list
    lsorted = []
    i = 0
    j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            lsorted.append(left[i])
            i += 1
        else:
            lsorted.append(right[j])
            j += 1
