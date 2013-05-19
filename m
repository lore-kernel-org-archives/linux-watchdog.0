Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:56159 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3ESRCH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 19 May 2013 13:02:07 -0400
Received: by mail-ea0-f179.google.com with SMTP id z16so3431929ead.10
        for <linux-watchdog@vger.kernel.org>; Sun, 19 May 2013 10:02:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2] ARM: sunxi: New watchdog driver for Allwinner A10/A13
From: Carlo Caione <carlo.caione@gmail.com>
In-Reply-To: <20130519153235.GC7717@lukather>
Date: Sun, 19 May 2013 19:01:54 +0200
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	=?iso-8859-1?Q?Henrik_Nordstr=F6m?= <henrik@henriknordstrom.net>
Message-Id: <F595BD7D-09B6-452A-B8FF-C7B667CE1DF8@gmail.com>
References: <1368903956-32388-1-git-send-email-carlo.caione@gmail.com> <20130519153235.GC7717@lukather>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable


On May 19, 2013, at 5:32 PM, Maxime Ripard <maxime.ripard@free-electrons.=
com> wrote:

> Hi Carlo,

Hi Maxime,

>> +
>> +#define WDT_CTRL                0x00
>> +#define WDT_CTRL_RESTART        (1 << 0)
>> +#define WDT_CTRL_RESERVED       (0x0a57 << 1)
>=20
> You didn't replied to me on that part in the previous mail. It doesn't
> seem to be needed, so why keeping it?

Actually I wrote you about this on irc (probably you were afk)
Anyway I tested the driver without using the 0x0a57 and without these bit=
s the watchdog is never successfully kicked.
I'm going to submit a v3 soon, addressing also the suggestions given by H=
enrik on linux-sunxi ml.

Regards,

--
Carlo Caione



--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
