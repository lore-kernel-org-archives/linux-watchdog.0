Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:39325 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774Ab3J2HtG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Oct 2013 03:49:06 -0400
Date: Tue, 29 Oct 2013 08:49:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 8/9] watchdog: sp805_wdt: Remove unnecessary amba_set_drvdata()
Message-ID: <20131029074904.GE19704@spo001.leaseweb.com>
References: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com> <7a51da3b47e0dd14d9ad13853f649463dba9350f.1380793579.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a51da3b47e0dd14d9ad13853f649463dba9350f.1380793579.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Michal,

> Driver core clears the driver data to NULL after device_release
> or on probe failure, so just remove it from here.
> 
> Driver core change:
> "device-core: Ensure drvdata = NULL when no driver is bound"
> (sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

