import bottle
import unittest
from boddle import boddle


class TestIt1(unittest.TestCase):

    def testPostImageNoParams(self):
        with boddle(path='/postImage'):
            self.assertRaises(bottle.HTTPError)

    def testPostImage(self):
        with boddle(path='/postImage'):
            with boddle(method='post', params={'filename': 'test.jpg'}):
                self.assertEqual(bottle.request.params['filename'], 'test.jpg')


if __name__ == '__main__':
    unittest.main()
