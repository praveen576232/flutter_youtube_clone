import 'package:youtube/youtube_api/api.dart';

const home_page_video_end_point =
    'https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=30&regionCode=IN&key=${API_KEY}';

const subscription =
    'https://www.googleapis.com/youtube/v3/subscriptions?part=snippet%2CcontentDetails&maxResults=250&mine=true&key=${API_KEY}';
