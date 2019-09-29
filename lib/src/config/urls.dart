// const BASE_API_URL = 'http://tabeldata.ip-dynamic.com/jaring-ummat';
// const BASE_API_UPLOADER_URL = 'http://tabeldata.ip-dynamic.com/jaring-ummat-uploader';

// const BASE_API_URL = 'http://139.162.15.91/jaring-ummat';
const BASE_API_URL = 'http://192.168.42.82:9091';
const BASE_API_UPLOADER_URL = 'http://139.162.15.91/uploader';

// Chat Api For Server Production Cloud
const BASE_API_CHATS = 'http://20.184.15.66:6061/hcare-chat';

// Web socket For Production Cloud
const WEBSOCKET_CHAT = 'ws://20.184.15.66:6061/hcare-chat/ws';

const UPLOADER_MEDIA_IMAGE = BASE_API_UPLOADER_URL + '/api/media/upload/image';

const CHATS_HISTORY = BASE_API_CHATS + '/api/chat/messages'; 

// VIRTUAL ACCOUNT
const REQUEST_VA_ANONIMOUS = 'http://117.53.47.34:8000/jaring-ummat-bni-request/api/bni/virtual-account/anonymous/request';
const REQUEST_VA_OAUTH = 'http://117.53.47.34:8000/jaring-ummat-bni-request/api/bni/virtual-account/secured/request';

// PEMBAYARAN
const PEMBAYARAN_URL = 'http://117.53.47.34:8000/jaring-ummat-bni-request/api/transaksi/customer/confirm';

// SMS OTP CODE
const OTP_SMS_URL = 'https://reguler.zenziva.net/apps/smsotp.php';

// CLOUDINARY 
const CLOUDINARY_URL = 'https://api.cloudinary.com/v1_1/';

// BASE REGISTER AND LOGIN_URL
const REGISTRATION_URL = BASE_API_URL + '/api/user/';
const LOGIN_URL = BASE_API_URL + '/oauth/token';
const USER_BY_ID_URL = BASE_API_URL + '/api/user/';
const FILE_PATH_SAVE = BASE_API_URL + '/api/filepath/save';

// BASE USER DETAILS
const USER_DETAILS_URL = BASE_API_URL + '/api/user/findByEmail';
const CHECK_REGISTRATION_EMAIL = BASE_API_URL + '/api/user/checkout';

// BASE STORY
const ALL_STORY_URL = BASE_API_URL + '/api/story/list';
const STORY_BY_ID_URL = BASE_API_URL + '/api/story/list/';

// For Service Program Amal API
const PROGRAM_AMAL_SAVE_URL = BASE_API_URL + '/api/program-amal/';
const PROGRAM_AMAL_LIST_ALL_URL = BASE_API_URL + '/api/program-amal/list/all';
const PROGRAM_AMAL_LIST_BY_CATEGORY_URL = BASE_API_URL + '/api/program-amal/list/category';
const PROGRAM_AMAL_FINDBYID_URL = BASE_API_URL + '/api/program-amal/';

// For Service Berita API
const BERITA_LIST_ALL_URL =  BASE_API_URL + '/api/berita/list';
const BERITA_LIST_ALL_BY_CATEGORY_URL = BASE_API_URL + '/api/berita/list/category';

// For Service LikeZone API
const SAVE_LIKE_URL = BASE_API_URL + '/api/like/';
const LIST_ALL_LIKE_URL = BASE_API_URL + '/api/like/list';
const LIST_USER_LIKE_PROGRAM = BASE_API_URL + '/api/like/program/list/user';
const LIST_USER_LIKE_BERITA = BASE_API_URL + '/api/like/berita/list/user';
const FINDBYID_LIKE_URL = BASE_API_URL + '/api/like/';
const UNLIKE_PROGRAM_URL = BASE_API_URL + '/api/like/unlikeProgramAmal';
const UNLIKE_BERITA_URL = BASE_API_URL + '/api/like/unlikeNews';

// URL for service CommentZone
const SAVE_COMMENT_URL = BASE_API_URL + '/api/comment/';
const LIST_ALL_COMMENT_URL = BASE_API_URL + '/api/comment/list';
const FINDBYID_COMMENT_URL = BASE_API_URL + '/api/comment/';
const LIST_ALL_COMMENT_NEWS_URL = BASE_API_URL + '/api/comment/news/';
const LIST_ALL_COMMENT_PROGRAM_AMAL_URL = BASE_API_URL + '/api/comment/program/';

// URL List Lembaga Amal
const LIST_ALL_LEMBAGA_AMAL = BASE_API_URL + '/api/lembaga-amal/list/popular';
const LIST_ALL_LEMBAGA_AMAL_BY_CATEGORY = BASE_API_URL + '/api/lembaga-amal/list/popular/category';
const LIST_ALL_LEMBAGA_AMAL_BY_FOLLOWED = BASE_API_URL + '/api/lembaga-amal/list/popular/byFollowed';

const LEMBAGA_AMAL_BY_EMAIL = BASE_API_URL + '/api/lembaga-amal/by-email';

// Follow Lembaga Amal
const FOLLOW_LEMBAGA_AMAL_URL = BASE_API_URL + '/api/account-amil/follow';
const UNFOLLOW_LEMBAGA_AMAL_URL = BASE_API_URL + '/api/account-amil/unfollow';

// POTOFOLIO
const PORTOFOLIO_PIE_CHART = BASE_API_URL + '/api/transaksi/zakat-sodaqoh/chart/pie';
const AKTIVITAS_TERBESAR_URL = BASE_API_URL + '/api/transaksi/muzakki/top';
const AKTIVITAS_TERBARU_URL = BASE_API_URL + '/api/transaksi/terakhir/muzakki';
const BAR_CHART_MUZAKKI = BASE_API_URL + '/api/transaksi/chart/bar';

// HISTORY TRANSACTION
const HISTORY_TRANSACTION = BASE_API_URL + '/api/transaksi/history/detail';

// GALANG AMAL DONATION LIST
const GALANG_AMAL_DONATION_LIST = BASE_API_URL + '/api/transaksi/donasi/detail';

// KALKULATOR ZAKAT
const KALKULATOR_ZAKAT_PROFESI = BASE_API_URL + '/api/zakat/profesi';
const MASTER_NILAI_ZAKAT_FITRAH = BASE_API_URL + '/api/zakat/nilai-beras';

// UPDATE
const UPDATE_LOKASI_AMAL = BASE_API_URL + '/api/user/update/lokasi-amal';
const UPDATE_USER_DETAILS = BASE_API_URL + '/api/user/update';