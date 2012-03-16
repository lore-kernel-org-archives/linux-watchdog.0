Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61204 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161218Ab2CPIPg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Mar 2012 04:15:36 -0400
Received: by yhmm54 with SMTP id m54so3979736yhm.19
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Mar 2012 01:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120315212705.GH10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
	<20120307164240.GA1130@pengutronix.de>
	<CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
	<20120315212705.GH10698@spo001.leaseweb.com>
Date: Fri, 16 Mar 2012 09:15:35 +0100
Message-ID: <CACRpkdZ9tD8XQ3tOwTHMa3jOhivkwW7YZO0WZgG7r5BYDNktCQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 10:27 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Linus,
>
>> On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> w=
rote:
>>
>> >> =A0 =A0 =A0 case WDIOC_GETTIMELEFT:
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(clk);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read repeatedly until the value is s=
table! */
>> >
>> > I was wondering if it pays to put this IOCTL to watchdog_dev and add=
 another
>> > callback to watchdog_ops? I'd think so. Wim, Linus, what do you thin=
k?
>>
>> OK with me, shall I hack a patch?
>
> I think Viresh did something allready.

OK I rebased on top of Viresh's patch and sent them both out since
I don't know the status of his patch.

If you already have Viresh's patch in your tree just applying 2/2
should work as fine.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
