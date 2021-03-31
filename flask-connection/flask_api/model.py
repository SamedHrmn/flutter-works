import cv2


def convert_image_to_grey(filepath):
    original_image = cv2.imread(filepath)
    gray_image = cv2.cvtColor(original_image, cv2.COLOR_BGR2GRAY)
    (thresh, blackAndWhiteImage) = cv2.threshold(gray_image, 127, 255, cv2.THRESH_BINARY)
    return blackAndWhiteImage
