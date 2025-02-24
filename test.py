dictionary = input().split()
sentence = input().split()
output = []
def samePrefix(root,word):
    i = 0
    if len(root)>len(word):
        return False
    while i<len(root):
        if word[i] != root[i]:
            return False
        i += 1
    return True

dictionary.sort()
for word in sentence:
    has_root = False
    for root in dictionary:
        if samePrefix(root, word):
            output.append(root)
            has_root = True
            break
    if not has_root:
        output.append(word)
print(" ".join(output))