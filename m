Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:51161 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957Ab2DRFK0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 18 Apr 2012 01:10:26 -0400
Message-ID: <4F8E4C4C.5030702@st.com>
Date: Wed, 18 Apr 2012 10:38:28 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: "wim@iguana.be" <wim@iguana.be>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"w.sang@pengutronix.de" <w.sang@pengutronix.de>,
	"sshtylyov@mvista.com" <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates
 & fixes
References: <cover.1331524811.git.viresh.kumar@st.com> <4F83FEE0.8020709@st.com>
In-Reply-To: <4F83FEE0.8020709@st.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4/10/2012 3:05 PM, Viresh KUMAR wrote:
> On 3/12/2012 9:51 AM, Viresh KUMAR wrote:
>> Hello,
>>
>> This patchset contains fixes and updates for ARM watchdog drivers sp805 and
>> mpcore.
>>
>> Changes since V1:
>> - Included patches for sp805 driver.
>> - Removed: wdt->clk = NULL from mpcore driver, and use IS_ERR() to check if
>>   clock is supported or not.
>> - Adapted to watchdog core for both the drivers.
>> - two patches for watchdog core added
>> - add patch to use __raw_readl{writel} instead of readl{writel}
>> - taken care of few more review comments.
>>
> 
> Hi Wim,
> 
> Have you applied patches left in this patchset for linux-next?

Ping!!

-- 
viresh
