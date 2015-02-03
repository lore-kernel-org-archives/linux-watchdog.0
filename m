Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:59172 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965356AbbBCS5X (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 13:57:23 -0500
Date: Tue, 3 Feb 2015 19:57:21 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V3] watchdog: add MT7621 watchdog support
Message-ID: <20150203185721.GA2875@spo001.leaseweb.nl>
References: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413489665-52342-1-git-send-email-blogic@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi John,

> This patch adds support for the watchdog core found on newer mediatek/ralink
> Wifi SoCs.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>

Patch has been added to linux-watchdog-next. I removed the owner field in the platform_driver struct.

Kind regards,
Wim.

