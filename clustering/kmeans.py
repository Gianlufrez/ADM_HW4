"""Python module for methods related to a K-Means algorithm."""
import numpy as np


def closest_centroid(x, centroids):
    """Given the data point x, return the index of the smallest of the squared distances between x and each centroid.

    :args
    x - an iterable of numbers.
    centroids - a 2D numpy array where each row corresponds to a centroid.

    :returns
    (centroid_index, (x, 1))
    """

    x = np.array(x)

    distances = np.linalg.norm(x - centroids, axis=1)**2

    return np.argmin(distances), (x, 1)


def sum_points(point_count_1, point_count_2):
    """Sums two point counts.

    :arg
    point_count_1 (list, int) - a tuple containing a list representing a point and a count.
    point_count_2 (list, int) - a tuple containing a list representing a point and a count.

    :returns
    a tuple containing the element wise sum and the sum of the counts.
    """
    return np.array(point_count_1[0]) + np.array(point_count_2[0]), point_count_1[1] + point_count_2[1]


def centroid_diff(old_centroids, new_centroids):
    """Calculates the difference between two sets of centroids.

    :arg
    old_centroids (np.array) - a numpy array containing centroid coordinates as rows.
    new_centroids (np.array) - a numpy array containing centroid coordinates as rows.

    :returns
    a float value that is the difference between the two centroid sets.
    """
    return np.sum(np.abs(new_centroids - old_centroids))


def kmeans(data, n_clusters, max_iterations, threshold):
    """Runs kmeans on a given dataset using spark and MapReduce.

    :arg
    data - a spark RDD containing the data to be clustered.
    n_clusters (int) - the number of clusters.
    max_iterations (int) - the maximum number of iterations that this algorithm will make. Must be > 0.
    threshold (float) - the threshold used in the stopping criterion.

    :returns
    the final centroids.
    """
    centroids = np.array(data.takeSample(False, n_clusters))

    for i in range(max_iterations):

        new_centroids = data.map(lambda point: closest_centroid(point, centroids)) \
            .reduceByKey(sum_points) \
            .map(lambda centroid: np.array(centroid[1][0]) / centroid[1][1]) \
            .collect()

        new_centroids = np.array(new_centroids)

        if centroid_diff(centroids, new_centroids) < threshold:
            break

        centroids = new_centroids

    return centroids