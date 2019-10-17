def boyer_moore(s, t, pre_s=None):
    if pre_s is None:
        pre_s = preprocess(s)                                           # preprocess s if needed
    counter = 0                                                         # count number of comparisons
    i = 0
    occurrences = []
    while i < len(t) - len(s) + 1:                                      # loop over start positions for s
        shift = 1
        mismatched = False
        for j in range(start=len(s), stop=-1, step=-1):                 # start counting from right (Longer Skip Rule)
            counter += 1
            if s[j] != t[i + j]:                                        # if mismatch
                shift_bad_char = pre_s.bad_char(j, t[i + j])            # calculate skips due to Bad Character Rule
                shift_good_suffix = pre_s.good_suffix(j)                # calculate skips due to Good Suffix Rule
                shift = max(shift, shift_bad_char, shift_good_suffix)   # skip as many as guaranteed
                mismatched = True
                break
        if not mismatched:                                              # store i if everything matches
            occurrences.append(i)
            shift_good_suffix = pre_s.match_skip()                      # given it matched, calc how many to skip
            shift = max(shift, shift_good_suffix)                       # skip as many as possible
        i += shift
    return occurrences, counter


def pre_bad_char(s, alphabet=['A', 'C', 'G', 'T']):
    last_seen = {a: 0 for a in alphabet}                        # keep track of last time you've seen a character
    skips = {a: [None] * len(s) for a in alphabet}              # skips to calculate
    for i, a in enumerate(alphabet):                            # set first column to 0 since none to skip
        if s[0] != a:
            skips[a][0] = 0
    for i, char in enumerate(s):                                # iterate over s
        for a in alphabet:
            if s[i] != a:
                skips[a][i] = last_seen[a]                      # record how many times ago you saw this character
        last_seen = {a: (j + 1) for a, j in last_seen.items()}  # update counts
        last_seen[char] = 0                                     # except for the character you just saw
    return skips

def pre_good_suffix(s):
    pass

def print_bm(s, t):
    print(t)
    occurrences, counter = boyer_moore(s, t)
    for i in occurrences:
        print(' ' * i + s)
    print(occurrences)
    print(counter, 'comparisons')
    print('')
    return occurrences

pre_s = preprocess(s)                                               # preprocess skips on s
print(preprocess('TCGCC'))

