Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns2.pc-advies.be ([83.149.101.18]:45482 "EHLO
        spo001.leaseweb.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755961AbcI0ToK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 27 Sep 2016 15:44:10 -0400
Date: Tue, 27 Sep 2016 21:13:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
Message-ID: <20160927191349.GA6564@spo001.leaseweb.nl>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr> <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Robert,

> The OS timer rate used for the watchdog can now be fetched from the
> standard clock API. This will remove the last user of
> get_clock_tick_rate() in both pxa and sa11x0 architectures.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.

