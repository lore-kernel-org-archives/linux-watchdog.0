Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:49514
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1VXp (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 17:23:45 -0400
Date: Tue, 28 Aug 2018 10:30:54 -0700
From: Paul Burton <paul.burton@mips.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 12/24] pwm: jz4740: Use regmap and clocks from TCU
 driver
Message-ID: <20180828173054.jlzczfxwjipdwntt@pburton-laptop>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-13-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Thierry,

On Tue, Aug 21, 2018 at 07:16:23PM +0200, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
> 
> It also provides us with clocks, that can be (un)gated, reparented or
> reclocked from devicetree, instead of having these settings hardcoded in
> this driver.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v5: New patch
>     
>      v6: Drop requirement of probing from devicetree
>     
>      v7: No change
> 
>  drivers/pwm/Kconfig      |   2 +
>  drivers/pwm/pwm-jz4740.c | 124 +++++++++++++++++++++++++++++++----------------
>  2 files changed, 83 insertions(+), 43 deletions(-)

How do patches 12-16 of this series look to you from a drivers/pwm
perspective?

If you're happy with them it'd be great to get an ack so I can take this
through the MIPS tree along with the rest of the series.

Thanks,
    Paul
