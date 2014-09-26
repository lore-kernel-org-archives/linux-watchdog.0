Return-path: <wens213@gmail.com>
MIME-Version: 1.0
Sender: wens213@gmail.com
In-Reply-To: <541EFD9A.2000406@roeck-us.net>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
 <1411315519-26257-2-git-send-email-wens@csie.org> <541EFD9A.2000406@roeck-us.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 26 Sep 2014 16:29:18 +0800
Message-ID: <CAGb2v66dv4TRKB3LDksTudYPQThOV9NaEZDByZVSqedDOjekwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: sunxi: support parameterized compatible strings
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Sep 22, 2014 at 12:32 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
>>
>> This patch adds support for hardware parameters tied to compatible
>> strings, so similar hardware can reuse the driver.
>>
>> This will be used to support the newer watchdog found in A31 and
>> later SoCs. Differences in the new hardware include separate
>> interrupt lines for each watchdog, and corresponding interrupt
>> control/status registers. Watchdog control registers were also
>> slightly rearranged.
>>
>> Also replace ioread32()/iowrite32() with readl()/writel() in various
>> places changed.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Hi Guenter,

Are you submitting the restart handler patches for inclusion in 3.18?
If so, are you taking any related patches or patches depending on
that series?


Thanks
ChenYu
