Return-Path: <SRS0=+zyj=RO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A27C43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D472087C
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 21:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="p7a9+GO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCKV5O (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:57:14 -0400
Received: from relays-agent08.techservices.illinois.edu ([204.93.2.8]:53742
        "EHLO illinois.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727459AbfCKV5O (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 Mar 2019 17:57:14 -0400
X-Greylist: delayed 706 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 17:57:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=WzicGYoB6pcKmprwC+m03nG9IcVFX71oq7jqQMAGl7k=;
 b=p7a9+GO9wBwOlnrrBApkrRuac5yy9pmHnq66z99XpWRnxpzzE7IHcRGPxEWQjzjR21R3
 VIjGfSjFdY2XPG53Kx9g4SE44DfljinY3RHvhU5fOsscqhyHM7lmH3l2HI54b9yqRDVP
 FwrWcEnZKnLPM6YtMnqat+UggBZBr9ZbvBamIgEuQgWqBoMBhWkU81ZIr/a5i5lUUv+F
 U31D7nWp8BVLEtSBlo1p1MXMOYQNL+VITiyx0mDjpB8f9JAfCeE5wVcehb1ftr/IvJHR
 dq6oh157VOrFT4jzogsVmJIPjslnVGuQzQYMlgmVTXOfSh46J3MTW66nWC7ZjIYF6v3m Kg== 
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2050.outbound.protection.outlook.com [104.47.32.50])
        by relays-agent08.techservices.illinois.edu (8.16.0.27/8.16.0.27) with ESMTPS id x2BLjPbs019785
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-watchdog@vger.kernel.org>; Mon, 11 Mar 2019 16:45:26 -0500
Received: from BL0PR11MB3364.namprd11.prod.outlook.com (10.167.240.17) by
 BL0PR11MB3234.namprd11.prod.outlook.com (10.167.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 21:45:25 +0000
Received: from BL0PR11MB3364.namprd11.prod.outlook.com
 ([fe80::dd3c:1:edb5:2f05]) by BL0PR11MB3364.namprd11.prod.outlook.com
 ([fe80::dd3c:1:edb5:2f05%4]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 21:45:25 +0000
From:   "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>
To:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: watchdog: Missing Kconfig dependency for
 CONFIG_WATCHDOG_PRETIMEOUT_GOV and CONFIG_WATCHDOG_CORE
Thread-Topic: watchdog: Missing Kconfig dependency for
 CONFIG_WATCHDOG_PRETIMEOUT_GOV and CONFIG_WATCHDOG_CORE
Thread-Index: AQHU2FO7va7m+cCacEmA7U8mpXGULQ==
Date:   Mon, 11 Mar 2019 21:45:24 +0000
Message-ID: <00e44870397dd49a9c9989d6c22eabe650f5b9ca.camel@illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.126.255.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1756f71c-d392-48b2-c6d4-08d6a66ade91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR11MB3234;
x-ms-traffictypediagnostic: BL0PR11MB3234:
x-microsoft-antispam-prvs: <BL0PR11MB3234DBD4AE3264A2996FEC7BF3480@BL0PR11MB3234.namprd11.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(25786009)(786003)(86362001)(316002)(256004)(6436002)(8936002)(66066001)(97736004)(8676002)(68736007)(105586002)(106356001)(14454004)(118296001)(5660300002)(6486002)(71190400001)(75432002)(71200400001)(14444005)(26005)(6506007)(486006)(81166006)(476003)(7736002)(6916009)(186003)(6116002)(3846002)(99286004)(2501003)(36756003)(305945005)(81156014)(102836004)(2616005)(478600001)(2906002)(53936002)(2351001)(88552002)(6512007)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR11MB3234;H:BL0PR11MB3364.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: illinois.edu does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTDBQUjExTUIzMjM0OzIzOlZkQUhheE9XUSthbldER25qc0VQNkpkS1Bo?=
 =?utf-8?B?Wk9mYy82anhZY1VHVU02MllJRWhjckovZDBCQWtrcDBDSXlFNW9xaXZnb2R2?=
 =?utf-8?B?MmFIZVVobU11aUtLakV4T2JvU05mKzQ0b1ZyZHRNUjBFajRJUSsrei91UmNv?=
 =?utf-8?B?WkNMV29jSmJ0VEl3ejh2VkFSTW9YL3cwa290YmpKZkNTQ1ZDYUlRRitLcW5I?=
 =?utf-8?B?aWx6WkkwNGVUZkdVR3NrV0ZCYlVBVHM3OFh3TWFiUFlJbG9TTzN5KzhOWHk1?=
 =?utf-8?B?NlhNT1RUSE9UTllFNzZqckQyMzhvVmFFK2puazQ1NGcwdGRxUlRnd0FZOWJX?=
 =?utf-8?B?dktWbXBNK1ZvMDBNYVR2dTF3UTRRU1diUnJsZlZJT01SVVVuaFhpcjZnRFVV?=
 =?utf-8?B?UytTWmx0Nm1RT0NkR2FPMnc2OGNVMXBINEMzNWRtTklFSnlJd3ZnMHdQaGhF?=
 =?utf-8?B?N1dBSGIvTThUTmdHZUxsSnN4bHdYNEs3b2lrQStWd2JLNlVVQXlzSENOSHV1?=
 =?utf-8?B?ZWtsOWVxSFo2d0RzK2p0dlAyVWdpZ3B1Mk9BMEhheGNIbGg2LzM0NVpVUTEv?=
 =?utf-8?B?YkFoMUFmOWdzNjVJdENRN01ONUFlSmU3VTF6Y0ErUzdzUHlkSFZPSEtlZDUz?=
 =?utf-8?B?cVpPamNEWGtEeUdoK25xaGJ4QklSOWQ0cWlTaVB1Ri9zUkpoTkZWNUhjbjNk?=
 =?utf-8?B?N1ByK0YyazVjUlpyQXdNS21ubTZqSTVmMXZoSVpDaGU4UlllY1h2TStiZ1BQ?=
 =?utf-8?B?R0xucVdRbU96LzJnOHdHWHhBUCtaWGVDenRJVTNSTmswZkhFT1RNbzZ4QUt2?=
 =?utf-8?B?dFBZQ0Nrc1JzREZUM0JLMDZnNDdVaVVabGptbXJ3cTdlNkt2QXZrY2lOcGx2?=
 =?utf-8?B?d1RoNm8ybVdzeHhNbUw5ZHNGY0ZieGxibE4yZklocE9MNWk3bGRxTmVsUXI0?=
 =?utf-8?B?ZEY1SkY4dnRONHBnSGFhQXgzd1VrcWFFUkp6MVp3c01vTlY1UDYxZm9CQ2s5?=
 =?utf-8?B?bEhGNi94QXBkQU8yL0FGczlTQTNENmUySFdTSHVzOHN3Z2FQSHB6YWRKM2dH?=
 =?utf-8?B?U01odHFxcDlkOEhkQUFFL2h3QmFHOVBwRUVrOElCVWU1TXBzcVMra01KaTE2?=
 =?utf-8?B?WjdJbXdCT1o2enpPdmpDK3pKTE8wL0d5SFJKcHdZK2N6NURrN3RRUi9GTVJD?=
 =?utf-8?B?dVdmZFYzTEQ2WkRzMGExNTE0WnUwekFnbThuUmxrYXA3VEhESnJKc29PSXZP?=
 =?utf-8?B?VlhXNFB6bWI3cGZEd3ViRWx5VE5DSDJzeCtHbWQzNEhPL1BCdHhRTWJpdnRh?=
 =?utf-8?B?MUNuWGdPaFYxVTRCMHFXWmR3cGszalN2QzRXOHcvdjNtenRETjd0K2dKV0dC?=
 =?utf-8?B?WGhDaW4yK1pvMVRJbEhuMlgveUowR0hyQ3VVTU5OZG9CLzRWUXVkTkVjWEx5?=
 =?utf-8?B?ejlQUUR0ODNTY2IyakpNZTZleVNzWm9VKytwWmk3TGlvTFRnUXhvQUdhV3pi?=
 =?utf-8?B?UzQwaG9sYU1HTytEeHYrRWJGQmFiVjhGQnhrdlVaUktVeG9wOGtNSjdNMW9L?=
 =?utf-8?Q?i/SjSSOpbmHz8AmxU6y0ZbMu416doYM+CRMat5/Bz7L4=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R16MLEEYWCU+IXrBDfUuKtdoTQXIQfBQWnB0owJuDimDtXeVP0W2Of+/LP9HwU56Nsaevkr9s1kptHeBGhgSz9GcE5gcp4mXsLLdFDs5cqZXCLr1jqpYfFLcxvSlxwdhNzJB8VkmUXrqFWNxVG5BXl4IebhknIxLQFpgAMA8YFv67B+nfwzF51KBoTtFg8NVAFJbj5cUMZ3oFRWzFyMHqeXwn4xeI6Wq6X4mJdXiQuyiqTKN1D4wk8HiRqCPr7ZDoluyquG9+SZYM22SbmzsMpmFrhBgTRQyIYbToj5Q0PZ8JxTb95kaNfr9iR3Q65BpdKxECKw4TfyWbJnd6K/UASFUk/ht05CK88r6p9+C9b2zKeKWCKpVqJHbcz43Rxg1Hd1prCb8CBx1X7rXht6uPweNZ/pb4XoD5g36d4ymHFs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D139E056FDDC4B904116E9FF6A798B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1756f71c-d392-48b2-c6d4-08d6a66ade91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 21:45:24.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3234
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

SGksDQoNCkkgY29tcGlsZWQgbXkga2VybmVsIHdpdGggQ09ORklHX1dBVENIRE9HX1BSRVRJTUVP
VVRfR09WPXkgYW5kDQpDT05GSUdfV0FUQ0hET0dfQ09SRT1uIGFuZCBlbmNvdW50ZXJlZCBjb21w
aWxhdGlvbiBlcnJvcnMuIEkgbGF0ZXINCmZvdW5kIGluIHRoZSBNYWtlZmlsZSB0aGF0IGl0J3Mg
YmVjYXVzZSBDT05GSUdfV0FUQ0hET0dfQ09SRSBpcyBub3QNCmVuYWJsZWQgaGVuY2Ugd2F0Y2hk
b2cubyBpcyBub3QgY29tcGlsZWQsIGhvd2V2ZXIsIHRoZSBLY29uZmlnIG1pc3Nlcw0KdGhpcyBk
ZXBlbmRlbmN5LiBJIHNlbnQgdGhpcyBlbWFpbCB0byBjb25maXJtIGlmIHRoaXMgaXMgYSBidWcg
YW5kDQpob3BmdWxseSBzb21lb25lIGNhbiBmaXggaXQuDQoNClNuaXBwZXQgZm9yIHRoZSBNYWtl
ZmlsZQ0KYGBgDQojIE1ha2VmaWxlIGZvciB0aGUgV2F0Y2hEb2cgZGV2aWNlIGRyaXZlcnMuDQoj
DQoNCiMgVGhlIFdhdGNoRG9nIFRpbWVyIERyaXZlciBDb3JlLg0Kb2JqLSQoQ09ORklHX1dBVENI
RE9HX0NPUkUpICAgICs9IHdhdGNoZG9nLm8NCg0Kd2F0Y2hkb2ctb2JqcyAgICArPSB3YXRjaGRv
Z19jb3JlLm8gd2F0Y2hkb2dfZGV2Lm8NCg0Kd2F0Y2hkb2ctJChDT05GSUdfV0FUQ0hET0dfUFJF
VElNRU9VVF9HT1YpICAgICs9IHdhdGNoZG9nX3ByZXRpbWVvdXQubw0KDQpvYmotJChDT05GSUdf
V0FUQ0hET0dfUFJFVElNRU9VVF9HT1ZfTk9PUCkgICAgKz0gcHJldGltZW91dF9ub29wLm8NCm9i
ai0kKENPTkZJR19XQVRDSERPR19QUkVUSU1FT1VUX0dPVl9QQU5JQykgICAgKz0gcHJldGltZW91
dF9wYW5pYy5vDQpgYGANCg0KU25pcHBldCBmb3IgdGhlIEtjb25maWcNCmBgYA0KY29uZmlnIFdB
VENIRE9HX1BSRVRJTUVPVVRfR09WDQoJYm9vbCAiRW5hYmxlIHdhdGNoZG9nIHByZXRpbWVvdXQg
Z292ZXJub3JzIg0KCWhlbHANCgkgIFRoZSBvcHRpb24gYWxsb3dzIHRvIHNlbGVjdCB3YXRjaGRv
ZyBwcmV0aW1lb3V0IGdvdmVybm9ycy4NCmBgYA0KDQpDb21waWxhdGlvbiBlcnJvcnMNCmBgYA0K
bGQ6IGRyaXZlcnMvd2F0Y2hkb2cvcHJldGltZW91dF9ub29wLm86IGluIGZ1bmN0aW9uDQpgd2F0
Y2hkb2dfZ292X25vb3BfdW5yZWdpc3Rlcic6DQpwcmV0aW1lb3V0X25vb3AuYzooLmV4aXQudGV4
dCsweDgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQpgd2F0Y2hkb2dfdW5yZWdpc3Rlcl9nb3Zl
cm5vcicNCmxkOiBkcml2ZXJzL3dhdGNoZG9nL3ByZXRpbWVvdXRfbm9vcC5vOiBpbiBmdW5jdGlv
bg0KYHdhdGNoZG9nX2dvdl9ub29wX3JlZ2lzdGVyJzoNCnByZXRpbWVvdXRfbm9vcC5jOiguaW5p
dC50ZXh0KzB4ZCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCmB3YXRjaGRvZ19yZWdpc3Rlcl9n
b3Zlcm5vcicNCmxkOiBkcml2ZXJzL3dhdGNoZG9nL3ByZXRpbWVvdXRfcGFuaWMubzogaW4gZnVu
Y3Rpb24NCmB3YXRjaGRvZ19nb3ZfcGFuaWNfdW5yZWdpc3Rlcic6DQpwcmV0aW1lb3V0X3Bhbmlj
LmM6KC5leGl0LnRleHQrMHg4KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KYHdhdGNoZG9nX3Vu
cmVnaXN0ZXJfZ292ZXJub3InDQpsZDogZHJpdmVycy93YXRjaGRvZy9wcmV0aW1lb3V0X3Bhbmlj
Lm86IGluIGZ1bmN0aW9uDQpgd2F0Y2hkb2dfZ292X3BhbmljX3JlZ2lzdGVyJzoNCnByZXRpbWVv
dXRfcGFuaWMuYzooLmluaXQudGV4dCsweGQpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQpgd2F0
Y2hkb2dfcmVnaXN0ZXJfZ292ZXJub3InDQpgYGANCg0KVGhhbmsgeW91IQ0K
