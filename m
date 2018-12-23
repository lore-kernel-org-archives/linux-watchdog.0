Return-Path: <SRS0=vFPV=PA=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E98C43444
	for <linux-watchdog@archiver.kernel.org>; Sun, 23 Dec 2018 15:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232EF2229F
	for <linux-watchdog@archiver.kernel.org>; Sun, 23 Dec 2018 15:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="N1bLAltG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbeLWP0i (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 23 Dec 2018 10:26:38 -0500
Received: from mail-eopbgr690101.outbound.protection.outlook.com ([40.107.69.101]:43267
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729116AbeLWP0i (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 23 Dec 2018 10:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcjSz3tAFHEJSw6/diRFIBzOrTirXTgXrVikdsYNioc=;
 b=N1bLAltGlrRz1vf3jfOSqU1dwHjZo6T2VjvnyL1JlejC/ay16dOFJv9N0cySJS5jtSmPB4vjqe9XQf3TKv/BQ1I93aF3z/UJre/HzdemXzlyUjCU/4zF/v2rR+iGWUbqcbOWPOZXU1YKOROqExPD+wxw4KH/ifnxRozYe2brcP0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHSPR01MB336.namprd22.prod.outlook.com (10.174.251.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Sun, 23 Dec 2018 15:26:33 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 15:26:33 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4] watchdog: mtx-1: Convert to use GPIO descriptor
Thread-Topic: [PATCH v4] watchdog: mtx-1: Convert to use GPIO descriptor
Thread-Index: AQHUmd8nuz6vx5q8UE6VapJBjdxyHaWMc/2A
Date:   Sun, 23 Dec 2018 15:26:33 +0000
Message-ID: <20181223152625.bbaa6o3gc6q2r7qo@pburton-laptop>
References: <20181222101231.19092-1-linus.walleij@linaro.org>
In-Reply-To: <20181222101231.19092-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB336;6:t6262S21LL3FBA+uxVZ21Nul2uv0qM73fXcSvhe5A1I4Aa5Y75TSLNuqtbSTOkTJyDLnvP6o1QZ3mBM+183PC7b9+SdF1SGMuV2vPFt6BXFzJnI1ZdSO2PfTlLVUOzjHtpH6U9HDzuzuB11//OMUrbda16pQ3OSEXs0E5oUzfF7wIQCpfxwfUY+q8EkENaB7UdykKeYFmY7OIxyhPAwoXJ8xUMZCpB5yIcaGlGBdRHSRjUfAt2UKxzhhAcIwZdwCBAzMQb/WVPSAIf88nEk7DuJpXFds1K357UDZEtmv7HTyjRi4L25+i6syiT44cZYvYH31q1g53InfLvhrU/o7wXTkAeKwUwsLqDfabb7OS42iMiuoDKYLG0KerBj9lRvFiE2VTQQpGF/8xw6CklvYa9s7OUucfWsGzpXyl+i4jQNUDW9VPfMGTZZ5eB5DpaeVGs9iU6Idv5g2eQt0W7Yu/g==;5:IgYsz4Y1dFBdg96Dr6LUnOGXqh+3YO93ejsZGp9ryX6UrBDfTc85I2NuKTN7B+ghsemDiL3gW1HdcR6hnY/iEmOKTLBS8fC6hQQqdBYGehFlYkPXINAiuZZzJYlIzFF8HtLgs69Vw8YFLC2ejIEpRYVCVLzIBKJyYlW1Q99JzZE=;7:JWnUU+TAk81uRdnajHwGFqZ3B3yzrtZ9M439HPVfGCsaAYKMorm5cqlPhO9cFnVSvnd+B1/nITTTiW5CaHWxJ1fpIhMsqdJjfN4h/oqnI8T6FaNre4HhJYUchQbtqe0pVLy4OafWoKuDYDqJCIhyTQ==
x-ms-office365-filtering-correlation-id: 8ad0853a-29cd-44ff-4e23-08d668eb04a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHSPR01MB336;
x-ms-traffictypediagnostic: MWHSPR01MB336:
x-microsoft-antispam-prvs: <MWHSPR01MB336768301CD7C5C4A1F77D8C1BA0@MWHSPR01MB336.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(3002001)(10201501046)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHSPR01MB336;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB336;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(136003)(39830400003)(366004)(346002)(54534003)(189003)(199004)(106356001)(68736007)(5660300001)(105586002)(305945005)(25786009)(4326008)(39060400002)(99286004)(71200400001)(71190400001)(58126008)(3846002)(6116002)(7736002)(52116002)(446003)(76176011)(316002)(54906003)(1076003)(256004)(11346002)(386003)(33896004)(6506007)(186003)(476003)(486006)(6916009)(6436002)(102836004)(6486002)(229853002)(33716001)(97736004)(26005)(2906002)(44832011)(8936002)(9686003)(53936002)(6246003)(6512007)(81166006)(81156014)(8676002)(14454004)(42882007)(66066001)(508600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB336;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5urBKrySqufcfhFAjU7uXV1MWuB9yJh+KQMn2Niiy39qI8KKzgnXJdDr7eYPFXG8CA6Y8jHHhih3DUpUqx+DMQD5YeWzQNBzLQGuhTeAfwct2/pyNEReEdiy4GWL/7Xag0XDX6Q728JwdbsHXvil1musmRQrGd0aG1sHr0spzc/tucDxoPa+xNZzVFBgPLwC4LtKjke3sFBhAPSyy5pdpIEW/L6a4D9Ubcjw9mdAOvssKIr4GZHt3Sg5EkvbKmmXNLxVyiZuzlNaOKtS3+YtTknTtVEhui58yUilnymS++tCA9QXxDc4XgWbMEVLdN+r
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <320562F142CED54A9FBE79D0F44B40ED@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad0853a-29cd-44ff-4e23-08d668eb04a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 15:26:33.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB336
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org
Message-ID: <20181223152633.fZF3d_SXmu2aYb6a1sIWEAKeu07bH7bmFRZIM-A_Qbk@z>

Hi Linus,

On Sat, Dec 22, 2018 at 11:12:31AM +0100, Linus Walleij wrote:
> This converts the MTX-1 driver to grab a GPIO descriptor
> associated with the device instead of using a resource with
> a global GPIO number. Augment the driver and the boardfile.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Collect Florian's Review-tag.
> - Cc MIPS maintainers. Please provide an ACK so that Guenther
>   can merge this into the watchdog tree!

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
