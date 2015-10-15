Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:48316
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751098AbbJOBMH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 21:12:07 -0400
Message-ID: <1444870621.5185.223.camel@freescale.com>
Subject: Re: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
From: Scott Wood <scottwood@freescale.com>
To: Stephen Boyd <sboyd@codeaurora.org>
CC: Zhiqiang Hou <B48286@freescale.com>,
	<linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <mark.rutland@arm.com>,
	<Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<bhupesh.sharma@freescale.com>, <leoli@freescale.com>,
	<wsa@the-dreams.de>, <wim@iguana.be>, <corbet@lwn.net>,
	<mturquette@baylibre.com>, <Wenbin.Song@freescale.com>
Date: Wed, 14 Oct 2015 19:57:01 -0500
In-Reply-To: <20151014183113.GE26883@codeaurora.org>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-6-git-send-email-B48286@freescale.com>
	 <20151014183113.GE26883@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2015-10-14 at 11:31 -0700, Stephen Boyd wrote:
> On 10/14, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <B48286@freescale.com>
> > 
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 

Could you ack my clock patchset that this depends on (if there are no 

objections)?  Mike Turquette acked the RFC version a while back, but it's 

changed a bit since then (including the new clk_get_num_parents() and 

clk_get_parent_by_index() -- I CCed Russell King on that but got no 

response), and got no response when I asked whether the ack was still good 

for v3.

-Scott

