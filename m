Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1on0139.outbound.protection.outlook.com ([157.56.110.139]:42080
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757331AbbIUXN5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Sep 2015 19:13:57 -0400
Message-ID: <1442877225.19102.207.camel@freescale.com>
Subject: Re: [PATCH 6/6] dts/ls1043a: add LS1043ARDB board support
From: Scott Wood <scottwood@freescale.com>
To: Zhiqiang Hou <B48286@freescale.com>
CC: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <wsa@the-dreams.de>, <wim@iguana.be>,
	<corbet@lwn.net>, <mturquette@baylibre.com>,
	<sboyd@codeaurora.org>, <Mingkai.Hu@freescale.com>,
	<Shaohui.Xie@freescale.com>, <Wenbin.Song@freescale.com>,
	<bhupesh.sharma@freescale.com>, <leoli@freescale.com>
Date: Mon, 21 Sep 2015 18:13:45 -0500
In-Reply-To: <1442838158-2964-7-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
	 <1442838158-2964-7-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2015-09-21 at 20:22 +0800, Zhiqiang Hou wrote:

> +             cpld: board-control@2,0 {
> +                     compatible = "fsl,ls1043ardb-cpld", "simple-bus";
> +                     reg = <0x2 0x0 0x0000100>;
> +             };

Again, why "simple-bus"?

-Scott

