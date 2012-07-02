Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:50256 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755847Ab2GBStR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Jul 2012 14:49:17 -0400
Date: Mon, 2 Jul 2012 20:49:13 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Florian Fainelli <florian@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm63xx_wdt: fix driver section mismatch
Message-ID: <20120702184913.GR735@spo001.leaseweb.com>
References: <1340961284-25887-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1340961284-25887-1-git-send-email-florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Florian,

> bcm63xx_wdt was used as a platform_driver but was not suffixed with
> _driver, thus causing section mismatches, fix that.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Added to linux-watchdog-next.

Kind regards,
Wim.

