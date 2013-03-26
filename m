Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38628 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934359Ab3CZJbp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 05:31:45 -0400
Date: Tue, 26 Mar 2013 10:31:39 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86: Add basic support for the Congatec CGEB BIOS
 interface
Message-ID: <20130326093139.GL1906@pengutronix.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-2-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
 <20130326085454.GK1906@pengutronix.de>
 <20130326092435.GB8553@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130326092435.GB8553@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Tue, Mar 26, 2013 at 10:24:35AM +0100, Wolfram Sang wrote:
> Hi Sascha,
> 
> > Any other comments to this series? Is the base cgeb support ok to
> > include?
> 
> I had a few comments to the I2C driver.

Yes, thanks, I have seen this and will address them. Atm I'm more
interested in the base support though, since without it there won't be a
need for the i2c driver ;)

Regards
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
