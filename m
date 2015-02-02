Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:57851 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752461AbbBBX0K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Feb 2015 18:26:10 -0500
Date: Tue, 3 Feb 2015 00:26:09 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: rt2880_wdt: minor clean up
Message-ID: <20150202232609.GA17080@spo001.leaseweb.nl>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org> <1413489665-52342-2-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-2-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi John,

> Replace device_reset() with devm_reset_control_get() + reset_control_deassert().
> Make use of watchdog_init_timeout() instead of setting the timeout manually.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

This patch has been edded to linux-watchdog-next.

Kind regards,
Wim.

