//
//  URLanalysis.m
//  1-新闻客户端
//
//  Created by qingyun on 16/1/11.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "URLanalysis.h"
#import "discourseViewController.h"

@implementation URLanalysis

- (NSString *)urlTouTiao
{
    _urlTouTiao = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=dd5b3f1667877791&loading_ad_timestamp=0&platfrom_version=4.2.1&behavior=manual&wm=b207&oldchwm=12030_0001&imei=864793025704805&pull_times=%ld&from=6049295012&connection_type=2&city=CHXX0165&chwm=12030_0001&AndroidID=ff46feb66e4b45325210ebfa0b69b402&v=1&IMEI=b4f82afbb7999f5d39dffe6616aa89db&replaced_flag=0&pull_direction=down&MAC=7334e26f5081e91d4c022d7452a7268e&channel=news_toutiao",_times];
        return _urlTouTiao;
}

- (NSString *)urlYuLe
{

    _urlYuLe = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=dd5b3f1667877791&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&oldchwm=12030_0001&imei=864793025704805&from=6049295012&connection_type=2&chwm=12030_0001&AndroidID=ff46feb66e4b45325210ebfa0b69b402&v=1&s=20&IMEI=b4f82afbb7999f5d39dffe6616aa89db&p=%ld&MAC=7334e26f5081e91d4c022d7452a7268e&channel=news_ent",_times];
    return _urlYuLe;
}

- (NSString *)urlTiYu
{

    _urlTiYu = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=dd5b3f1667877791&loading_ad_timestamp=0&platfrom_version=4.2.1&wm=b207&oldchwm=12030_0001&imei=864793025704805&from=6049295012&connection_type=2&chwm=12030_0001&AndroidID=ff46feb66e4b45325210ebfa0b69b402&v=1&s=20&IMEI=b4f82afbb7999f5d39dffe6616aa89db&p=%ld&MAC=7334e26f5081e91d4c022d7452a7268e&channel=news_sports",self.times];

    return _urlTiYu;
}

- (NSString *)urlCaiJing
{

    _urlCaiJing = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_finance",self.times];

    return _urlCaiJing;
}

- (NSString *)urlQiChe
{

    _urlQiChe = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&resolution=1152*1920&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&city_code=440100&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_auto",self.times];

    return _urlQiChe;
}

- (NSString *)urlSheHui
{

    _urlSheHui = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_sh",self.times];

    return _urlSheHui;
}

- (NSString *)urlNBA
{

    _urlNBA = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_nba",self.times];

    return _urlNBA;
}

- (NSString *)urlKeJi
{

    _urlKeJi = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_tech",self.times];

    return _urlKeJi;
}

- (NSString *)urlYouXi
{

    _urlYouXi = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_game",self.times];
    return _urlYouXi;
}

- (NSString *)urlJiaoYu
{

    _urlJiaoYu = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_edu",self.times];

    return _urlJiaoYu;
}

- (NSString *)urlBaGua
{

    _urlBaGua = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_gossip",self.times];

    return _urlBaGua;
}

- (NSString *)urlJianKang
{

    _urlJianKang = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_health",self.times];

    return _urlJianKang;
}

- (NSString *)urlShiShang
{

    _urlShiShang = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_fashion",self.times];

    return _urlShiShang;
}

- (NSString *)urlLiShi
{

    _urlLiShi = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_history",self.times];

    return _urlLiShi;
}

- (NSString *)urlShouCang
{

    _urlShouCang = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_collection",self.times];

    return _urlShouCang;
}

- (NSString *)urlJiaJu
{

    _urlJiaJu = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_home",self.times];

    return _urlJiaJu;
}

- (NSString *)urlBoKe
{
    _urlBoKe = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_blog",self.times];
    return _urlBoKe;
}

- (NSString *)urlXingZuo
{
    _urlXingZuo = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_ast",self.times];
    return _urlXingZuo;
}

- (NSString *)urlNvXing
{
    _urlNvXing = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_eladies",self.times];
    return _urlNvXing;
}

- (NSArray *)pathArr
{
    _pathArr = [NSArray arrayWithObjects:self.urlTouTiao, self.urlYuLe, self.urlSheHui, self.urlCaiJing, self.urlTiYu, self.urlNBA,
                 self.urlQiChe, self.urlKeJi, self.urlYouXi, self.urlJiaoYu,
                self.urlBaGua, self.urlJianKang, self.urlShiShang, self.urlLiShi, self.urlShouCang, self.urlJiaJu,
                self.urlBoKe, self.urlXingZuo, self.urlNvXing, nil];
    return _pathArr;
}

- (NSString *)urlGaoXiao
{
    _urlGaoXiao = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=41ecde5c80c03620&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&oldchwm=15006_0001&imei=866654027822656&from=6049295012&connection_type=2&chwm=15006_0001&AndroidID=fb6e0feb1aeb3506cd64d8381c55d7b8&v=1&s=20&IMEI=1f58224c5955957d5ef3dcec38381d6b&p=%ld&user_uid=5105428043&MAC=9fa67d2a76274f8764d05d3a78ed0763&channel=news_funny",self.GXtimes];
    return _urlGaoXiao;
}

@end
