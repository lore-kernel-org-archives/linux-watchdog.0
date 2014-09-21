Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:46009 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaIUPta (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 21 Sep 2014 11:49:30 -0400
Received: by mail-ig0-f178.google.com with SMTP id r10so1486225igi.11
        for <linux-watchdog@vger.kernel.org>; Sun, 21 Sep 2014 08:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140919154036.GA30723@roeck-us.net>
References: <1410878523-4924-1-git-send-email-wens@csie.org>
 <1410878523-4924-2-git-send-email-wens@csie.org> <541BB712.6020607@roeck-us.net>
 <CAGb2v67vB-mr1-fM7inWq7wntt31mYroEj-Hq7sMUfWDwV878w@mail.gmail.com> <20140919154036.GA30723@roeck-us.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 21 Sep 2014 23:49:09 +0800
Message-ID: <CAGb2v65X45dT91No-y8a9k-R557aGjXhbR4jTSdPhGE7FFTB1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] watchdog: sunxi: support parameterized compatible strings
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 19, 2014 at 11:40 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Sep 19, 2014 at 10:00:36PM +0800, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Fri, Sep 19, 2014 at 12:54 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On 09/16/2014 07:42 AM, Chen-Yu Tsai wrote:
>> >>
>> >> This patch adds support for hardware parameters tied to compatible
>> >> strings, so similar hardware can reuse the driver.
>> >>
>> >> This will be used to support the newer watchdog found in A31 and
>> >> later SoCs. Differences in the new hardware include separate
>> >> interrupt lines for each watchdog, and corresponding interrupt
>> >> control/status registers. Watchdog control registers were also
>> >> slightly rearranged.
>> >>
>> > You might also mention that you replace some iowrite32 with writel.
>>
>> Ah.... Had that in mind, but forgot about it when finishing the series :(
>>
>> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >
>> >
>> > Have you considered using regmap ? Seems to be an ideal candidate.
>>
>> I don't follow. Do you mean using regmap to share the interrupt registers
>> with the timer on sun4i? Otherwise I don't really see a difference.
>>
> Use regmap instead of direct writel. Nice thing about it is that regmap offers
> bit manipulation functions, so you could replace the read / mask / modify /write
> in a single regmap function call. See imx2_wdt.c for an example how it is used.
>
>> Am I missing something?
>>
> Not really. Just a suggestion.

As the register range and offsets are configurable, using regmap might add
more code than it saves. I'll keep the it the way it is for now.

>> >>
>> >> -       /* Enable timer and set reset bit in the watchdog */
>> >> -       writel(WDT_MODE_EN | WDT_MODE_RST_EN, wdt_base + WDT_MODE);
>> >> +       /* Set lowest timeout and enable watchdog */
>> >> +       val = readl(wdt_base + regs->wdt_mode);
>> >> +       val &= ~(WDT_TIMEOUT_MASK << regs->wdt_timeout_shift);
>> >> +       val |= WDT_MODE_EN;
>> >
>> >
>> > I think it would make sense to also define WDT_MODE_EN and
>> > WDT_TIMEOUT_MASK as configurable, even if not currently needed.
>> > It is odd to have the shift configurable but not the mask,
>> > and to have the mode register configurable but not the mode value.
>>
>> I think keeping these values constants clearly shows that they are
>> the same and shared among the hardware. Making them configurable
>> shouldn't impose much penalty, but I'd prefer to keep them as is
>> until we need to change them.
>>
> Ok, guess we have a different philosophy ;-). I'll leave it up to you.

:)

Thanks!
ChenYu
