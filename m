Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59683 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab2FMJGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Jun 2012 05:06:13 -0400
Received: by obbtb18 with SMTP id tb18so578195obb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Jun 2012 02:06:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F8E4C4C.5030702@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
	<4F83FEE0.8020709@st.com>
	<4F8E4C4C.5030702@st.com>
Date: Wed, 13 Jun 2012 10:06:12 +0100
Message-ID: <CAOh2x=kFZ8KemoqyczBqObwk=+qx0XL_FMQ-qwJvWK++631K_g@mail.gmail.com>
Subject: Re: [PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates
 & fixes
From: viresh kumar <viresh.linux@gmail.com>
To: "wim@iguana.be" <wim@iguana.be>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"sshtylyov@mvista.com" <sshtylyov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Wim,

On Wed, Apr 18, 2012 at 6:08 AM, Viresh Kumar <viresh.kumar@st.com> wrote=
:
> On 4/10/2012 3:05 PM, Viresh KUMAR wrote:
>> On 3/12/2012 9:51 AM, Viresh KUMAR wrote:
>>> Hello,
>>>
>>> This patchset contains fixes and updates for ARM watchdog drivers sp8=
05 and
>>> mpcore.
>>>
>>> Changes since V1:
>>> - Included patches for sp805 driver.
>>> - Removed: wdt->clk =3D NULL from mpcore driver, and use IS_ERR() to =
check if
>>> =A0 clock is supported or not.
>>> - Adapted to watchdog core for both the drivers.
>>> - two patches for watchdog core added
>>> - add patch to use __raw_readl{writel} instead of readl{writel}
>>> - taken care of few more review comments.
>>>
>>
>> Hi Wim,
>>
>> Have you applied patches left in this patchset for linux-next?
>
> Ping!!

You planned to push them in v-3.5. Isn't it?
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
