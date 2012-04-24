Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:36510 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757146Ab2DXTeU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 15:34:20 -0400
Date: Tue, 24 Apr 2012 21:34:17 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Viresh Kumar <viresh.kumar@st.com>
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
Subject: Re: [PATCH V2 17/22] watchdog/mpcore_wdt: use correct clk_rate to program timeout
Message-ID: <20120424193416.GG6553@spo001.leaseweb.com>
References: <cover.1331524811.git.viresh.kumar@st.com> <4d69b903be5a62ee88aa1017d5dcbf94bbe0dc8e.1331524811.git.viresh.kumar@st.com> <4F96837F.8030702@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F96837F.8030702@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Viresh,

> On 3/12/2012 9:52 AM, Viresh KUMAR wrote:
> > Currently, mpcore wdt driver doesn't use exact clk_rate to program timeout in
> > hardware. This patch provides two ways of doing so:
> > 	- either use clk_get_rate() if clk_get passes
> > 	- use clk_rate passed via module param
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> 
> Wim,
> 
> Will these go in v3.5?

Busy at the moment, but yes this should go in with the following merge window.

Kind regards,
Wim.

