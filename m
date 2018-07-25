Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:51872 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbeGYQeP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Jul 2018 12:34:15 -0400
Date: Wed, 25 Jul 2018 09:22:05 -0600
From: Rob Herring <robh@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 14/21] clk: jz4740: Add TCU clock
Message-ID: <20180725152205.GA6941@rob-hp-laptop>
References: <20180724231958.20659-1-paul@crapouillou.net>
 <20180724231958.20659-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724231958.20659-15-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jul 25, 2018 at 01:19:51AM +0200, Paul Cercueil wrote:
> Add the missing TCU clock to the list of clocks supplied by the CGU for
> the JZ4740 SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/clk/ingenic/jz4740-cgu.c       | 6 ++++++
>  include/dt-bindings/clock/jz4740-cgu.h | 1 +
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
