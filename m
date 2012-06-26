Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42781 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751489Ab2FZTLL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jun 2012 15:11:11 -0400
Date: Tue, 26 Jun 2012 21:11:05 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jan Beulich <JBeulich@suse.com>
Cc: sameo@linux.intel.com, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org, asierra@xes-inc.com
Subject: Re: [PATCH] iTCO_wdt: add platform driver module alias
Message-ID: <20120626191105.GJ735@spo001.leaseweb.com>
References: <4FE4AE2C020000780008B78A@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FE4AE2C020000780008B78A@nat28.tlf.novell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jan

> The recent conversion of iTCO_wdt resulted in the driver no longer
> getting loaded automatically, since it no longer has a
> MODULE_DEVICE_TABLE() included. As the lpc_ich driver now creates a
> platform device, auto-loading can easily be done by having a respective
> module alias in place.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Aaron Sierra <asierra@xes-inc.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Added to linux-watchdog-next.

Kind regards,
Wim.

