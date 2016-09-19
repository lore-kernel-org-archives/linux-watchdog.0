Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35388 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbcISTsi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:48:38 -0400
Received: by mail-wm0-f51.google.com with SMTP id l132so170142296wmf.0
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Sep 2016 12:48:38 -0700 (PDT)
Subject: Re: [PATCH 2/4] ARM: sa11x0/pxa: acquire timer rate from the clock
 rate
To: Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4a9fbd3b-7250-20e3-02af-c8a15d10bfd8@linaro.org>
Date: Mon, 19 Sep 2016 21:48:35 +0200
MIME-Version: 1.0
In-Reply-To: <1474312335-20997-3-git-send-email-robert.jarzmik@free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 19/09/2016 21:12, Robert Jarzmik wrote:
> As both pxa and sa1100 provide a clock to the timer, the rate can be
> inferred from the clock rather than hard encoded in a functional call.
> 
> This patch changes the pxa timer to have a mandatory clock which is used
> as the timer rate.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
