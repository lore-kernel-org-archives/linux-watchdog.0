Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36964 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab2DQGrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Apr 2012 02:47:18 -0400
Received: by yhmm54 with SMTP id m54so2881001yhm.19
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Apr 2012 23:47:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8C7839.6060104@flameeyes.eu>
References: <4F8C7839.6060104@flameeyes.eu>
Date: Tue, 17 Apr 2012 08:47:17 +0200
Message-ID: <CACRpkdaOSSA8PuTSQ4utp9JHKbBiz+iWfuPn=2WyojZxsR5a3A@mail.gmail.com>
Subject: Re: [RFC] IT87xx GPIO and other drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: =?ISO-8859-1?Q?Diego_Elio_Petten=F2?= <flameeyes@flameeyes.eu>
Cc: Grant Likely <grant.likely@secretlab.ca>,
	guillaume ligneul <guillaume.ligneul@oselis.com>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Jean Delvare <khali@linux-fr.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Denis Turischev <denis@compulab.co.il>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 9:51 PM, Diego Elio Petten=F2
<flameeyes@flameeyes.eu> wrote:

> The GPIO pins on most of the it87xx chips are also multi-function, and
> _should not_ be user-visible, but for some of them it might make sense
> to (for instance it should be possible to drive some of the LEDs on
> it8728f-based motherboards by replacing the functions of some PINs to G=
PIO).
>
> For what I can tell, it should probably be a good idea to have somethin=
g
> along these lines, but I'm _not_ a driver expert:
>
> =A0- mfd-it87xx: a platform driver, which probes the superio to check i=
t
> to be an it87xx chip, and then reserve resources for the other drivers;
> =A0- hwmon/it87: no longer probes autonomously for which chip it is, an=
d
> where it is;
> =A0- it87_wdt: ibidem;
> =A0- it8712_wdt: no clue about it, but I guess the same;
> =A0- gpio-it87: ibidem again;
> =A0- pinctrl-it87: abstracts support for the various pin-choice registe=
rs;
> =A0- led-it87: possibly to drive the power/network/hdd leds, akin to wh=
at
> happens with some laptops, and embedded systems.

I would suggest merging gpio-it87 and pinctrl-it87 into one driver
in drivers/pinctrl-it87.c. I don't know for sure however, since it depend=
s
on hardware: usually these is a tight dependence between GPIO and
pinctrl (IIRC this was the case with SuperIO), and then it often makes
a lot of sense to create a composite driver, in order to just have one
state container (cookie) to pass around in the functions, and to remap
a register range only once.

The concept is explained in my pinctrl talk on a high level:
http://www.df.lth.se/~triad/papers/pincontrol.pdf

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
