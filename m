Return-Path: <SRS0=Q29D=QW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97779C4360F
	for <linux-watchdog@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D45222A1
	for <linux-watchdog@archiver.kernel.org>; Fri, 15 Feb 2019 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="jeG8KeWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfBOT2S (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:28:18 -0500
Received: from mail-eopbgr700139.outbound.protection.outlook.com ([40.107.70.139]:52346
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBOT2S (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 15 Feb 2019 14:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMaF/28X3XGUsxNGr0B8eLBPogoldspC/yW5FnjM6ck=;
 b=jeG8KeWhmRGmcwtZfr3ZXEIySUQGImTVKOwDU4oaOVrMAexdICn6zkgiJUvET4T1PUlafW4/JV/vTuXuMGOmWsJeQ7Mwz1re0ApwNCz62g4IwJc7OlHD09GpUeM++peUHCxGQgOBYLbiRK4yIarEv1PBkGsV2DWAibe7CCM7kFw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1101.namprd22.prod.outlook.com (10.174.169.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 19:28:14 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 19:28:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Mehrtens, Hauke" <hauke.mehrtens@intel.com>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: print active stack on watchdog pre timeout for separate irq stack
Thread-Topic: print active stack on watchdog pre timeout for separate irq
 stack
Thread-Index: AdTERhkHQ/tMdayNR9+t+VaCObWnBgBHn3kA
Date:   Fri, 15 Feb 2019 19:28:13 +0000
Message-ID: <20190215192812.unoor5dudhvn2tgt@pburton-laptop>
References: <9231D502B07C5E4A8B32D5115C9F19991F89C484@IRSMSX108.ger.corp.intel.com>
In-Reply-To: <9231D502B07C5E4A8B32D5115C9F19991F89C484@IRSMSX108.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:a03:100::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6c173bb-5700-4871-fa1d-08d6937bba6a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1101;
x-ms-traffictypediagnostic: MWHPR2201MB1101:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1101;23:e6GT3P+PTifUS6UScZvY/V3Cq6H2LySLslNiC7u?=
 =?us-ascii?Q?A2V+qmzHwyraXsMGd5uCMpjM6bFU5RemmmNMu6RgeY/Ia2SJBmLMnf0DYyO8?=
 =?us-ascii?Q?ekabkkeVgikjWiYGSMYhDexrTs+MGberlfZcAexzJjMYYMXKE7mBpD8SpC44?=
 =?us-ascii?Q?Krsbp5Iy3A4E1vAXxleieHZilMOiBbd4k2hYIpiOSsXfDJ4MLrlnZASn/w2j?=
 =?us-ascii?Q?/+/45Ei7xOHnrYxqvzPr+Kgv2Xom/zVBa8rkijLK64UScIqaGoEo/Zzozso+?=
 =?us-ascii?Q?wW7W1DkYQodNA4SSXf6mcn3cSB9HpwoeKZXPQ4O3BHxsqai4FOWvF2/xdxxL?=
 =?us-ascii?Q?ccxoOu7rUftxo65VtkoN7VOzT2H4IQE71NvA1rzqBKfylZVwOm4mKZWQM+7q?=
 =?us-ascii?Q?rDKbOIMAUjwMcbuBIeeM4t1PqvyR22p7+f8axX3KzORX+7B6Bn4hOJZTJU7z?=
 =?us-ascii?Q?pJNP1CnT5KZRVshqWc7QHD8U4zGSZRNfmiWMlsZhj4nUzUzeOItzSjJ2vDmq?=
 =?us-ascii?Q?CsufxKdZkIiNmZfKAjAoFgd3IJq/nj5BHEcpcLFaCDaiHvnm869QXf8idi7H?=
 =?us-ascii?Q?Twzp0Edn87qVRM556URPmN8Msm/v8udT7ge1OcM2yyn64tDx7s0qkjJaVoiB?=
 =?us-ascii?Q?zyRNqOhsdFuUsCvJQsUthgGinnoZ6Lr2HUpRwBk1EMGZrzlGzq/KRD6IzgLM?=
 =?us-ascii?Q?fVsUkwgu4zZiarMY9vxfe2CP3out/jRQGfPYHxdkmNkK97+CXqbQEs/woAmE?=
 =?us-ascii?Q?rRG8kFxTIZGw2x9j+EGKaJONCPhy+5eaqkGqBCY6Uj8wwDM/nnp443mykKlQ?=
 =?us-ascii?Q?itZJUku2TArOTF06HP1zxziWsjk+OTfsn2wPjMOIgNM0emZrcw+XaN8rqJjq?=
 =?us-ascii?Q?Iuf9Bj/zD8+4YhF0Kp3Ek/WtcQOZbxlULLhQUFCntGQ89U+2k2NMTVD9onLV?=
 =?us-ascii?Q?SrQRhqRl402f1OVbISUG5vIk/jIiwqkVc34AEuYgkc3h3tcvRyib9WEAPKTY?=
 =?us-ascii?Q?2zWtOG2HRga0OAkmouNAqurs0KE1Ta+Jw5S50zDkurXm7O+fhlr5NoAg7NV5?=
 =?us-ascii?Q?wL3iWa6ACAsk+m+W/4ab0UZIy/3jmQSwLcoClc2fTW0bI/U4wOujEMZIWTEA?=
 =?us-ascii?Q?4WKS2PEclGxqxVCuWyDRFhhaWyFvw5UexbGkmhqGaE+gZoBlqgVIr6um7ux4?=
 =?us-ascii?Q?qU6WMQJ0u2PsOSH4SNRjF9wVDi1aWu0w48IPlFQRzyvNUrt1h+cT1ZVmQm+/?=
 =?us-ascii?Q?/HlbLQXuVHld+GE5AMQk/addE1ag0JLhl87dQJfzN?=
x-microsoft-antispam-prvs: <MWHPR2201MB11018738A7BE0ACE6EC6A10EC1600@MWHPR2201MB1101.namprd22.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(4326008)(186003)(54906003)(81156014)(8936002)(97736004)(81166006)(66066001)(99286004)(229853002)(8676002)(446003)(476003)(11346002)(6916009)(42882007)(6436002)(486006)(44832011)(2906002)(68736007)(6116002)(478600001)(256004)(1076003)(76176011)(71190400001)(71200400001)(386003)(14454004)(6506007)(305945005)(33716001)(58126008)(6246003)(7736002)(106356001)(26005)(52116002)(3846002)(9686003)(102836004)(6486002)(53936002)(25786009)(6512007)(33896004)(105586002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1101;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YZoSFzGgv6GXoZ8Ae15MtkDTRSvkllMi/hZRTf9nBMjTaxn4q0hGty300n+xTmZ4hLtNcPIuxlQul0X3ffMPlVAC6IqBMAcx2+0Gq8f/53ujTR1D6HI9GPRWtTlqwoBjEdGp/05ft46U3v7r8QdeLeTr6J4I2jOkgNUc4QcXe4038z00qRO9J1UEFDAXAV7XlFTxbBoQhNURzsFMVyzVU47qf+L2ta9TSc+7vbAFhAf5HyckxY9lxFhtye0BgmcZEYMX99Ijp1GW8zPgMyUNrycvcvYebwBx9H/cQmOtG2xqpZ6qAx0xb0cfkGFAZbGkLOfMt5DdFO8JdoG5O1nSEfe744VgxYak0H/nLSX57lRnBM/nNZwjgoZuzBuonmomPJeLaDsdgOaVQwRaZ5C+AXIBOD/295TV+mlaxc8S0Rc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27538D7972558942AACAACA9094A5B2F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c173bb-5700-4871-fa1d-08d6937bba6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 19:28:13.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1101
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi Hauke,

On Thu, Feb 14, 2019 at 09:27:17AM +0000, Mehrtens, Hauke wrote:
> We would like to print the stack of the currently active kernel thread
> from the interrupt handler when the watchdog pre timeout interrupt for
> our watchdog is triggered, currently we have a WARN_ONCE() in the code
> of the interrupt handler, but this only prints the interrupt stack,
> which is pretty boring. On MIPS the interrupts are handled on a
> separate stack and not on top of the stack of the current active
> kernel thread to avoid stack overflows. Is there some function which
> would print the stack trace of the current active kernel thread in
> addition or instead of the interrupt stack inside of an interrupt?
>%
> This was seen on kernel 4.9.109, but I am not aware of any changes in
> this area in the last few years.

What's meant to happen is that we unwind the interrupt stack, then once
we reach the end of that we jump over to the task stack & continue
unwinding there to obtain a complete stack trace.

That was added in v4.11 by commit db8466c581cc ("MIPS: IRQ Stack: Unwind
IRQ stack onto task stack"), and it looks like it was backported to v4.9
starting with v4.9.54 so you should have it already.

Could you take a look at the "if (unlikely(*sp =3D=3D irq_stack_high))"
check in unwind_stack_by_address() & see whether you hit it?

Thanks,
    Paul
