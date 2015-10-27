Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0104.outbound.protection.outlook.com ([65.55.169.104]:10528
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751824AbbJ0Bt3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Oct 2015 21:49:29 -0400
Message-ID: <1445909666.701.289.camel@freescale.com>
Subject: Re: [PATCH V6 5/6] clk: qoriq: Add ls1043a support.
From: Scott Wood <scottwood@freescale.com>
To: Leo Li <pku.leo@gmail.com>
CC: Zhiqiang Hou <B48286@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Shaohui Xie <Shaohui.Xie@freescale.com>, <corbet@lwn.net>,
	Bhupesh Sharma <bhupesh.sharma@freescale.com>,
	<mturquette@baylibre.com>, <wsa@the-dreams.de>,
	<sboyd@codeaurora.org>, <wim@iguana.be>,
	Wenbin Song <Wenbin.Song@freescale.com>,
	Hu Vincent <Mingkai.Hu@freescale.com>, <linux@roeck-us.net>
Date: Mon, 26 Oct 2015 20:34:26 -0500
In-Reply-To: <CADRPPNSS62G3D8ghNjd1kJMSjXkQJ9bfqeTP_ZqMk2ehRN5iyw@mail.gmail.com>
References: <1445587282-29529-1-git-send-email-B48286@freescale.com>
	 <1445587282-29529-5-git-send-email-B48286@freescale.com>
	 <CADRPPNSS62G3D8ghNjd1kJMSjXkQJ9bfqeTP_ZqMk2ehRN5iyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2015-10-26 at 17:20 -0500, Leo Li wrote:
> On Fri, Oct 23, 2015 at 3:01 AM, Zhiqiang Hou <B48286@freescale.com> wrote:
> > From: Hou Zhiqiang <B48286@freescale.com>
> > 
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > V6: V5 V4 V3 V2
> >  - No change.
> 
> I know you mentioned the dependency in the summary of the patch
> series.  But it's not likely these dependencies will be merged through
> the ARM sub-maintainers tree and be resolved in this merge window.  So
> it will be better to mention these dependencies here so that this
> patch will go through the same tree as these dependency patches.
> 
> Scott,
> 
> What is your plan to merge the clock patches?  This patch need to go
> together with it.

See https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135565.html

-Scott

