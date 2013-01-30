Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33174 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753177Ab3A3TwO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Jan 2013 14:52:14 -0500
Date: Wed, 30 Jan 2013 20:52:12 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: ath79_wdt: convert to use devm_clk_get
Message-ID: <20130130195212.GA20513@spo001.leaseweb.com>
References: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Gabor

> Use the managed version of clk_get. This allows to
> simplify the probe/remove functions a bit.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>

All 3 patches added to linux-watchdog-next.

Kind regards,
Wim.

