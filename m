Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:40034 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3CAHuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 Mar 2013 02:50:54 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so5078014oag.25
        for <linux-watchdog@vger.kernel.org>; Thu, 28 Feb 2013 23:50:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207222927.GA28281@spo001.leaseweb.com>
References: <1358010851-28077-1-git-send-email-hauke@hauke-m.de>
	<20130207222927.GA28281@spo001.leaseweb.com>
Date: Fri, 1 Mar 2013 08:50:53 +0100
Message-ID: <CACna6ryAucJV_tdqH2fSAA+d7Es83B2s2Zk3Qehezk-FrzAO-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] watchdog: bcm47xx_wdt.c: add support for SoCs with PMU
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-watchdog@vger.kernel.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

2013/2/7 Wim Van Sebroeck <wim@iguana.be>:
> Hi Hauke
>
>> This patch series improves the functions for setting the watchdog
>> driver for bcm47xx based SoCs using ssb and bcma. This makes the
>> watchdog driver use the platform device provided by bcma or ssb.
>>
>> This code is currently based on the linux-watchdog/master tree by
>> Wim Van Sebroeck.
>
> V5 patches have been added to linux-watchdog-next.

Wim,

What is a state of this? I'm afraid we're about to miss another merge win=
dow :(

Btw. links to git repos at wiki page [0] are not working. I get
"Internal Server Error" on a gitweb page [1].

[0] http://www.linux-watchdog.org/
[1] http://www.linux-watchdog.org/cgi-bin/gitweb.cgi?p=3Dlinux-watchdog-n=
ext.git;a=3Dsummary

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
