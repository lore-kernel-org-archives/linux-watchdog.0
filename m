Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:60281 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161114Ab2CPDsN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Mar 2012 23:48:13 -0400
Message-ID: <4F62B7C4.7020702@st.com>
Date: Fri, 16 Mar 2012 09:17:16 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Linus WALLEIJ <linus.walleij@stericsson.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] watchdog/coh901327: convert to use watchdog core
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com> <20120307164240.GA1130@pengutronix.de> <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com> <20120315212705.GH10698@spo001.leaseweb.com>
In-Reply-To: <20120315212705.GH10698@spo001.leaseweb.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/16/2012 2:57 AM, Wim Van Sebroeck wrote:
> Hi Linus,
> 
>> On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>>
>>>>       case WDIOC_GETTIMELEFT:
>>>>               clk_enable(clk);
>>>>               /* Read repeatedly until the value is stable! */
>>>
>>> I was wondering if it pays to put this IOCTL to watchdog_dev and add another
>>> callback to watchdog_ops? I'd think so. Wim, Linus, what do you think?
>>
>> OK with me, shall I hack a patch?
> 
> I think Viresh did something allready.

You can find it here:

http://www.spinics.net/lists/arm-kernel/msg164285.html

-- 
viresh
