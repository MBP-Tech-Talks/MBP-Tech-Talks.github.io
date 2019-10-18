def naive(s, t):
    counter = 0                             # count number of comparisons
    occurrences = []                        # placeholder for all occurrences of s in t
    for i in range(len(t) - len(s) + 1):    # loop over all alignments of s against t
        match = True                        # assume there's a match
        for j in range(len(s)):             # loop over all characters in s
            counter += 1                    # add 1 to counter
            if t[i + j] != s[j]:            # if characters don't match
                match = False               # there's no match at position i
                break
        if match:                           # if no mismatch found, then record position i
            occurrences.append(i)
    return occurrences, counter

def print_naive(s, t):
    print(t)
    occurrences, counter = naive(s, t)
    for i in occurrences:
        print(' ' * i + s)
    print(occurrences)
    print(counter, 'comparisons')
    print('')
    return occurrences

print_naive("TATC", "TATCGTGA")
print_naive("AAA", "AAAAAAAAAAAAAAAA")
print_naive("ACGG", "GTGTGTGTGTGTGTGTGTGT")