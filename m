Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTwh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 15:52:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so21918438wmc.0
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Sep 2018 07:58:07 -0700 (PDT)
Date: Mon, 10 Sep 2018 15:58:02 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 01/24] mfd: Add ingenic-tcu.h header
Message-ID: <20180910145802.GV28860@dell>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180821171635.22740-2-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 21 Aug 2018, Paul Cercueil wrote:

> This header contains macros for the registers that are present in the
> regmap shared by all the drivers related to the TCU (Timer Counter Unit)
> of the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Notes:
>      v2: Use SPDX identifier for the license
>     
>      v3: - Use macros instead of enum
>          - Add 'TCU_' at the beginning of each macro
>     	 - Remove useless include <linux/regmap.h>
>     
>      v4: No change
>     
>      v5: No change
>     
>      v6: Rename barrier macro from __LINUX_CLK_INGENIC_TCU_H__ to
>          __LINUX_MFD_INGENIC_TCU_H__
>     
>      v7: No change
> 
>  include/linux/mfd/ingenic-tcu.h | 56 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/linux/mfd/ingenic-tcu.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
