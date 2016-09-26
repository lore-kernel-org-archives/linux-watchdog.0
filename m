Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46150 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034033AbcIZV6r (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Sep 2016 17:58:47 -0400
Date: Mon, 26 Sep 2016 22:58:33 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: sa11x0/pxa: get rid of get_clock_tick_rate
Message-ID: <20160926215833.GJ1041@n2100.armlinux.org.uk>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 19, 2016 at 09:12:15PM +0200, Robert Jarzmik wrote:
> The last user of this function is gone, so remove it. The clock API
> should now be used to get clock rates.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
