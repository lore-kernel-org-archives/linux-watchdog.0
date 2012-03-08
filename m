Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60821 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab2CHGQM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 8 Mar 2012 01:16:12 -0500
Received: by iagz16 with SMTP id z16so249286iag.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 22:16:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307164240.GA1130@pengutronix.de>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
	<20120307164240.GA1130@pengutronix.de>
Date: Thu, 8 Mar 2012 07:16:11 +0100
Message-ID: <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
From: Linus Walleij <linus.walleij@linaro.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Linus Walleij <linus.walleij@stericsson.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:

>> =A0 =A0 =A0 case WDIOC_GETTIMELEFT:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read repeatedly until the value is stab=
le! */
>
> I was wondering if it pays to put this IOCTL to watchdog_dev and add an=
other
> callback to watchdog_ops? I'd think so. Wim, Linus, what do you think?

OK with me, shall I hack a patch?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
