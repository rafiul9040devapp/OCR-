// Binary search for exact matching
int binarySearch(List<String> sortedList, String target) {
  int left = 0;
  int right = sortedList.length - 1;

  while (left <= right) {
    int middle = (left + right) ~/ 2;
    int compare = sortedList[middle].toLowerCase().compareTo(target.toLowerCase());

    if (compare == 0) {
      return middle;  // Exact match found
    } else if (compare < 0) {
      left = middle + 1;
    } else {
      right = middle - 1;
    }
  }

  return -1;  // No match found
}

// Levenshtein distance for fuzzy matching
int levenshteinDistance(String s1, String s2) {
  List<List<int>> dp = List.generate(
      s1.length + 1,
          (i) => List.generate(s2.length + 1, (j) => 0)
  );

  for (int i = 0; i <= s1.length; i++) {
    for (int j = 0; j <= s2.length; j++) {
      if (i == 0) {
        dp[i][j] = j;
      } else if (j == 0) {
        dp[i][j] = i;
      } else if (s1[i - 1] == s2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].reduce((a, b) => a < b ? a : b);
      }
    }
  }

  return dp[s1.length][s2.length];
}

// Calculate similarity between two strings
double calculateSimilarity(String s1, String s2) {
  int maxLength = s1.length > s2.length ? s1.length : s2.length;
  if (maxLength == 0) return 1.0;  // Both strings are empty

  int distance = levenshteinDistance(s1, s2);
  return 1.0 - (distance / maxLength);  // Return similarity as a percentage
}