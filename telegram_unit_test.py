from mock import patch
import telegram_bot
import unittest


class TestIt1(unittest.TestCase):

    @patch('telegram_bot.postImage')
    def testPostImage(self, MockSomeClass):
        self.assertIs(telegram_bot.postImage, MockSomeClass)

    @patch('telegram_bot.postVideo')
    def testPostVideo(self, MockSomeClass):
        self.assertIs(telegram_bot.postVideo, MockSomeClass)


if __name__ == '__main__':
    unittest.main()
