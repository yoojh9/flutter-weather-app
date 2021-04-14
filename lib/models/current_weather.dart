
class CurrentWeather{
    int id;
    String _description;
    String icon;
    int temp;
    int tempMin;
    int tempMax;

    set description(String description){
      _description = description;
    }

    get description {
      switch (this.id) {
        case 200: case 201: case 202: case 210: case 211: case 212: case 221: case 230: case 231: case 232: return '뇌우'; break;
        case 300: case 301: case 302: case 310: case 311: case 312: case 313: case 314: case 321: return '이슬비'; break;
        case 500: case 520: return '약간 비'; break;
        case 501: case 502: case 521: return '비'; break;
        case 503: case 522: return '많은 비'; break;
        case 504: case 531: return '폭우'; break;
        case 505: return '소나기'; break;
        case 511: return '우박'; break;

        case 600: case 620: return '약간 눈'; break;
        case 601: case 621: return '눈'; break;
        case 602: case 622: return '많은 눈'; break;
        case 611: case 612: case 613: return '진눈깨비'; break;
        case 615: case 616: return '비 또는 눈'; break;

        case 701: return '옅은 안개'; break;
        case 711: case 721: return '안개'; break;
        case 731: return '황사/먼지'; break;
        case 741: return '강한 안개'; break;
        case 751: return '황사'; break;
        case 761: return '먼지'; break;
        case 762: return '화산재'; break;
        case 771: return '돌풍'; break;
        case 781: return '토네이도'; break;

        case 800: return '맑음'; break;

        case 801: return '대체로 맑음'; break;
        case 802: return '약간 흐림'; break;
        case 803: return '구름 많음'; break;
        case 804: return '흐림'; break;

        default: return "-"; break;
      }
    }
  
}