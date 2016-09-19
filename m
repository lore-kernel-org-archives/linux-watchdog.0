Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35278 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcIST6P (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:58:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id l132so170572600wmf.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Sep 2016 12:58:15 -0700 (PDT)
Subject: Re: [PATCH 4/4] ARM: sa11x0/pxa: get rid of get_clock_tick_rate
To: Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <06a58a7f-63c1-b0a0-2b94-5805cc97b811@linaro.org>
Date: Mon, 19 Sep 2016 21:58:12 +0200
MIME-Version: 1.0
In-Reply-To: <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 19/09/2016 21:12, Robert Jarzmik wrote:
> The last user of this function is gone, so remove it. The clock API
> should now be used to get clock rates.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

