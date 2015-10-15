Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53503 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbJOTy6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 15:54:58 -0400
Date: Thu, 15 Oct 2015 12:54:56 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Zhiqiang Hou <B48286@freescale.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, mark.rutland@arm.com,
	Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	bhupesh.sharma@freescale.com, leoli@freescale.com,
	wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net,
	mturquette@baylibre.com, Wenbin.Song@freescale.com
Subject: Re: [PATCH V3 5/6] clk: qoriq: Add ls1043a support.
Message-ID: <20151015195456.GT4558@codeaurora.org>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-6-git-send-email-B48286@freescale.com>
 <20151014183113.GE26883@codeaurora.org>
 <1444870621.5185.223.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1444870621.5185.223.camel@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/14, Scott Wood wrote:
> On Wed, 2015-10-14 at 11:31 -0700, Stephen Boyd wrote:
> > On 10/14, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <B48286@freescale.com>
> > > 
> > > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > > ---
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> 
> Could you ack my clock patchset that this depends on (if there are no 
> 
> objections)?  Mike Turquette acked the RFC version a while back, but it's 
> 
> changed a bit since then (including the new clk_get_num_parents() and 
> 
> clk_get_parent_by_index() -- I CCed Russell King on that but got no 
> 
> response), and got no response when I asked whether the ack was still good 
> 
> for v3.
> 
> 

Done. The consumer APIs look ok too, but I'd like to see if
Russell has any comments.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
