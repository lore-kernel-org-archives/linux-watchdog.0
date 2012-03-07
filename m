Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60505 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab2CGMVA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:21:00 -0500
Received: by wgbdr13 with SMTP id dr13so5507802wgb.1
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 04:20:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307111833.GQ17370@n2100.arm.linux.org.uk>
References: <cover.1331115751.git.viresh.kumar@st.com>
	<9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com>
	<20120307111833.GQ17370@n2100.arm.linux.org.uk>
Date: Wed, 7 Mar 2012 04:20:58 -0800
Message-ID: <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com>
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
From: viresh kumar <viresh.linux@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com,
	spear-devel@list.st.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/7/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Mar 07, 2012 at 03:57:55PM +0530, Viresh Kumar wrote:
>> @@ -156,10 +159,22 @@ static int mpcore_wdt_open(struct inode *inode,
>> struct file *file)

>> +		ret = clk_enable(wdt->clk);
>
> What about preparing the clock?
>

I missed that. Will update prepare/unprepare of clk across driver.

>> +	wdt->clk = clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(wdt->clk)) {
>> +		dev_warn(&pdev->dev, "Clock not found\n");
>> +		wdt->clk = NULL;
>
> Remove this line.

Actually this was very much intentional, so that i can do
    if (wdt->clk).

Also, this makes more sense as some platform doesn't support clk,
so it is not an error for them if clk_get() fails. And thus the check

    if (wdt->clk)                /* i.e. clock is supported or not */

make more sense than

    if (!IS_ERR(wdt->clk))             /* i.e. there is an error while
getting clock */

from readability point of view. So, i would like to keep it as it is.

>> @@ -399,6 +446,9 @@ static int mpcore_wdt_suspend(struct device *dev)
>>
>>  	if (test_bit(0, &wdt->timer_alive))
>>  		mpcore_wdt_stop(wdt);		/* Turn the WDT off */
>> +
>> +	if (wdt->clk)
>> +		clk_disable(wdt->clk);
>
> Same comments...  And what if the watchdog is not open?  Doesn't this
> disable an already disabled clock?
>

Yes, that'a a BUG. Will fix it.

--
viresh
