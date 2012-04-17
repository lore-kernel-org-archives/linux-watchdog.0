Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57459 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab2DQOvU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Apr 2012 10:51:20 -0400
Received: by gghe5 with SMTP id e5so3092277ggh.19
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Apr 2012 07:51:20 -0700 (PDT)
Message-ID: <4F8D8365.3020002@flameeyes.eu>
Date: Tue, 17 Apr 2012 07:51:17 -0700
From: =?UTF-8?B?RGllZ28gRWxpbyBQZXR0ZW7Dsg==?= <flameeyes@flameeyes.eu>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: Grant Likely <grant.likely@secretlab.ca>,
	guillaume ligneul <guillaume.ligneul@oselis.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Denis Turischev <denis@compulab.co.il>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC] IT87xx GPIO and other drivers
References: <4F8C7839.6060104@flameeyes.eu> <CACRpkdaOSSA8PuTSQ4utp9JHKbBiz+iWfuPn=2WyojZxsR5a3A@mail.gmail.com>
In-Reply-To: <CACRpkdaOSSA8PuTSQ4utp9JHKbBiz+iWfuPn=2WyojZxsR5a3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Il 16/04/2012 23:47, Linus Walleij ha scritto:
> I would suggest merging gpio-it87 and pinctrl-it87 into one driver
> in drivers/pinctrl-it87.c. I don't know for sure however, since it depe=
nds
> on hardware: usually these is a tight dependence between GPIO and
> pinctrl (IIRC this was the case with SuperIO), and then it often makes
> a lot of sense to create a composite driver, in order to just have one
> state container (cookie) to pass around in the functions, and to remap
> a register range only once.

So you mean having the MFD actually handle most of the work, and that's
it? If I did read the source correctly, that might actually work well,
as hwmon/it87 is only using the SuperIO for detection (which MFD can
take care of), while the others would be using the same functions to
read/write to the SuperIO registers.

Does that mean that when the user enables the MFD, they get gpio,
pinctrl and watchdog at once, or should it still have multiple Kconfig
entries which select it?

> The concept is explained in my pinctrl talk on a high level:
> http://www.df.lth.se/~triad/papers/pincontrol.pdf

Okay will read through it, thanks!

--=20
Diego Elio Petten=C3=B2 =E2=80=94 Flameeyes
flameeyes@flameeyes.eu =E2=80=94 http://blog.flameeyes.eu/
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
