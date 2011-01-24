Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45707 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab1AXEGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 23 Jan 2011 23:06:13 -0500
Received: by iwn9 with SMTP id 9so3589747iwn.19
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Jan 2011 20:06:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110121180838.GO6768@pulham.picochip.com>
References: <1294675181-18273-1-git-send-email-jamie@jamieiles.com>
	<AANLkTikbxyCSX5eKiwtZyW+gYToTD7Jcucst6su2fEjN@mail.gmail.com>
	<20110121180838.GO6768@pulham.picochip.com>
Date: Mon, 24 Jan 2011 09:36:13 +0530
Message-ID: <AANLkTi=dm5FQciKjg=g-nTxYNH-BJEKVot5cAPnP2MJT@mail.gmail.com>
Subject: Re: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
From: viresh kumar <viresh.linux@gmail.com>
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 21, 2011 at 11:38 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> On Wed, Jan 12, 2011 at 10:46:28AM +0530, viresh kumar wrote:
>> > +       if (ret)
>> > +               goto out_put_clk;
>> > +
>> > +       /*
>> > +        * The timeout period of the watchdog is derived from the input clock
>> > +        * frequency.  For platforms that don't have a clk for the watchdog,
>> > +        * they can specify the WDT clock rate through the clk_rate field of
>> > +        * the struct dw_wdt_platform_data platform data.
>> > +        */
>> > +       if (pdata && pdata->clk_rate > 0)
>> > +               dw_wdt.clk_rate = pdata->clk_rate;
>> > +       else
>> > +               dw_wdt.clk_rate = clk_get_rate(dw_wdt.clk);
>> > +
>>
>> I know it doesn't make sense for a platform to have support for clk framework
>> and pass rate through plat data.
>> But this code will always take pdata->rate, if it is passed.
>> Wouldn't it be better if we reverse the sequence.
>>
>> if (clk)
>>  rate = clk_get_rate(...);
>> else {
>>  pdata = pdev->dev.platform_data;
>>  if (pdata)
>>   rate = pdata->rate;
>> }
>
> Hmm, looking back at this again, I wonder if the correct thing to do is
> just add a dependency in Kconfig for the driver on HAVE_CLK like
> drivers/spi/dw_spi_mmio and ditch the ability to set the rate through
> platform data?  The platform has to at least provide clk_get(),
> clk_put() and clk_get_rate() at a minimum or the driver won't even
> build...

Yes, this has to be done from compilation point of view, we need
HAVE_CLK in kconfig.

>
> This would make things a lot simpler and it's not as if this is going to
> break anything as there aren't currently any users of the driver (and
> the one that will be does support the clk framework).
>

Ok.
