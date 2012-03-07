Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36195 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab2CGMsI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:48:08 -0500
Date: Wed, 7 Mar 2012 12:47:51 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: viresh kumar <viresh.linux@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com,
	spear-devel@list.st.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 14/15] watchdog/mpcore_wdt: Add clock framework support
Message-ID: <20120307124751.GU17370@n2100.arm.linux.org.uk>
References: <cover.1331115751.git.viresh.kumar@st.com> <9ec7141baa4b1c1a0503893749e7ce0e19bb5029.1331115752.git.viresh.kumar@st.com> <20120307111833.GQ17370@n2100.arm.linux.org.uk> <CAOh2x==z1Mhc5k7qSJ++ix+TPaWcUfCKNdyfnzzZwiGO59Sudg@mail.gmail.com> <20120307122732.GS17370@n2100.arm.linux.org.uk> <CAOh2x=mCMdSVAGXtEg3=P8aJxc5kmk-UqDYeKLGnQZpUYu0DrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOh2x=mCMdSVAGXtEg3=P8aJxc5kmk-UqDYeKLGnQZpUYu0DrA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 07, 2012 at 04:37:12AM -0800, viresh kumar wrote:
> On 3/7/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > Drivers have no business interpreting anything but an IS_ERR() return from
> > clk_get() as invalid.  Everything else is the CLK APIs business, not the
> > driver's business.  So, to start using NULL as a special case is wrong.
> 
> But driver isn't comparing return value of clk_get with NULL (that would have
> been wrong) or interpreting its return value in a wrong way.

What if clk_get() returned NULL?

Hint: as far as _you_ are concerned as a driver writer, a struct clk is
an opaque cookie.  IS_ERR(clk) means the cookie is invalid.  Everything
else is potentially valid.  You must not interpret anything which is
potentially valid as some kind of special case.

> Instead it is using the same pointer/variable to check if clk_* APIs are
> supported or not by making it NULL. And that's a driver convention.

Bollocks it is.

Plain and simple NAK to this patch until clue is forthcoming.
