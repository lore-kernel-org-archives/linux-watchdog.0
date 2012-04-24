Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:57638 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab2DXKoQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 06:44:16 -0400
Message-ID: <4F96837F.8030702@st.com>
Date: Tue, 24 Apr 2012 16:12:07 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: "wim@iguana.be" <wim@iguana.be>
Cc: Viresh KUMAR <viresh.kumar@st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"sshtylyov@mvista.com" <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 17/22] watchdog/mpcore_wdt: use correct clk_rate to
 program timeout
References: <cover.1331524811.git.viresh.kumar@st.com> <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/12/2012 9:52 AM, Viresh KUMAR wrote:
> Currently, mpcore wdt driver doesn't use exact clk_rate to program timeout in
> hardware. This patch provides two ways of doing so:
> 	- either use clk_get_rate() if clk_get passes
> 	- use clk_rate passed via module param
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Wim,

Will these go in v3.5?

Please squash following with this patch while applying.

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 3690af3..e7cadc0 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -370,7 +370,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
                        TIMER_MARGIN);
        }
 
-       mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
+       mpcore_wdt_set_heartbeat(&wdt->wdd, mpcore_margin);
        dev_info(wdt->dev, "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d "
                        "mpcore_margin=%d sec (nowayout= %d)\n", mpcore_noboot,
                        mpcore_margin, nowayout);

-- 
viresh
