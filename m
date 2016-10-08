Return-path: <wimvs@spo001.leaseweb.nl>
Date: Sat, 8 Oct 2016 16:05:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Brian Boylston <brian.boylston@hpe.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, nigel.croxon@hpe.com
Subject: Re: [PATCH] watchdog: hpwdt: add support for iLO5
Message-ID: <20161008140549.GE23290@spo001.leaseweb.nl>
References: <20160926185714.10866-1-brian.boylston@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160926185714.10866-1-brian.boylston@hpe.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Brian,

> iLO5 will offer the same watchdog timer as previous generations, but the
> PCI subsystem vendor ID will be PCI_VENDOR_ID_HP_3PAR (0x1590) instead of
> PCI_VENDOR_ID_HP (0x103c).  Add 0x1590 to the whitelist and be more
> specific when ignoring the 103c,1979 device.
> 
> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
> ---

This patch was added to linux-watchdog-next.

Kind regards,
Wim.
