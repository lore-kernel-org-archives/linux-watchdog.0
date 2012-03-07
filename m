Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49635 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103Ab2CGM1u (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:27:50 -0500
Date: Wed, 7 Mar 2012 12:27:32 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com,
	spear-devel@list.st.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
Message-ID: <20120307122732.GS17370@n2100.arm.linux.org.uk>
References: <cover.1331115751.git.viresh.kumar@st.com> <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com> <20120307111833.GQ17370@n2100.arm.linux.org.uk> <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 07, 2012 at 04:20:58AM -0800, viresh kumar wrote:
> On 3/7/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Wed, Mar 07, 2012 at 03:57:55PM +0530, Viresh Kumar wrote:
> >> @@ -156,10 +159,22 @@ static int mpcore_wdt_open(struct inode *inode,
> >> struct file *file)
> 
> >> +		ret = clk_enable(wdt->clk);
> >
> > What about preparing the clock?
> >
> 
> I missed that. Will update prepare/unprepare of clk across driver.
> 
> >> +	wdt->clk = clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(wdt->clk)) {
> >> +		dev_warn(&pdev->dev, "Clock not found\n");
> >> +		wdt->clk = NULL;
> >
> > Remove this line.
> 
> Actually this was very much intentional, so that i can do
>     if (wdt->clk).

Drivers have no business interpreting anything but an IS_ERR() return from
clk_get() as invalid.  Everything else is the CLK APIs business, not the
driver's business.  So, to start using NULL as a special case is wrong.

