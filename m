Return-Path: <SRS0=PQIJ=P5=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773AC2F421
	for <linux-watchdog@archiver.kernel.org>; Mon, 21 Jan 2019 16:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93F52089F
	for <linux-watchdog@archiver.kernel.org>; Mon, 21 Jan 2019 16:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="L7nHpkZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfAUQd1 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:33:27 -0500
Received: from mail-eopbgr1410121.outbound.protection.outlook.com ([40.107.141.121]:62910
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbfAUQd1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ifetrclXgiPqW0cEmRQU63CP46Sa/UzWBTPj9iAkqo=;
 b=L7nHpkZg3+/4WkvYwG8Ygm4gEL+MKSJkHqxOieaqG8xSqcrHS4dIfuI6TSXvelNilbPXMHPfh6OH8sLqIqySYQtK1iHcERoeU+a3/8bf9xcGlHZBTTPjqFdjQADJsBecH7yy4Q98maCCc5qCkOoDvOu4+enjO8iY2I5+LGZQtOQ=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3829.jpnprd01.prod.outlook.com (20.178.97.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Mon, 21 Jan 2019 16:33:21 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::35e7:300c:a781:3ef6]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::35e7:300c:a781:3ef6%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 16:33:20 +0000
From:   Biju Das <biju.das@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a77470
 support
Thread-Topic: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a77470
 support
Thread-Index: AQHUbQrI5cMK0uIz20qcC8lgxacfN6U315cAgIKaczA=
Date:   Mon, 21 Jan 2019 16:33:20 +0000
Message-ID: <OSBPR01MB2103273E3B91A5AAD68A08D4B89F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1540544153-48098-1-git-send-email-biju.das@bp.renesas.com>
 <20181030135956.sofloch72mgsqi2o@verge.net.au>
In-Reply-To: <20181030135956.sofloch72mgsqi2o@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB3829;20:kSGL9RSnesu5DiGpK32h5juMPhuru4QJgTel/mvX4XQcVYQWLaFc/xuGj7fA5ga8VhLRf+FkVLP02BP9JUZbnXjFWkQ16mV1pGmnBpo+LRKz5GsVQ2dxQdi/y4E0UdEluht+j3OFW409dKbzST5vjOEziZArXRgRU1YAMXRTL0I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 73d81377-d287-4224-2f6e-08d67fbe27ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB3829;
x-ms-traffictypediagnostic: OSBPR01MB3829:
x-microsoft-antispam-prvs: <OSBPR01MB38297AFD2BCC637842CE687FB89F0@OSBPR01MB3829.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(136003)(366004)(346002)(376002)(396003)(13464003)(53754006)(199004)(189003)(6306002)(9686003)(6246003)(66066001)(97736004)(71200400001)(106356001)(2906002)(7696005)(76176011)(71190400001)(6436002)(81166006)(55016002)(25786009)(74316002)(305945005)(53936002)(8676002)(68736007)(81156014)(4326008)(8936002)(7736002)(110136005)(54906003)(44832011)(14454004)(86362001)(486006)(229853002)(478600001)(316002)(3846002)(6506007)(26005)(186003)(102836004)(53546011)(33656002)(99286004)(966005)(6116002)(11346002)(446003)(476003)(256004)(105586002)(14444005)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB3829;H:OSBPR01MB2103.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MUzGUpRZrWrWrHNVOw6lJc4wXG31elPqfRhtD7t4bGN4wVKO1W8X2MVA0yr1C4UbPLHd38sHy7QcfvpdICBFj2QWylwM9iKXc0NEsKJfh/NukagVLdEl5Q8017JDp4LXf1P0K+IZ7WPMDXPa+PL89iiWvA++HtEN4M6hWuco9igoL4v9k8g2s91HQSPQJTSIm/xthgmVCf/KwnEkcK+FFhB54JmcdNbB6orQkyYR9nFsQQPzHV+aWJEL+sX+G0i/We28CftGq77WUSptSWcBiWhl+TMtKk83H7cFOWf6H0k8JQ8xUwq+o9CNfFJGFT9ZnAw5LYl8n0BugzQnGN9dMGPebU9OZJwq5XmLyueNULnKTmD3qWSNVgzydKbKwwmF0GzF6gyywesM/rHbGSSpUg3+Xs+aSCQNT2fcBJN48Qs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d81377-d287-4224-2f6e-08d67fbe27ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 16:33:20.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3829
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi All,

Gentle reminder.

Are you happy with the below patch? Or do you want me to resend  patch with=
 the tags?

https://patchwork.kernel.org/patch/10657119/

regards,
Biju

> -----Original Message-----
> From: Simon Horman <horms@verge.net.au>
> Sent: 30 October 2018 14:00
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>; Guenter Roeck
> <linux@roeck-us.net>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document
> r8a77470 support
>
> On Fri, Oct 26, 2018 at 09:55:53AM +0100, Biju Das wrote:
> > RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car
> > Gen2, therefore add relevant documentation.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
