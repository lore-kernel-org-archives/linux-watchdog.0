Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50974 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093Ab2CGMN7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:13:59 -0500
Received: by wibhm2 with SMTP id hm2so3317972wib.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 04:13:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307111711.GA31348@bnru02>
References: <cover.1331115751.git.viresh.kumar@st.com>
	<9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
	<20120307111711.GA31348@bnru02>
Date: Wed, 7 Mar 2012 04:13:57 -0800
Message-ID: <CAOh2x=mcaiSqYW7+9dsNoEhOazrud7BHp5095iqmrgy6iZ4utw@mail.gmail.com>
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
From: viresh kumar <viresh.linux@gmail.com>
To: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/7/12, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> wrote:
> On Wed, Mar 07, 2012 at 11:27:55 +0100, Viresh KUMAR wrote:
>> +	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
>> +			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
>> +
>
> I see that patch 12/15 does this, why are you doing it here again in clock
> patch?
>

>>
>> -	wdt->boot_status = (readl(wdt->base + TWD_WDOG_RESETSTAT) &
>> -			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
>> -
>
> oh, you delete this stuff here again.
>
> something messy in patch creation?

Yes. It does look messy. But it was intentional to move this code up
in the function.
Will move clk patch before IOCTL addition patch to make it clean.

--
viresh
